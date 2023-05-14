
local IsRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE

local function getMilliseconds(time)
    return floor((time % 60) % 1 * 10)
end

local function getMinutes(time)
    if time then
        return floor(time / 60)
    end

    return 0
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
    local minutes = getMinutes(time)
    local hours = floor(time / 60 / 60)
    local hourMins = ceil(time / 60 % 60) -- This calculates minutes beyond 1 hour
    local days = ceil(hours / 24)
    local milliseconds = 0

    -- Used so we don't accidentally compare numbers with strings
    local str = ""
    local hourMinsStr = hourMins
    local secondsStr = seconds

    local isBelowShowSecThreshold = isSecondsOption and minutes < showSecondsThreshold
    local isBelowShowMillisecThreshold = isMillisecondsOption and minutes < 1 and seconds < 5

    -- If time is more than 24 hours, just render the amount of days
    if hours >= 24 then
        return days .. "d"
    end

     -- Determine if we show time as "h:mm" if not we fall back to minutes
    if
        timeStamp == "hm" and
            ((minutes >= 59 and not isBelowShowSecThreshold) or -- Cases like 1h, 1:01h
                (minutes >= 60 and isBelowShowSecThreshold)) -- Cases like 1:00:59
    then
        -- Display as 2h / 1h etc without minutes
        if hourMins == 60 then
            hours = ceil(time / 60 / 60)
        end

        -- Display floored hour
        if minutes >= 59 then
            str = str .. hours
        end

        -- Determine if we show hourMins
        if
            (minutes >= 60 and hourMins < 60) or -- Cases like 1:01h through 1:59h
                (isBelowShowSecThreshold and minutes >= 59 and hourMins <= 60)
         then -- Cases like 2:00:59
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

local function setDurationColor(duration, time)
    if BuffTimersOptions["yellow_text"] then
        duration:SetTextColor(0.99999779462814, 0.81960606575012, 0)
    elseif BuffTimersOptions["colored_text"] then
        if getMinutes(time) >= 10 then
            duration:SetTextColor(0.1, 1, 0.1) -- Green
        elseif getMinutes(time) >= 1 then
            duration:SetTextColor(0.99999779462814, 0.81960606575012, 0) -- Yellow
        else
            duration:SetTextColor(1, 0.1, 0.1) -- Red
        end
    end
end

local function onAuraDurationUpdate(aura, time)
    local duration = IsRetail and aura.Duration or aura.duration

    if time then
        if BuffTimersOptions["customize_text"] then
            local verticalPosition = BuffTimersOptions["vertical_position"]
            -- Retail only: text cannot be displayed if verticalPosition is set to -40. don't know why
            if (IsRetail and verticalPosition == -40) then 
                verticalPosition = -39.9
            end

            duration:SetPoint("BOTTOM", aura, "TOP", 0, verticalPosition)

            local fontSize = BuffTimersOptions["font_size"]
            local fontName, fontHeight, fontFlags = duration:GetFont()
            duration:SetFont(fontName, fontSize, fontFlags)
        end

        duration:SetText(formatTime(time))
        setDurationColor(duration, time)

        duration:Show()
    else
        duration:Hide()
    end
end

local function onAuraUpdate(...)
    if IsRetail then
        local aura = ...

        if aura.buttonInfo.expirationTime > 0 then
            aura.Duration:Show()
        else
            aura.Duration:Hide()
        end
    else
        local auraSlot, index, filter = ...
        local auraName = auraSlot .. index
        local auraDuration = getglobal(auraName .. "Duration")

        if not auraDuration then
            return
        end

        local name, _, _, _, _, expirationTime = UnitAura("player", index, filter)

        if name and expirationTime > 0 then
            auraDuration:Show()
        else
            auraDuration:Hide()
        end
    end
end

if IsRetail then
    local frames = { BuffFrame, DebuffFrame }
    for i = 1, #frames do
        for _, button in ipairs(frames[i].auraFrames) do
            if button.OnUpdate then
                hooksecurefunc(button, "OnUpdate", onAuraUpdate)
            end
            if button.UpdateDuration then
                hooksecurefunc(button, "UpdateDuration", onAuraDurationUpdate)
            end
        end
    end
else
    hooksecurefunc("AuraButton_Update", onAuraUpdate)
    hooksecurefunc("AuraButton_UpdateDuration", onAuraDurationUpdate)
end
