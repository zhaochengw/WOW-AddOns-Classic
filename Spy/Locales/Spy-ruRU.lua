local L = LibStub("AceLocale-3.0"):NewLocale("Spy", "ruRU")
if not L then return end
-- TOC Note: Обнаруживает и предупреждает вас о присутствии ближайших вражеских игроков.

-- Configuration
L["Spy"] = "Spy"
L["Version"] = "Версия"
L["Spy Option"] = "Spy"
L["Profiles"] = "Профили"

-- About
L["About"] = "Info"
L["SpyDescription1"] = [[
Spy это аддон, который будет предупреждать вас о присутствии рядом вражеских игроков.

]]

L["SpyDescription2"] = [[
|cffffd000 Nearby list |cffffffff
показывает всех встреченных врагов.  Игроки убираются из этого списка, если они более не встречались некоторое время.

|cffffd000 список последних час |cffffffff
отображаются все враги, обнаруженные за последний час

|cffffd000 список игнорируемых |cffffffff
Игроки, добавленные в список игнорируемых, не будут отслеживаться аддоном. Вы можете добавлять и удалять игроков из этого списка, используя выпадающее меню зажав Ctrl во время нажатия на кнопку.

|cffffd000 Kill On Sight list |cffffffff
При обнаружении игрока из вашего списка Kill On Sight вы услышите сигнал. Вы можете добавлять и удалять игроков из этого списка, используя выпадающее меню зажав Shift во время нажатия на кнопку. Выпадающее меню также можно использовать для добавления причины, по которой вы добавили кого-либо в список Kill On Sight. Если вы хотите ввести конкретную причину, которой нет в списке, используйте «Введите собственную причину ...» в списке Другие.

]]

L["SpyDescription3"] = [[
|cffffd000 Statistics Window |cffffffff
Окно статистики содержит список всех встреч врагов, которые можно отсортировать по имени, уровню, гильдии, победам, потерям и времени последнего обнаружения врага. Он также предоставляет возможность поиска конкретного врага по имени или гильдии и имеет фильтры, показывающие только тех врагов, которые отмечены как Kill on Sight, с победой / поражением или введенными причинами.

|cffffd000 Kill On Sight Button |cffffffff
Если эта кнопка включена, она будет расположена на целевом кадре врага. Нажатие на эту кнопку добавит / удалит вражескую цель в / из списка Kill on Sight. Правый клик по кнопке позволит вам ввести причины Kill on Sight.

|cffffd000 автор:|cffffffff Slipjack
]]

-- General Settings
L["GeneralSettings"] = "Общие настройки"
L["GeneralSettingsDescription"] = [[
Параметры, когда шпион включен или отключен.
]]
L["EnableSpy"] = "Включить Spy"
L["EnableSpyDescription"] = "Включить либо отключить Spy."
L["EnabledInBattlegrounds"] = "Включить Spy на полях боя"
L["EnabledInBattlegroundsDescription"] = "Включить либо отключить Spy пока вы на поле боя."
L["EnabledInArenas"] = "Включить Spy на аренах"
L["EnabledInArenasDescription"] = "Включить либо отключить Spy пока вы на арене."
L["EnabledInWintergrasp"] = "Включить Spy в мировой боевой зоне"
L["EnabledInWintergraspDescription"] = "Включить либо отключить Spy когда вы в мировой боевой зоне, например Озеро Ледяных Оков в Нордсколе."
L["DisableWhenPVPUnflagged"] = "Отключить Spy если у вас выключен PVP режим"
L["DisableWhenPVPUnflaggedDescription"] = "Включить либо отключить Spy в зависимости от вашего PVP статуса."
L["DisabledInZones"] = "Отключить Spy, находясь в этих местах"
L["DisabledInZonesDescription"]	= "Выберите места, где Spy будет отключен."
L["Booty Bay"] = "Пиратская Бухта"
L["Everlook"] = "Круговзор"						
L["Gadgetzan"] = "Прибамбасск"
L["Ratchet"] = "Кабестан"
L["The Salty Sailor Tavern"] = "Таверна \"Старый моряк\""
L["Shattrath City"] = "Шаттрат"
L["Area 52"] = "Зона 52"
L["Dalaran"] = "Даларан"
L["Dalaran (Northrend)"] = "Даларан (Нордскол)"
L["Bogpaddle"] = "Веслотопь"
L["The Vindicaar"] = "Виндикар"
L["Krasus' Landing"] = "Площадка Краса"
L["The Violet Gate"] = "Аметистовые врата"
L["Magni's Encampment"] = "Лагерь Магни"
L["Silithus"] = "Силитус"
L["Chamber of Heart"] = "Зал Сердца"
L["Hall of Ancient Paths"] = "Зал Древних Путей"
L["Sanctum of the Sages"] = "Святилище жрецов"
L["Rustbolt"] = "Ржавый болт"
L["Oribos"] = "Орибос"
L["Valdrakken"] = "Вальдраккен"

