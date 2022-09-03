-- $Id: localization.ru.lua 247 2017-05-12 17:08:38Z arith $ 
-- Thanks to Narumar and unw1s3
local L = LibStub("AceLocale-3.0"):NewLocale("Accountant_Classic", "ruRU", false)

if not L then return end
L["(%d+) Copper"] = "(%d+) |4медная монета:медные монеты:медных монет;"
L["(%d+) Gold"] = "(%d+) |4золотая:золотые:золотых;"
L["(%d+) Silver"] = "(%d+) |4серебряная:серебряные:серебряных;"
L["|cffffffff\"%s - %s|cffffffff\" character's Accountant Classic data has been removed."] = "|cffffffff\"%s - %s|cffffffff\" данные персонажей Accountant Classic были удалены."
L["A basic tool to track your monetary incomings and outgoings within WoW."] = "Основной инструмент для отслеживания ваших денежных доходах и расходах в WoW."
L["About"] = "Об Аддоне"
L["Accountant Classic"] = "Accountant Classic"
L["Accountant Classic Floating Info's Scale"] = "Масштаб Accountant Classic для плавающий информации"
L["Accountant Classic Floating Info's Transparency"] = "Прозрачность Accountant Classic для плавающий информации"
L["Accountant Classic Frame's Scale"] = "Рамка масштаба Accountant Classic"
L["Accountant Classic Frame's Transparency"] = "Рамка прозрачности Accountant Classic"
L["Accountant Classic loaded."] = "Accountant Classic загружен."
L["Accountant Classic Options"] = "Параметры Accountant Classic"
L["All Chars"] = "Все персонажи"
L["All Factions"] = "Все фракции"
L["All Servers"] = "Все сервера"
L["Also track subzone info"] = "Также отслеживать информацию о подзоне"
L["Are you sure you want to reset the \"%s\" data?"] = "Вы уверены, что хотите сбросить данные \"%s\" ?"
L["BINDING_HEADER_ACCOUNTANT_CLASSIC_TITLE"] = "Привязки Accountant Classic"
L["BINDING_NAME_ACCOUNTANT_CLASSIC_TOGGLE"] = "Крепление Accountant Classic"
L["c"] = " м. "
L["Character"] = "Персонаж"
L["Character Data's Removal"] = "Удаление данных персонажа"
L["Converts a number into a localized string, grouping digits as required."] = "Конвертирует числа в локализованную строку, группируя цифры по мере необходимости."
L["Data type to be displayed on LDB"] = "Тип данных, который будет отображаться на LDB"
L["Date format showing in \"All Chars\" and \"Week\" tabs"] = "Отображение формата даты в \"Все перс.\" и \"Неделя\" в вкладки"
L[ [=[Detected the conflicted addon - "|cFFFF0000Accountant|r" exists and loaded.
It has been disabled, click Okay button to reload the game.]=] ] = [=[Обнаружен конфликтующий аддон - "|cFFFF0000Accountant|r" был загружен.
Он был отключен, нажмите кнопку ОК, чтобы перезагрузить игру.]=]
L["Display Instruction Tips"] = "Показать советы по эксплуатации"
L["Done"] = "Готово"
L["Enable to also track on the subzone info. For example: Suramar - Sanctum of Order"] = "Включить, чтобы также отслеживать информацию о подзоне. Для примера: Сурамар - Святилище Порядка"
L["Enable to show all characters' money info from all factions. Disable to only show all characters' info from current faction."] = "Включить, чтобы показать информацию о всех персонажах всех фракций. Отключить отображение всех персонажей из текущей фракции."
L["Enable to show all characters' money info from all realms. Disable to only show current realm's character info."] = "Если включено, отображает информацию о золоте всех персонажей изо всех миров. Отключить, чтобы показывать только информацию о персонаже текущей мира."
L["Enable to track the location of each incoming / outgoing money and also show the breakdown info while mouse hover each of the expenditure."] = "Включить отслеживание расположения каждого входящего / исходящего золота, а также показать информацию о разбивке при наведении указателя мыши на каждый из расходов."
L["Enhanced Tracking Options"] = "Расширенные параметры отслеживания"
L["Exit"] = "Выход"
L["g "] = " зол. "
L["General and Data Display Format Settings"] = "Общие настройки и формат отображения данных"
L["Incomings"] = "Доходы"
L["LDB Display Settings"] = "Настройки дисплея LDB"
L["LDB Display Type"] = "Тип дисплея LDB"
L[ [=[Left-click and drag to move this button.
Right-Click to open Accountant Classic.]=] ] = [=[[ЛКМ] держите, чтобы переместить эту кнопку.
[ПКМ] для открытия Accountant Classic.]=]
L[ [=[Left-Click to open Accountant Classic.
Right-Click for Accountant Classic options.
Left-click and drag to move this button.]=] ] = [=[[ЛКМ] для открытия Accountant Classic.
[ПКМ], чтобы открыть настройки Accountant Classic.
Держите [ЛКМ], чтобы двигать эту кнопку.]=]
L["LFD, LFR and Scen."] = "LFD, LFR и Сцен."
L["Loaded Accountant Classic Profile for %s"] = "Загрузить профиль Accountant Classic для %s"
L["Mail"] = "Почта"
L["Main Frame's Scale and Alpha Settings"] = "Масштаб основной рамки и настройки прозрачности"
L["Merchants"] = "Торговцы"
L["Minimap Button Position"] = "Позиция на мини-карте"
L["Minimap Button Settings"] = "Настройки кнопки мини-карты"
L["Money"] = "Золото"
L["Net Loss"] = "Чистый убыток"
L["Net Profit"] = "Чистый доход"
L["Net Profit / Loss"] = "Чистая прибыль / Убыток"
L["New Accountant Classic profile created for %s"] = "Новый Accountant Classic профиль создан для %s"
L["Onscreen Actionbar's Scale and Alpha Settings"] = "Масштаб на экране панели действий и настройки прозрачности"
L["Options"] = "Параметры"
L["Outgoings"] = "Расходы"
L["Profile Options"] = "Параметры профиля"
L["Prv. Day"] = "Пред. день"
L["Prv. Month"] = "Пред. месяц"
L["Prv. Week"] = "Пред. неделя"
L["Prv. Year"] = "Пред. год"
L["Quest Rewards"] = "Награда за задание"
L["Remember character selected"] = "Запомнить выбранного персонажа"
L["Remember the latest character selection in dropdown menu."] = "Запомнить последнего, выбранного персонажа в раскрывающемся меню."
L["Repair Costs"] = "Затраты на ремонт"
L["Reset"] = "Сбросить"
L["Reset money frame's position"] = "Cбросить положение рамки золота"
L["Reset position"] = "Сброс позиции"
L["s "] = " сер. "
L["Scale and Transparency"] = "Масштаб и прозрачность"
L["Select the character to be removed:"] = "Выберите персонажа, который будет удален:"
L["Select the date format:"] = "Выберите формат даты:"
L["Show All Characters"] = "Показать всех персонажей"
L["Show all characters' incoming and outgoing data."] = "Показывать входящие и исходящие данные всех персонажей."
L["Show all factions' characters info"] = "Показать информацию персонажей всех фракций"
L["Show all realms' characters info"] = "Показать информацию о персонажах всех миров"
L["Show current session's net income / expanse instead of total money on LDB"] = "Показать чистую прибыль / расходы, на текущею сессию, вместо общих денег на LDB"
L["Show minimap button"] = "Показывать значок у мини-карты"
L["Show money"] = "Показать золото"
L["Show money on minimap button's tooltip"] = "Показывать золото в кнопки на мини-карте"
L["Show money on screen"] = "Показывать золото на экране"
L["Show net income / expanse on LDB"] = "Показывать чистый доход / расход на LDB"
L["Show session info"] = "Показать информацию о сеансе"
L["Show session info on minimap button's tooltip"] = "Показать информация о сеансе в подсказке кнопки на мини-карты"
L["Source"] = "Источник"
L["Start of Week"] = "Начало недели"
L["Sum Total"] = "Итого"
L["Taxi Fares"] = "Распорядитель полетов"
L[ [=[The selected character is about to be removed.
Are you sure you want to remove the following character from Accountant Classic?]=] ] = [=[Выбранный персонаж будет удален.
Вы уверены, что хотите удалить следующего персонажа из Accountant Classic?]=]
L["The selected character's Accountant Classic data will be removed."] = "Выбранные в Accountant Classic персонажи, данные будут удалены."
L["This Month"] = "Этот месяц"
L["This Session"] = "Эта сессия"
L["This Week"] = "Эта неделя"
L["This Year"] = "Этот год"
L["Today"] = "Cегодня"
L["Toggle whether to display minimap button or floating money frame's operation tips."] = "Переключение, отображения кнопки на мини-карте или всплывающие подсказки для операций с плавающей рамкой золота."
L["Total"] = "Все"
L["Total Incomings"] = "Всего доходов"
L["Total Outgoings"] = "Всего расходов"
L["Track location of incoming / outgoing money"] = "Отслеживание местоположения входящих / исходящих золотых"
L["Trade Window"] = "Обмен"
L["Training Costs"] = "Расходы на обучение"
L["Unknown"] = "Неизвестно откуда"
L["Updated"] = "Обновлено"
L["Week Start"] = "Начало недели"
L[ [=[You have manually called the function 
|cFF00FF00AccountantClassic_CleanUpAccountantDB()|r 
to clean up conflicted data existed in "Accountant". 
Now click Okay button to reload the game.]=] ] = [=[Функция была вызвана вручную 
|cFF00FF00AccountantClassic_CleanUpAccountantDB()|r 
Для устранения конфликтов данных, существующих в "Accountant". 
Теперь нажмите кнопку ОК, чтобы перезагрузить игру.]=]

