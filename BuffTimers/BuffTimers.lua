local addonName, addon = ...
local BuffTimers = LibStub("AceAddon-3.0"):GetAddon("BuffTimers")
local L = LibStub("AceLocale-3.0"):GetLocale("BuffTimers")

local isNotClassic = WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC and WOW_PROJECT_ID ~= WOW_PROJECT_MISTS_CLASSIC
addon.isNotClassic = isNotClassic

local function GetMilliseconds(time)
    return floor((time % 60) % 1 * 10)
end

local function GetMinutes(time)
    if time then
        return floor(time / 60)
    end
    return 0
end

function BuffTimers:OnInitialize()
    if not BuffTimersOptions then
        BuffTimersOptions = {}
    end

    -- Default configuration
    -- Transfer from old config or use hardcoded default values
    local defaults = {
        profile = {
            time_stamp = BuffTimersOptions["time_stamp"] or "m",
            seconds = BuffTimersOptions["seconds"] or false,
            seconds_threshold = BuffTimersOptions["seconds_threshold"] or 30,
            milliseconds = BuffTimersOptions["milliseconds"] or true,
            yellow_text = BuffTimersOptions["yellow_text"] or false,
            colored_text = BuffTimersOptions["colored_text"] or false,
            customize_text = BuffTimersOptions["customize_text"] or false,
            vertical_position = BuffTimersOptions["vertical_position"] or -34,
            font = "Friz Quadrata TT",
            font_size = BuffTimersOptions["font_size"] or 14,
            font_outline = "",
        }
    }

    -- Initialize the addon
    self.db = LibStub("AceDB-3.0"):New("BuffTimersDB", defaults, true)
end

function BuffTimers:OnEnable()
    -- Hook the functions when addon is enabled
    if isNotClassic then
        local frames = { BuffFrame, DebuffFrame }
        for i = 1, #frames do
            for _, button in ipairs(frames[i].auraFrames) do
                if button.OnUpdate then
                    hooksecurefunc(button, "OnUpdate", self.OnAuraUpdate)
                end
                if button.UpdateDuration then
                    hooksecurefunc(button, "UpdateDuration", self.OnAuraDurationUpdate)
                end
            end
        end
    else
        hooksecurefunc("AuraButton_Update", self.OnAuraUpdate)
        hooksecurefunc("AuraButton_UpdateDuration", self.OnAuraDurationUpdate)
    end
end

function BuffTimers:FormatTime(time)
    -- IF YOU ARE READING THIS YOU ARE PROBABLY A NERD AS WELL
    -- IF YOU KNOW A BETTER WAY TO WRITE THIS CODE PLEASE DM ME
    -- This all is a mess because of the different options in which to display the timestamp
    -- I really tried my best ok

    local timeStamp = self.db.profile.time_stamp
    local isSecondsOption = self.db.profile.seconds
    local isMillisecondsOption = self.db.profile.milliseconds
    local showSecondsThreshold = self.db.profile.seconds_threshold
    local seconds = floor(time % 60)
    local minutes = GetMinutes(time)
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
                    milliseconds = GetMilliseconds(time)

                    str = str .. "." .. milliseconds
                end

                str = str .. "s"
            end
        else
            -- If duration is less than an hour and seconds option is not toggled
            if minutes < 1 then
                str = seconds

                if isBelowShowMillisecThreshold then
                    milliseconds = GetMilliseconds(time)

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

function BuffTimers:SetDurationColor(duration, time)
    -- TBCC introduced a bug (?) where the timer starts ticking down in seconds at 90 seconds instead of 60 seconds
    -- Which also means the time will be white from 90 seconds
    -- This should force the text to be yellow until < 60 seconds
    if time >= 60 then
        duration:SetTextColor(0.99999779462814, 0.81960606575012, 0, 1)
    end

    if self.db.profile.yellow_text then
        duration:SetTextColor(0.99999779462814, 0.81960606575012, 0, 1)
    elseif self.db.profile.colored_text then
        if GetMinutes(time) >= 10 then
            duration:SetTextColor(0.1, 1, 0.1, 1) -- Green
        elseif GetMinutes(time) >= 1 then
            duration:SetTextColor(0.99999779462814, 0.81960606575012, 0, 1) -- Yellow
        else
            duration:SetTextColor(1, 0.1, 0.1, 1) -- Red
        end
    end
end

function BuffTimers.OnAuraDurationUpdate(aura, time)
    local duration = isNotClassic and aura.Duration or aura.duration
    local self = BuffTimers

    if time then
        if self.db.profile.customize_text then
            local verticalPosition = self.db.profile.vertical_position
            -- Non-classic Era only: text cannot be displayed if verticalPosition is set to -40. don't know why
            if (isNotClassic and verticalPosition == -40) then 
                verticalPosition = -39.9
            end

            duration:SetPoint("BOTTOM", aura, "TOP", 0, verticalPosition)

            local fontPath = BuffTimersLibSharedMedia:Fetch("font", self.db.profile.font)
            duration:SetFont(fontPath, self.db.profile.font_size, self.db.profile.font_outline)
        end

        duration:SetText(self:FormatTime(time))
        self:SetDurationColor(duration, time)

        duration:Show()
    else
        duration:Hide()
    end
end

function BuffTimers.OnAuraUpdate(...)
    if isNotClassic then
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