-- Display
L["DisplayOptions"] = "дисплей"
L["DisplayOptionsDescription"] = [[
Опции для окна SPY и всплывающих подсказок.
]]
L["ShowOnDetection"] = "Показать Spy, если вражеские игроки обнаружены"
L["ShowOnDetectionDescription"] = "SОтображение окна Spy и Nearby list, если Spy скрыт во время обнаружения врага."
L["HideSpy"] = "Скрыть Spy, если вражеские игроки не обнаружены"
L["HideSpyDescription"] = "Скрыть Spy если Nearby list включен для показа и пуст. Spy не будет скрыт, если вы очистите список вручную."
L["ShowOnlyPvPFlagged"] = "Показать только вражеских игроков, помеченных для PvP"
L["ShowOnlyPvPFlaggedDescription"] = "Показывать в Nearby list только врагов с включенным PvP флагом."
L["ShowKoSButton"] = "Показывать Kill On Sight кнопку на фрейме врага"
L["ShowKoSButtonDescription"] = "Установите это, чтобы показать кнопку Kill on Sight на целевом кадре вражеского игрока."
L["Alpha"] = "прозрачность"
L["AlphaDescription"] = "Установите прозрачность окна Spy."
L["AlphaBG"] = "Прозрачность на полях сражений"
L["AlphaBGDescription"] = "Установите прозрачность окна Spy на полях сражений."
L["LockSpy"] = "Зафиксировать окно Spy"
L["LockSpyDescription"] = "Блокирует окно Spy, чтобы оно не двигалось."
L["ClampToScreen"] = "Прикрепить к экрану"
L["ClampToScreenDescription"] = "Управляет возможностью перемещения окна Spy с экрана."
L["InvertSpy"] = "Инвертировать окно Spy"
L["InvertSpyDescription"] = "Переворачивает окно Spy вверх дном."
L["Reload"] = "Перезагрузить UI"
L["ReloadDescription"] = "Требуется при изменении окна Spy."
L["ResizeSpy"] = "Изменять размер окна Spy автоматически"
L["ResizeSpyDescription"] = "Автоматически измененять размер окна Spy, когда вражеские игроки добавляются и удаляются."
L["ResizeSpyLimit"] = "Предел списка"
L["ResizeSpyLimitDescription"] = "Ограничьте количество вражеских игроков, отображаемых в окне Spy."
L["DisplayTooltipNearSpyWindow"] = "Отображать всплывающую подсказку возле окна Spy"
L["DisplayTooltipNearSpyWindowDescription"] = "Выберите это, чтобы отобразить всплывающую подсказку рядом с окном SPY."
L["SelectTooltipAnchor"] = "Точка привязки всплывающей подсказки"
L["SelectTooltipAnchorDescription"] = "Выберите точку привязки для всплывающей подсказки, если предыдущая опция была включена."
L["ANCHOR_CURSOR"] = "Курсор"
L["ANCHOR_TOP"] = "Вверх"
L["ANCHOR_BOTTOM"] = "Низ"
L["ANCHOR_LEFT"] = "Лево"			
L["ANCHOR_RIGHT"] = "Право"
L["TooltipDisplayWinLoss"] = "Показывать статистику убийства/смертей в всплывающей подсказке"
L["TooltipDisplayWinLossDescription"] = "Выберите это, чтобы показать статистику убийств / смертей во всплывающей подсказке."
L["TooltipDisplayKOSReason"] = "Показывать причину Kill On Sight в всплывающей подсказке"
L["TooltipDisplayKOSReasonDescription"] = "Выберите это, чтобы показать причину Kill On Sight в подсказке."
L["TooltipDisplayLastSeen"] = "Показывать детали последней встречи"
L["TooltipDisplayLastSeenDescription"] = "Показывать время и местоположение о последней встречи в всплывающей подсказке."
L["DisplayListData"] = "Выберите данные противника для отображения"
L["Name"] = "имя"
L["Class"] = "Класс"
L["Rank"] = "Звание"
L["SelectFont"] = "Выберите Шрифт"
L["SelectFontDescription"] = "Выберите Шрифт для окна Spy."
L["RowHeight"] = "Выберите высоту строки"
L["RowHeightDescription"] = "Выберите высоту строки для окна Spy."
L["Texture"] = "текстура"
L["TextureDescription"] = "Выберите текстуру для окна шпиона."

