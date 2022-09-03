local _, ADDONSELF = ...

local L = setmetatable({}, {
    __index = function(table, key)
        if key then
            table[key] = tostring(key)
        end
        return tostring(key)
    end,
})


ADDONSELF.L = L

local locale = GetLocale()

-- Russian translation by: Hubbotu
if locale == "ruRU" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Показать секунды"
    L["Show milliseconds below 5 seconds"] = "Показывать миллисекунды когда осталось меньше 5 секунд"
    L["Always yellow text color"] = "Всегда желтый цвет текста"
    L["Time Stamp Format"] = "Формат отметки времени"
end

-- German translation by: ysjoelfir
if locale == "deDE" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Sekunden anzeigen"
    L["Show milliseconds below 5 seconds"] = "Zeige Millisekunden unter 5 Sekunden"
    L["Always yellow text color"] = "Textfarbe immer gelb"
    L["Time Stamp Format"] = "Zeitstempelformat"
end


--
-- HELP!
-- I need help with all the languages below.
-- Right now, everything has been translated by AI, so it might not be correct.
--

if locale == "frFR" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Afficher les secondes"
    L["Show milliseconds below 5 seconds"] = "Afficher les millisecondes sous 5 secondes"
    L["Always yellow text color"] = "Toujours la couleur jaune"
    L["Time Stamp Format"] = "Format de l'heure"
end

if locale == "esES" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Mostrar segundos"
    L["Show milliseconds below 5 seconds"] = "Mostrar los milisegundos bajo 5 segundos"
    L["Always yellow text color"] = "Siempre color texto amarillo"
    L["Time Stamp Format"] = "Formato de la hora"
end

if locale == "esMX" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Mostrar segundos"
    L["Show milliseconds below 5 seconds"] = "Mostrar los milisegundos bajo 5 segundos"
    L["Always yellow text color"] = "Siempre color texto amarillo"
    L["Time Stamp Format"] = "Formato de la hora"
end

if locale == "itIT" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Mostra secondi"
    L["Show milliseconds below 5 seconds"] = "Mostra millisecondi sotto 5 secondi"
    L["Always yellow text color"] = "Sempre colore testo giallo"
    L["Time Stamp Format"] = "Formato dell'ora"
end

if locale == "koKR" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "초 보기"
    L["Show milliseconds below 5 seconds"] = "5초 이하 마이크로초 보기"
    L["Always yellow text color"] = "항상 노란색 텍스트 색상"
    L["Time Stamp Format"] = "시간 표시 형식"
end

if locale == "ptBR" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Mostrar segundos"
    L["Show milliseconds below 5 seconds"] = "Mostrar milisegundos abaixo de 5 segundos"
    L["Always yellow text color"] = "Sempre cor de texto amarela"
    L["Time Stamp Format"] = "Formato da hora"
end

if locale == "zhCN" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "显示秒"
    L["Show milliseconds below 5 seconds"] = "显示毫秒低于5秒"
    L["Always yellow text color"] = "总是黄色文字颜色"
    L["Time Stamp Format"] = "时间戳格式"
end

if locale == "zhTW" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "顯示秒"
    L["Show milliseconds below 5 seconds"] = "顯示毫秒低於5秒"
    L["Always yellow text color"] = "總是黃色文字顏色"
    L["Time Stamp Format"] = "時間戳格式"
end
