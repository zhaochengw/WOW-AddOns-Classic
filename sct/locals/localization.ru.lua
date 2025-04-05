
if GetLocale() ~= "ruRU" then return end 

-- Static Messages
SCT.LOCALS.LowHP= "Мало здоровья!";					-- Message to be displayed when HP is low
SCT.LOCALS.LowMana= "Мало маны!";					-- Message to be displayed when Mana is Low
SCT.LOCALS.SelfFlag = "*";								-- Icon to show self hits
SCT.LOCALS.Crushchar = "^";
SCT.LOCALS.Glancechar = "~";
SCT.LOCALS.Combat = "+ БОЙ";						-- Message to be displayed when entering combat
SCT.LOCALS.NoCombat = "- БОЙ";					-- Message to be displayed when leaving combat
SCT.LOCALS.ComboPoint = "Комбо";			  		-- Message to be displayed when gaining a combo point
SCT.LOCALS.CPMaxMessage = "Полная серия!"; -- Message to be displayed when you have max combo points
SCT.LOCALS.ExtraAttack = "Экстра атака!"; -- Message to be displayed when time to execute
SCT.LOCALS.KillingBlow = "Решающий удар!"; -- Message to be displayed when you kill something
SCT.LOCALS.Interrupted = "Прервано!"; -- Message to be displayed when you are interrupted
SCT.LOCALS.Dispel = "Снято!"; -- Message to be displayed when you dispel
SCT.LOCALS.DispelFailed = "Неудачное рассеяние!"; -- Message to be displayed when your dispel failed
SCT.LOCALS.Rampage = "Rampage"; -- Message to be displayed when rampage is needed

--Option messages
SCT.LOCALS.STARTUP = "Scrolling Combat Text "..SCT.Version.." Аддон загружен. Введите /sct для вызова меню настроек.";
SCT.LOCALS.Option_Crit_Tip = "Выводить это сообщение как КРИТИЧЕСКОЕ.";
SCT.LOCALS.Option_Msg_Tip = "Выводить это сообщение в области MESSAGE. Замещает критические.";
SCT.LOCALS.Frame1_Tip = "Выводить это сообщение в области ANIMATION FRAME 1.";
SCT.LOCALS.Frame2_Tip = "Выводить это сообщение в области ANIMATION FRAME 2";

--Warnings
SCT.LOCALS.Version_Warning= "|cff00ff00SCT ПРЕДУПРЕЖДЕНИЕ|r\n\nВаши сохраненные настройки от старой версии аддона SCT. Если у вас возникают ошибки при работе аддона сбросьте настройки кнопкой 'Сброс' или командой /sctreset";
SCT.LOCALS.Load_Error = "|cff00ff00Ошибка загрузки настроек SCT. Аддон не доступен.|r Ошибка: ";

--nouns
SCT.LOCALS.TARGET = "Цель ";
SCT.LOCALS.PROFILE = "SCT профиль: |cff00ff00";
SCT.LOCALS.PROFILE_DELETE = "Удалить SCT профиль: |cff00ff00";
SCT.LOCALS.PROFILE_NEW = "Создать новый SCT профиль: |cff00ff00";
SCT.LOCALS.WARRIOR = "Воин";
SCT.LOCALS.ROGUE = "Разбойник" or "Разбойница";
SCT.LOCALS.HUNTER = "Охотник" or "Охотница";
SCT.LOCALS.MAGE = "Маг";
SCT.LOCALS.WARLOCK = "Чернокнижник" or "Чернокнижница";
SCT.LOCALS.DRUID = "Друид";
SCT.LOCALS.PRIEST = "Жрец" or "Жрица";
SCT.LOCALS.SHAMAN = "Шаман" or "Шаманка";
SCT.LOCALS.PALADIN = "Паладин";
SCT.LOCALS.DEATHKNIGHT = "Рыцарь смерти";

--Useage
SCT.LOCALS.DISPLAY_USEAGE = "Используйте: \n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'сообщение' (белым текстом)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay 'сообщение' красный(0-10) зеленый(0-10) синий(0-10)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Пример: /sctdisplay 'Вылечите меня!' 10 0 0\nЭто выведед 'Вылечите меня' красным цветом\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "Примеры цветов: красный = 10 0 0, зеленый = 0 10 0, синий = 0 0 10,\nжелтый = 10 10 0, сиреневый = 10 0 10, голубой = 0 10 10";

--Fonts
SCT.LOCALS.FONTS = {
	[1] = { name="Friz Quadrata TT", path="Fonts\\FRIZQT__.TTF"},
	[2] = { name="SCT Derby_Regular", path="Interface\\Addons\\sct\\fonts\\Derby_Regular.Ttf"},
	[3] = { name="SCT goth", path="Interface\\Addons\\sct\\fonts\\goth.ttf"},
	[4] = { name="SCT MUTTRRR_", path="Interface\\Addons\\sct\\fonts\\MUTTRRR_.TTF"},
	[5] = { name="SCT RAMMRF__", path="Interface\\Addons\\sct\\fonts\\RAMMRF__.TTF"},
	[6] = { name="SCT SKURRI", path="Interface\\Addons\\sct\\fonts\\SKURRI.TTF"},
	[7] = { name="SCT AARDVA", path="Interface\\Addons\\sct\\fonts\\AARDVA.TTF"},
}

-- Cosmos button
SCT.LOCALS.CB_NAME		= "Scrolling Combat Text".." "..SCT.Version;
SCT.LOCALS.CB_SHORT_DESC	= "by Grayhoof";
SCT.LOCALS.CB_LONG_DESC		= "щелкните для вызова настроек SCT";
SCT.LOCALS.CB_ICON		= "Interface\\Icons\\Spell_Shadow_EvilEye"; -- "Interface\\Icons\\Spell_Shadow_FarSight"