-- Alerts
L["AlertOptions"] = "Оповещения"
L["AlertOptionsDescription"] = [[
Варианты оповещений, объявлений и предупреждений при обнаружении вражеских игроков.
]]
L["SoundChannel"] = "Выберите звуковой канал"
L["Master"] = "Общая громкость"
L["SFX"] = "Звук"
L["Music"] = "Музыка"
L["Ambience"] = "Мир"
L["Announce"] = "Отправить сообщать на:"
L["None"] = "Не сообщать"
L["NoneDescription"] = "Не предупреждать о встреченных врагах."
L["Self"] = "Для себя"
L["SelfDescription"] = "Сообщать о встреченных врагах только для игрока."
L["Party"] = "Группу"
L["PartyDescription"] = "Сообщать о встреченных врагах в канал группы."
L["Guild"] = "Гильдия"
L["GuildDescription"] = "Сообщать о встреченных врагах в канал гильдии."
L["Raid"] = "Рейд"
L["RaidDescription"] = "Сообщать о встреченных врагах в канал рейда."
L["LocalDefense"] = "Канал обороны"
L["LocalDefenseDescription"] = "Сообщать о встреченных врагах в канал обороны."
L["OnlyAnnounceKoS"] = "Только сообщать врагов в списке Kill on Sight"
L["OnlyAnnounceKoSDescription"] = "Выберите это, чтобы сообщать только о врагах в списке Kill On Sight."
L["WarnOnStealth"] = "Предупреждать о применении Незаметности"
L["WarnOnStealthDescription"] = "Предупреждать о входе врагов в Незаметность с помощью сообщения и звукового сигнала."
L["WarnOnKOS"] = "Предупреждать о обнаружении врага из списка Kill On Sight"
L["WarnOnKOSDescription"] = "Отображать предупреждение и подавать звуковой сигнал при обнаружении вражеского игрока в вашем списке Kill On Sight."
L["WarnOnKOSGuild"] = "Предупредить об обнаружении гильдии Kill On Sight"
L["WarnOnKOSGuildDescription"] = "Отображать предупреждение и подавать сигнал тревоги, когда обнаружен вражеский игрок из той же гильдии, что и кто-то из вашего списка Kill On Sight."
L["WarnOnRace"] = "Предупреждать об обнаружении нужной расы"
L["WarnOnRaceDescription"] = "Проигрывать сигнал тревоги при обнаружении выбранной расы"
L["SelectWarnRace"] = "Выберите расу для отслеживания"
L["SelectWarnRaceDescription"] = "Выберите расу для звукового предупреждения."
L["WarnRaceNote"] = "Примечание: Вы должны поразить врага хотя бы один раз, чтобы его раса могла быть добавлена в базу данных. При следующем обнаружении прозвучит предупреждение. Это не работает так же, как обнаружение ближайших врагов в бою."
L["DisplayWarningsInErrorsFrame"] = "Отображать предупреждения в рамке ошибок"
L["DisplayWarningsInErrorsFrameDescription"] = "Использовать фрейм ошибок для отображения предупреждений вместо использования графических всплывающих фреймов."
L["DisplayWarnings"] = "Выберите местоположение сообщения с предупреждением"
L["Default"] = "умолчанию"
L["ErrorFrame"] = "Ошибка кадра"
L["Moveable"] = "подвижной"
L["EnableSound"] = "Включить звуковые оповещения"
L["EnableSoundDescription"] = "Включить звуковые оповещения при обнаружении вражеских игроков. Разные оповещения звучат, если вражеский игрок получает скрытность или если вражеский игрок находится в списке Kill On Sight."
L["OnlySoundKoS"] = "Оповещать о враге из списка Kill On Sight только звуком"
L["OnlySoundKoSDescription"] = "Воспроизводить звуковые оповещения только при обнаружении вражеских игроков из списка Kill on Sight."
L["StopAlertsOnTaxi"] = "отключить оповещения, когда на пути полета"
L["StopAlertsOnTaxiDescription"] = "отключить все новые оповещения, когда на пути полета."

