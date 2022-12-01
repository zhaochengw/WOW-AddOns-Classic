local AddonName, Addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(AddonName, "ruRU")

if L then
L["Transmute"] = "Трансмутация"

L["Reset due to update"] = function(oldv, newv) return "Сброс некоторых или всех данных из-за обновления версии ("..oldv.." -> "..newv.. ")" end
L["extended"] = "(расширение)"

L["minites"] = "м"
L["Enabled"] = "Включено"
L["Disabled"] = "Отключено"

L["Display settings"] = "Настройки отображения"
L["Show floating UI frame"] = "Показать всплывающее окно"
L["Floating UI width"] = "Ширина окна"
L["Floating UI height"] = "Высота окна"
L["Desc - Frame"] = "|cff00ff00■|r |cffccaa00Shift - Перетаскивание для перемещения окна|r"
L["Show minimap icon"] = "Показать значок на миникарте"
L["Show info"] = "Информационное окно"
L["per Character"] = "По персонажу"
L["per Realm"] = "По серверу"
L["Hide info from level under"] = "Скрыть информацию с уровня ниже"

L["Tooltip - Character info."] = "Информация, относящаяся к параметру всплывающей подсказки" --"Информация для персонажа"
L["Line 1 of char info."] = "Первая строка с информацией по специализации персонажа"
L["Line 2 of char info."] = "Вторая строка с информацией по специализации персонажа"
L["Left"] = "Лево"
L["Right"] = "Право"
L["Desc_Char"] = "|cff00ff00■|r |cffccaa00Использование - Информация о персонаже|r|n"
    .."|cffccaa00[name]|r Имя (цвет класса)|n"
    .."|cffccaa00[name2]|r Имя (без цвета)|n"
    .."|cffccaa00[level] [expCur] [expMax] [exp%]|r|n"
    .."|cffccaa00[expRest] [expRest%] [zone] [subzone]|r|n"
    .."|cffccaa00[elapsed]|r Прошедшее время после последнего обновления|n"
    .."|cffccaa00[item:|cffffeeaaимя на ID|r]|r значок и количество|n"
    .."|cffccaa00[cooldown]|r Перезарядка навыков профессии|n"
    .."|cffccaa00[dqCom] [dqMax]|r|n"
    .."|cffccaa00[dqReset]|r Time left until DQ Reset|n"
    .."|cffccaa00[color/######]|r Цвет начала(RGB кодировка)|n|cffccaa00[color]|r Цвет окончания|n"
    .."  Цвет, добавляя /###### в конец|n"
    .."|cffffeeaa(ex) |r|cffccaa00[color/ffffff]Белый[color] =>|r |cffffffffБелый|r|n   |cffccaa00[item:6265|cffcc3333/cc66cc|r] => |r|cffcc66cc".."|T"..GetItemIcon(6265)..":14:14|t12|r|n"
    .."|cffccaa00[currency:|cffffeeaaимя на ID|r]|r значок и количество|n"
L["Tooltip - Raid instances"] = true
L["Lines of raid instances"] = true
L["Desc_Inst"] = "|cff00ff00■|r |cffccaa00Использование - Информация о подземелье|r|n"
    .."|cffccaa00[instName]|r Название подземелья|n"
    .."|cffccaa00[difficulty]|r Размер и сложность|n"
    .."|cffccaa00[progress]|r Количество убитых боссов|n"
    .."|cffccaa00[bosses]|r Количество боссов|n"
    .."|cffccaa00[time]|r Время сброса|n"
    .."|cffccaa00[instID]|r ID подземелья|n"
L["Tooltip - Heroic instances"] = true
L["Lines of heroic instances"] = true
L["Show in one-line"] = "Показать в одну строку"

L["Select character"] = "Выбор персонажа"
L["Reset selected character"] = "Сбросить выбранного персонажа"
L["Are you really want to reset?"] = "Вы действительно хотите сбросить настройки?"
L["Reset all characters"] = "Сбросить всех персонажей"
L["Copy settings to"] = "Настройки копирования на"
L["Copy"] = "Копировать"
L["Confirm copy"] = "Настройки копирования перезапишут информацию о персонаже/подземелье."

-- Localized Translation Table
L["color"     ] = true
L["item"      ] = true
L["currency"  ] = true
L["name"      ] = true
L["name2"     ] = true
L["zone"      ] = true
L["subzone"   ] = true
L["cooldown"  ] = true
L["elapsed"   ] = true
L["level"     ] = true
L["expCur"    ] = true
L["expMax"    ] = true
L["exp%"      ] = true
L["expRest"   ] = true
L["expRest%"  ] = true
L["dqCom"     ] = true
L["dqMax"     ] = true
L["dqReset"   ] = true
L["instName"  ] = true
L["instID"    ] = true
L["difficulty"] = true
L["progress"  ] = true
L["bosses"    ] = true
L["time"      ] = true
-- Localized Currency Name
L["gold"    ] = true
L["silver"  ] = true
L["copper"  ] = true
L["honor"   ] = true
L["arena"   ] = true
L["jewel"   ] = true
L["cook"    ] = true
L["heroism" ] = true
L["valor"   ] = true
L["conquest"] = true
L["triumph" ] = true
L["frost"   ] = true
L["champion"] = true
L["AV"      ] = true
L["AB"      ] = true
L["EotS"    ] = true
L["SotA"    ] = true
L["WSG"     ] = true
L["WG"      ] = true
L["IoC"     ] = true
L["shard"   ] = true
L["venture" ] = true
L["justice" ] = true
-- Heroic dungeon names, abbrs
L["TOK"] = true
L[ "AN"] = true
L["DTK"] = true
L["Gun"] = true
L["HoL"] = true
L["HoS"] = true
L["CoS"] = true
L["Nex"] = true
L["Ocu"] = true
L[ "VH"] = true
L[ "UK"] = true
L[ "UP"] = true
L["ToC"] = true
L["HoR"] = true
L["PoS"] = true
L["FoS"] = true
end
