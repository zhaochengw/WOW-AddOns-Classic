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

if locale == "enUs" then
    L["BuffTimers"] = true
    L["Show seconds"] = true
    L["Show milliseconds below 5 seconds"] = true
    L["Always yellow text color"] = true
    L["Time Stamp Format"] = true
end

if locale == "ruRU" then
    L["BuffTimers"] = "BuffTimers"
    L["Show seconds"] = "Показать секунды"
    L["Show milliseconds below 5 seconds"] = "Показывать миллисекунды когда осталось меньше 5 секунд"
    L["Always yellow text color"] = "Всегда желтый цвет текста"
    L["Time Stamp Format"] = "Формат отметки времени"
end