-- Nearby List
L["ListOptions"] = "Nearby List"
L["ListOptionsDescription"] = [[
Опции о том, как вражеские игроки добавляются и удаляются.
]]
L["RemoveUndetected"] = "Удалить вражеских игроков из Nearby List после:"
L["1Min"] = "1 минуты"
L["1MinDescription"] = "Удалять игрока из Nearby List если его видели более 1 минуты назад."
L["2Min"] = "2 минут"
L["2MinDescription"] = "Удалять игрока из Nearby List если его видели более 2 минуты назад."
L["5Min"] = "5 минут"
L["5MinDescription"] = "Удалять игрока из Nearby List если его видели более 5 минуты назад."
L["10Min"] = "10 минут"
L["10MinDescription"] = "Удалять игрока из Nearby List если его видели более 10 минуты назад."
L["15Min"] = "15 минут"
L["15MinDescription"] = "Удалять игрока из Nearby List если его видели более 15 минуты назад."
L["Never"] = "Никогда не удалять"
L["NeverDescription"] = "Никогда не удалять игроков. Nearby list может быть очищен вручную."
L["ShowNearbyList"] = "Переключаться на Nearby list при обнаружении противника"
L["ShowNearbyListDescription"] = "Отображать Nearby list если в нём ниодного врага."
L["PrioritiseKoS"] = "Расставьте приоритеты врагов Kill on Sight в Списке поблизости"
L["PrioritiseKoSDescription"] = "Всегда показывать врагов из Kill On Sight списка в верху Nearby List."

-- Map
L["MapOptions"] = "Карта"
L["MapOptionsDescription"] = [[
Параметры карты мира и миникарты, включая значки и всплывающие подсказки.
]]
L["MinimapDetection"] = "Включить обнаружение мини-карты"
L["MinimapDetectionDescription"] = "Если навести курсор на известных вражеских игроков, обнаруженных на миникарте, они будут добавлены в список «Ближайшие»."
L["MinimapNote"] = "          Примечание: работает только для игроков, которые могут отслеживать гуманоидов."
L["MinimapDetails"] = "Отображать уровень/класс в подсказках"
L["MinimapDetailsDescription"] = "Установите это, чтобы обновить всплывающие подсказки карты, чтобы детали уровня / класса отображались вместе с именами врагов."
L["DisplayOnMap"] = "Отображать значки на карте"
L["DisplayOnMapDescription"] = "Отображать значки карты для определения местоположения других пользователей Spy в вашей группе, рейде и гильдии, когда они обнаруживают врагов."
L["SwitchToZone"] = "Переключить карту на текущую зону при обнаружении врага"
L["SwitchToZoneDescription"] = "Если открыта карта мира зона просмотра автоматически переключится на текущую локацию при обнаружении врага."
L["MapDisplayLimit"] = "Ограничение отображения иконок на карте:"
L["LimitNone"] = "Везде"
L["LimitNoneDescription"] = "Отображает обнаруженных врагов вне зависимости от того в какой локации вы находитесь."
L["LimitSameZone"] = "Текущая зона"
L["LimitSameZoneDescription"] = "Отображает обнаруженных врагов только в пределах вашей текущей зоны."
L["LimitSameContinent"] = "Текущий континент"
L["LimitSameContinentDescription"] = "Отображает обнаруженных врагов только в пределах вашей текущего континента."

