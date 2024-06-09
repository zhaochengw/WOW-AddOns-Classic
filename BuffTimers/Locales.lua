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
    L["Add more colors to the timer"] = "Добавить больше цветов к таймеру"
    L["Text vertical position"] = "Вертикальное положение текста"
    L["Text font size"] = "Размер шрифта текста"
    L["customize_text"] = "Настроить текст"
end

-- German translation by: ysjoelfir
if locale == "deDE" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Sekunden anzeigen"
    L["Show milliseconds below 5 seconds"] = "Zeige Millisekunden unter 5 Sekunden"
    L["Always yellow text color"] = "Textfarbe immer gelb"
    L["Time Stamp Format"] = "Zeitstempelformat"
    L["Add more colors to the timer"] = "Füge mehr Farben zum Timer hinzu"
    L["Text vertical position"] = "Text vertikale Position"
    L["Text font size"] = "Text Schriftgröße"
    L["customize_text"] = "Text anpassen"
end


--
-- HELP!
-- I need help with all the languages below.
-- Right now, everything has been translated by AI, so it might not be correct.
--

-- French translation by: qrpino
if locale == "frFR" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Afficher les secondes"
    L["Show milliseconds below 5 seconds"] = "Afficher les millisecondes sous 5 secondes"
    L["Always yellow text color"] = "Couleur du texte toujours jaune"
    L["Time Stamp Format"] = "Format de l'horodatage"
    L["Add more colors to the timer"] = "Ajouter plus de couleurs au minuteur"
    L["Text vertical position"] = "Position verticale du texte"
    L["Text font size"] = "Taille de la police du texte"
    L["customize_text"] = "Personnaliser le texte"
end

if locale == "esES" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Mostrar segundos"
    L["Show milliseconds below 5 seconds"] = "Mostrar los milisegundos bajo 5 segundos"
    L["Always yellow text color"] = "Siempre color texto amarillo"
    L["Time Stamp Format"] = "Formato de la hora"
    L["Add more colors to the timer"] = "Añadir más colores al temporizador"
    L["Text vertical position"] = "Posición vertical del texto"
    L["Text font size"] = "Tamaño de fuente del texto"
    L["customize_text"] = "Personalizar texto"
end

if locale == "esMX" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Mostrar segundos"
    L["Show milliseconds below 5 seconds"] = "Mostrar los milisegundos bajo 5 segundos"
    L["Always yellow text color"] = "Siempre color texto amarillo"
    L["Time Stamp Format"] = "Formato de la hora"
    L["Add more colors to the timer"] = "Añadir más colores al temporizador"
    L["Text vertical position"] = "Posición vertical del texto"
    L["Text font size"] = "Tamaño de fuente del texto"
    L["customize_text"] = "Personalizar texto"
end

if locale == "itIT" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Mostra secondi"
    L["Show milliseconds below 5 seconds"] = "Mostra millisecondi sotto 5 secondi"
    L["Always yellow text color"] = "Sempre colore testo giallo"
    L["Time Stamp Format"] = "Formato dell'ora"
    L["Add more colors to the timer"] = "Aggiungi più colori al timer"
    L["Text vertical position"] = "Posizione verticale del testo"
    L["Text font size"] = "Dimensione del carattere del testo"
    L["customize_text"] = "Personalizza testo"
end

if locale == "koKR" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "초 보기"
    L["Show milliseconds below 5 seconds"] = "5초 이하 마이크로초 보기"
    L["Always yellow text color"] = "항상 노란색 텍스트 색상"
    L["Time Stamp Format"] = "시간 표시 형식"
    L["Add more colors to the timer"] = "타이머에 더 많은 색상 추가"
    L["Text vertical position"] = "텍스트 수직 위치"
    L["Text font size"] = "텍스트 글꼴 크기"
    L["customize_text"] = "텍스트 사용자 정의"
end

if locale == "ptBR" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Mostrar segundos"
    L["Show milliseconds below 5 seconds"] = "Mostrar milisegundos abaixo de 5 segundos"
    L["Always yellow text color"] = "Sempre cor de texto amarela"
    L["Time Stamp Format"] = "Formato da hora"
    L["Add more colors to the timer"] = "Adicionar mais cores ao temporizador"
    L["Text vertical position"] = "Posição vertical do texto"
    L["Text font size"] = "Tamanho da fonte do texto"
    L["customize_text"] = "Personalizar texto"
end

if locale == "zhCN" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "显示秒"
    L["Show seconds below this time"] = "小于此时间才显示秒"
    L["Show milliseconds below 5 seconds"] = "小于5秒显示毫秒"
    L["Always yellow text color"] = "文字颜色总是使用黄色"
    L["Time Stamp Format"] = "时间格式"
    L["Add more colors to the timer"] = "计时器显示更多颜色"
    L["Text vertical position"] = "文字垂直位置"
    L["Text font size"] = "字体大小"
end

if locale == "zhTW" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "顯示秒"
    L["Show seconds below this time"] = "小於此時間才顯示秒"
    L["Show milliseconds below 5 seconds"] = "小於5秒才顯示毫秒"
    L["Always yellow text color"] = "文字顔色總是使用黃色"
    L["Time Stamp Format"] = "時間格式"
    L["Add more colors to the timer"] = "計時器顯示更多顔色"
    L["Text vertical position"] = "文字垂直位置"
    L["Text font size"] = "字體大小"
end
