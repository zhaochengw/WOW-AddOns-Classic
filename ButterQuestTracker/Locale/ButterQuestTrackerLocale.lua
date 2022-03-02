ButterQuestTrackerLocale = {};
ButterQuestTrackerLocale.locale = {};

local locale = 'enUS';

function ButterQuestTrackerLocale:FallbackLocale(lang)
    lang = lang or GetLocale();

    if ButterQuestTrackerLocale.locale[lang] then
        return lang;
    elseif lang == 'enGB' then
        return 'enUS';
    elseif lang == 'enCN' then
        return 'zhCN';
    elseif lang == 'enTW' then
        return 'zhTW';
    elseif lang == 'esMX' then
        return 'esES';
    elseif lang == 'ptPT' then
        return 'ptBR';
    end

    return 'enUS';
end

function ButterQuestTrackerLocale:SetLocale(lang)
    locale = ButterQuestTrackerLocale:FallbackLocale(lang);
end

function ButterQuestTrackerLocale:GetLocale()
    return locale;
end

function ButterQuestTrackerLocale:GetStringWrap(key)
    return function()
        return self:GetString(key);
    end
end

function ButterQuestTrackerLocale:GetString(key, ...)
    if not key then return end

    local lang = locale;
    if not self.locale[lang] then
        lang = 'enUS';
    end

    local dictionary = self.locale[lang];

    if dictionary[key] then
        -- convert all args to strings
        local arg = {...};
        for i, v in ipairs(arg) do
            arg[i] = tostring(v);
        end

        return string.format(dictionary[key], unpack(arg));
    elseif self.locale['enUS'][key] then
        return string.format(self.locale['enUS'][key], unpack(arg));
    else
        return tostring(key) .. ' ERROR: ' .. lang .. ' key missing!';
    end
end