-- Data Management
L["DataOptions"] = "Управление данными"
L["DataOptionsDescription"] = [[

Варианты того, как Spy поддерживает и собирает данные.
]]
L["PurgeData"] = "Очистить запись игрока, если вы не видели их после:"
L["OneDay"] = "1 день"
L["OneDayDescription"] = "Очищать запись об игроке, если вы не встречали его 1 день."
L["FiveDays"] = "5 дней"
L["FiveDaysDescription"] = "Очищать запись об игроке, если вы не встречали его 5 дней."
L["TenDays"] = "10 дней"
L["TenDaysDescription"] = "Очищать запись об игроке, если вы не встречали его 10 дней."
L["ThirtyDays"] = "30 дней"
L["ThirtyDaysDescription"] = "Очищать запись об игроке, если вы не встречали его 30 дней."
L["SixtyDays"] = "60 дней"
L["SixtyDaysDescription"] = "Очищать запись об игроке, если вы не встречали его 60 дней."
L["NinetyDays"] = "90 дней"
L["NinetyDaysDescription"] = "Очищать запись об игроке, если вы не встречали его 90 дней."
L["PurgeKoS"] = "Очистить игроков Kill on Sight на основе необнаруженного времени"
L["PurgeKoSDescription"] = "Установите это, чтобы очистить игроков Kill on Sight, которые не были обнаружены, основываясь на настройках времени для необнаруженных игроков."
L["PurgeWinLossData"] = "Очистить данные о выигрышах / проигрышах на основе необнаруженного времени"
L["PurgeWinLossDataDescription"] = "Установите это, чтобы очистить данные о выигрышах / поражениях ваших вражеских столкновений на основе настроек времени для необнаруженных игроков."
L["ShareData"] = "Делиться данными с другими пользователями аддона Spy"
L["ShareDataDescription"] = "Установите это, чтобы поделиться информацией о встречах вашего вражеского игрока с другими пользователями Spy в вашей группе, рейде и гильдии."
L["UseData"] = "Использовать данные других пользователей Spy"
L["UseDataDescription"] = "Установите это, чтобы использовать данные, собранные другими пользователями Spy в вашей группе, рейде и гильдии."
L["ShareKOSBetweenCharacters"] = "Использовать общий список Kill On Sight для ваших персонажей"
L["ShareKOSBetweenCharactersDescription"] = "Использовать общий список Kill On Sight для ваших персонажей на этом сервере и фракции."

-- Commands
L["SlashCommand"] = "Слэш команды"
L["SpySlashDescription"] = "Эти кнопки выполняют те же функции, что и команды слэша /spy"
L["Enable"] = "Enable"
L["EnableDescription"] = "Включить Spy и показать главное окно."
L["Show"] = "Show"
L["ShowDescription"] = "Показать главное окно."
L["Hide"] = "Hide"
L["HideDescription"] = "Скрывает главное окно."
L["Reset"] = "Reset"
L["ResetDescription"] = "Сбросить позицию и показ главного окна."
L["ClearSlash"] = "Clear"
L["ClearSlashDescription"] = "Очистить Nearby List."
L["Config"] = "Config"
L["ConfigDescription"] = "Открыть окно настроек аддона Spy."
L["KOS"] = "KOS"
L["KOSDescription"] = "Добавить/удалить игрока в/из список Kill On Sight."
L["InvalidInput"] = "Неверный Ввод"
L["Ignore"] = "Ignore"
L["IgnoreDescription"] = "Добавить/удалить игрока в/из список игнорируемых."
L["Test"] = "Test"
L["TestDescription"] = "Отображает предупреждение, чтобы вы могли изменить его положение."

