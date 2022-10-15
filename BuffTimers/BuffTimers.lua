local function getMilliseconds(time)
    local milliseconds = floor((time % 60) % 1 * 10)

    return milliseconds
end

local function formatTime(time)
    -- IF YOU ARE READING THIS YOU ARE PROBABLY A NERD AS WELL
    -- IF YOU KNOW A BETTER WAY TO WRITE THIS CODE PLEASE DM ME
    -- This all is a mess because of the different options in which to display the timestamp
    -- I really tried my best ok

    local timeStamp = BuffTimersOptions["time_stamp"]
    local isSecondsOption = BuffTimersOptions["seconds"]
    local isMillisecondsOption = BuffTimersOptions["milliseconds"]
    local showSecondsThreshold = BuffTimersOptions["seconds_threshold"]
    local seconds = floor(time % 60)
    local minutes = floor(time / 60)
    local hours = floor(time / 60 / 60)
    local hourMins = ceil(time / 60 % 60) -- This calculates minutes beyond 1 hour
    local milliseconds = 0

    -- Used so we don't accidentally compare numbers with strings
    local str = ""
    local hourMinsStr = hourMins
    local secondsStr = seconds

    local isBelowShowSecThreshold = isSecondsOption and minutes < showSecondsThreshold
    local isBelowShowMillisecThreshold = isMillisecondsOption and minutes < 1 and seconds < 5

    -- Determine if we show time as "h:mm" if not we fall back to minutes
    if timeStamp == "hm"
    and (
        (minutes >= 59 and not isBelowShowSecThreshold) -- Cases like 1h, 1:01h
        or (minutes >= 60 and isBelowShowSecThreshold) -- Cases like 1:00:59
    ) then
        -- Display as 2h / 1h etc without minutes
        if hourMins == 60 then
            hours = ceil(time / 60 / 60)
        end

        -- Display floored hour
        if minutes >= 59 then
            str = str .. hours
        end

        -- Determine if we show hourMins
        if (minutes >= 60 and hourMins < 60) -- Cases like 1:01h through 1:59h
        or (isBelowShowSecThreshold and minutes >= 59 and hourMins <= 60) -- Cases like 2:00:59
        then
            if isBelowShowSecThreshold then
                -- Determine if we need to show hourMins as a zero (because it ranges between 1 and 60, and 60 == 0)
                if hourMins == 60 then
                    hourMins = 0
                    hourMinsStr = hourMins
                else
                    -- If we show seconds we need to floor the hourMins
                    hourMinsStr = floor(time / 60 % 60)
                end
            end

            -- Determine if we need to prepend hourMins with a zero
            if hourMins < 10 then
                hourMinsStr = 0 .. hourMinsStr
            end

            str = str .. ":" .. hourMinsStr
        end

        -- Determine if we show seconds
        if isBelowShowSecThreshold then
            -- Determine if we need to prepend seconds with a zero
            if seconds < 10 then
                secondsStr = 0 .. secondsStr
            end

            str = str .. ":" .. secondsStr
        end

        -- Determine if we show the "h" affix
        if not isBelowShowSecThreshold then
            str = str .. "h"
        end
    else
        -- Determine if we show seconds
        if isBelowShowSecThreshold then
            if minutes >= 1 then
                -- Add minutes
                str = str .. minutes

                -- Determine if we need to prepend seconds with a zero
                if seconds < 10 then
                    secondsStr = 0 .. secondsStr
                end

                str = str .. ":" .. secondsStr
            else
                -- Only show seconds / ms
                str = seconds

                if isBelowShowMillisecThreshold then
                    milliseconds = getMilliseconds(time)

                    str = str .. "." .. milliseconds
                end

                str = str .. "s"
            end
        else
            -- If duration is less than an hour and seconds option is not toggled
            if minutes < 1 then
                str = seconds

                if isBelowShowMillisecThreshold then
                    milliseconds = getMilliseconds(time)

                    str = str .. "." .. milliseconds
                end

                str = str .. "s"
            else
                minutes = ceil(time / 60)
                str = str .. minutes .. "m"
            end
        end
    end

    return str
end

local function onAuraDurationUpdate(aura, time)
    local duration = getglobal(aura:GetName() .. "Duration")
    
    if (time) then
        duration:SetText(formatTime(time))

        if BuffTimersOptions["yellow_text"] then
            duration:SetTextColor(0.99999779462814, 0.81960606575012, 0)
        end

        duration:Show()
    else
        duration:Hide()
    end
end

local function onAuraUpdate(auraSlot, index, filter)
    local auraName = auraSlot .. index
    local aura = getglobal(auraName)
    local auraDuration = getglobal(auraName .. "Duration")
    
    if not auraDuration then
        return
    end

    local name, _, _, _, _, expirationTime = UnitAura("player", index, filter)
    
    if (name and expirationTime > 0) then
        auraDuration:Show()
    elseif (name and expirationTime == 0) then
        auraDuration:SetText("|cff00ff00N/A|r");
        auraDuration:Show();
    end
end

-- Add or remove aura event
hooksecurefunc("AuraButton_Update", onAuraUpdate)

-- Aura duration update event
hooksecurefunc("AuraButton_UpdateDuration", onAuraDurationUpdate)