-- Lists
L["Nearby"] = "Nearby"
L["LastHour"] = "Последний час"
L["Ignore"] = "Игнорировать"
L["KillOnSight"] = "Kill On Sight"

--Stats
L["Won"] = "Побед"
L["Lost"] = "Поражений"
L["Time"] = "Время"	
L["List"] = "В списке"
L["Filter"] = "Фильтр"
L["Show Only"] = "Показывать только"
L["Realm"] = "Игровой мир"
L["KOS"] = "KOS"
L["Won/Lost"] = "Побед/Поражений"
L["Reason"] = "Причина"	 
L["HonorKills"] = "Почетные убийства"
L["PvPDeaths"] = "Смерти в PvP"

-- Output messages
L["VersionCheck"] = "|cffc41e3aПредупреждение! Неправильная версия Spy установлена. Эта версия предназначена для Wrath of the Lich King - Classic."
L["SpyEnabled"] = "|cff9933ffSpy аддон включен."
L["SpyDisabled"] = "|cff9933ffSpy аддон отключен. Напишите |cffffffff/spy show|cff9933ff  для включения."
L["UpgradeAvailable"] = "|cff9933ffA Новая версия Spy доступна для скачивания. Вы можете загрузить её тут:\n|cffffffffhttps://www.curseforge.com/wow/addons/spy-wotlk"
L["AlertStealthTitle"] = "Обнаружен игрок в невидимости!"
L["AlertKOSTitle"] = "Обнаружен враг из списка Kill On Sight!"
L["AlertKOSGuildTitle"] = "Обнаружен враг из гильдии в списке Kill On Sight!"
L["AlertTitle_kosaway"] = "Враг из списка Kill On Sight был замечен "
L["AlertTitle_kosguildaway"] = "Враг из гильдии в списке Kill On Sight был замечен "
L["StealthWarning"] = "|cff9933ffОбнаружен игрок в невидимости: |cffffffff"
L["KOSWarning"] = "|cffff0000Обнаружен враг из списка Kill On Sight: |cffffffff"
L["KOSGuildWarning"] = "|cffff0000Обнаружен враг из гильдии в списке Kill On Sight: |cffffffff"
L["SpySignatureColored"] = "|cff9933ff[Spy] "
L["PlayerDetectedColored"] = "Обнаружен враг: |cffffffff"
L["PlayersDetectedColored"] = "Обнаружены враги: |cffffffff"
L["KillOnSightDetectedColored"] = "Обнаружен враг из списка Kill On Sight: |cffffffff"
L["PlayerAddedToIgnoreColored"] = "Игрок добавлен в список игнорируемых: |cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "Игрок удален из списка игнорируемых: |cffffffff"
L["PlayerAddedToKOSColored"] = "Игрок добавлен в список Kill On Sight: |cffffffff"
L["PlayerRemovedFromKOSColored"] = "Игрок удален из списка Kill On Sight: |cffffffff"
L["PlayerDetected"] = "[Spy] Обнаружен враг: "
L["KillOnSightDetected"] = "[Spy] Обнаружен враг из списка Kill On Sight: "
L["Level"] = "Уровень"
L["LastSeen"] = "Последняя встреча"
L["LessThanOneMinuteAgo"] = "меньше минуты назад"
L["MinutesAgo"] = "минут назад"
L["HoursAgo"] = "часов назад"
L["DaysAgo"] = "дней назад"
L["Close"] = "Закрыть"
L["CloseDescription"] = "|cffffffffПрячёт окно Spy. По умолчанию оно появится снова когда вы обнаружете врага."
L["Left/Right"] = "Влево/Вправо"
L["Left/RightDescription"] = "|cffffffffПерещает между списками Nearby, Встреченно за последний час, Игнорирования и Kill On Sight."
L["Clear"] = "Очистить"
L["ClearDescription"] = "|cffffffffОчищает список обнаруженных игроков. CTRL-Клик включит/отключит Spy. Shift-Клик влючит/отключит все звук."
L["SoundEnabled"] = "Звуковые оповещения включены"
L["SoundDisabled"] = "Звуковые оповещения отключены"
L["NearbyCount"] = "Враги поблизости"
L["NearbyCountDescription"] = "|cffffffffЧисло врагов поблизости."
L["Statistics"] = "Статистика"
L["StatsDescription"] = "|cffffffffПоказывает список встреченных врагов, победы/поражения и где вы их последний раз видели."
L["AddToIgnoreList"] = "Добавить в список игнорируемых"
L["AddToKOSList"] = "Добавить в список Kill On Sight"
L["RemoveFromIgnoreList"] = "Удалить из списка игнорируемых"
L["RemoveFromKOSList"] = "Удалить из списка Kill On Sight"
L["RemoveFromStatsList"] = "Удалить из списка статистики"   
L["AnnounceDropDownMenu"] = "Сообщить в канал"
L["KOSReasonDropDownMenu"] = "Добавить причину добавления в список Kill On Sight"
L["PartyDropDownMenu"] = "Группу"
L["RaidDropDownMenu"] = "Рейд"
L["GuildDropDownMenu"] = "Гильдию"
L["LocalDefenseDropDownMenu"] = "Локальную Оборону"
L["Player"] = " (Игрок)"
L["KOSReason"] = "Kill On Sight"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "Введите собственную причину ..."
L["KOSReasonClear"] = "Очистить"
L["StatsWins"] = "|cff40ff00Победы: "
L["StatsSeparator"] = "  "
L["StatsLoses"] = "|cff0070ddпроигрыши: "
L["Located"] = "обнаруженный:"
L["Yards"] = "метры"
L["LocalDefenseChannelName"] = "ОборонаЛокальный" 

Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
	[1] = {
		["title"] = "Начал сражение";
		["content"] = {
			"Атаковал меня без причины",
			"Атаковал меня у квестодателя", 
			"Атаковал меня когда я сражался с НПЦ",
			"Атаковал меня около подземелья",
			"Атаковал меня когда я был АФК",
			"Атаковал меня когда я бы на маунте/в полёте",
			"Атаковал меня когда я бы с низким запасом ХП/маны",
		};
	},
	[2] = {
		["title"] = "Стиль сражения";
		["content"] = {
			"Напал из засады",
			"Всегда атакует меня при встрече",
			"Убил меня персонажем высокого уровня",
			"Убил меня с группой врагов",
			"Не атакует без поддержки",
			"Всегда зовёт помощь",
			"Использует слишком много эффектов контроля",
		};
	},
	[3] = {
		["title"] = "Засада";
		["content"] = {
			"Устроил мне засаду",
			"Устроил засаду альту",
			"Устроил засаду малышам",
			"Устроил засаду из невидимости",
			"Устроил засаду на члена гильдии",
			"Устроил засаду на НПЦ/объект задания",
			"Устроил засаду в городе/поселении",
		};
	},
	[4] = {
		["title"] = "При выполнении заданий";
		["content"] = {
			"Атаковал меня когда я делал задания",
			"Атаковал меня после того как я помог с заданием",
			"Вмешался в выполнение задания",
			"начал квест, который я хотел сделать",
			"Убил НПЦ моей фракции",
			"Убил квестового НПЦ",
		};
	},
	[5] = {
		["title"] = "Украл ресурсы";
		["content"] = {
			"Собрал нужную мне траву",
			"Собрал нужную мне руду",
			"Собрал нужные мне ресурсы",
			"Убил меня и забрал себе мою цель/редкого НПЦ",
			"Снимал шкуры с убитых мною животных",
			"Забрал мою награду",
			"Рыбачил в моей лунке",
		};
	},
	[6] = {
		["title"] = "Прочее";
		["content"] = {
			"Влючил ПВП флаг",
			"Столкнул меня со скалы",
			"Использовал инженерские фишки",
			"Всегда старается сбежать",
			"Использовал предметы и способности для побега",
			"Использует эксплоиты игровой механики",
			"Введите собственную причину ...",
		};
	},
}

StaticPopupDialogs["Spy_SetKOSReasonOther"] = {
	preferredIndex=STATICPOPUPS_NUMDIALOGS,  -- http://forums.wowace.com/showthread.php?p=320956
	text = "Введите причину Kill on Sight для %s:",
	button1 = "Введите",
	button2 = "Отмена",
	timeout = 120,
	hasEditBox = 1,
	editBoxWidth = 260,	
	whileDead = 1,
	hideOnEscape = 1,
	OnShow = function(self)
		self.editBox:SetText("");
	end,
    OnAccept = function(self)
		local reason = self.editBox:GetText()
		Spy:SetKOSReason(self.playerName, "Введите собственную причину ...", reason)
	end,
};

-- Class descriptions
L["UNKNOWN"] = "Неизвестный"
L["DRUID"] = "Друид"
L["HUNTER"] = "Охотник"
L["MAGE"] = "Маг"
L["PALADIN"] = "Паладин"
L["PRIEST"] = "Жрец"
L["ROGUE"] = "Разбойник"
L["SHAMAN"] = "Шаман"
L["WARLOCK"] = "Чернокнижник"
L["WARRIOR"] = "Воин"
L["DEATHKNIGHT"] = "рыцарь смерти"
L["MONK"] = "Монах"
L["DEMONHUNTER"] = "Охотник на демонов"
L["EVOKER"] = "Пробудитель"

-- Race descriptions
L["Human"] = "Человек"
L["Orc"] = "Орк"
L["Dwarf"] = "Дворф"
L["Tauren"] = "Таурен"
L["Troll"] = "Тролль"
L["Night Elf"] = "Ночной эльф"
L["Undead"] = "Нежить"
L["Gnome"] = "Гном"
L["Blood Elf"] = "Эльф крови"
L["Draenei"] = "Дреней"
L["Goblin"] = "Гоблин"
L["Worgen"] = "Ворген"
L["Pandaren"] = "Пандарен"
L["Highmountain Tauren"] = "Таурен Крутогорья"
L["Lightforged Draenei"] = "Озаренный дреней"
L["Nightborne"] = "Ночнорожденный"
L["Void Elf"] = "Эльф Бездны"
L["Dark Iron Dwarf"] = "Дворф из клана Черного Железа"
L["Mag'har Orc"] = "Маг'хар"
L["Kul Tiran"] = "Култирасец"
L["Zandalari Troll"] = "Зандалар"
L["Mechagnome"] = "Механогном"
L["Vulpera"] = "Вульпера"
L["Dracthyr"] = "Драктир"
 
-- Stealth abilities
L["Stealth"] = "Незаметность"
L["Prowl"] = "Крадущийся зверь"
 
-- Minimap color codes
L["MinimapGuildText"] = "|cffffffff"
L["MinimapClassTextUNKNOWN"] = "|cff191919"
L["MinimapClassTextDRUID"] = "|cffff7c0a"
L["MinimapClassTextHUNTER"] = "|cffaad372"
L["MinimapClassTextMAGE"] = "|cff68ccef"
L["MinimapClassTextPALADIN"] = "|cfff48cba"
L["MinimapClassTextPRIEST"] = "|cffffffff"
L["MinimapClassTextROGUE"] = "|cfffff468"
L["MinimapClassTextSHAMAN"] = "|cff2359ff"
L["MinimapClassTextWARLOCK"] = "|cff9382c9"
L["MinimapClassTextWARRIOR"] = "|cffc69b6d"
L["MinimapClassTextDEATHKNIGHT"] = "|cffc41e3a"
L["MinimapClassTextMONK"] = "|cff00ff96"
L["MinimapClassTextDEMONHUNTER"] = "|cffa330c9"
L["MinimapClassTextEVOKER"] = "|cff33937f"

Spy_IgnoreList = {

};
 
