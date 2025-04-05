local addonName, addon = ...
local BuffTimers = LibStub("AceAddon-3.0"):GetAddon("BuffTimers")
local L = LibStub("AceLocale-3.0"):GetLocale("BuffTimers")

local IsRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
addon.IsRetail = IsRetail

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
            show_source = true,  -- 添加显示来源的默认值
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
            show_na = true,  -- 新增N/A文本开关
        }
    }

    -- Initialize the addon
    self.db = LibStub("AceDB-3.0"):New("BuffTimersDB", defaults, true)
    
    -- 在这里添加钩子，确保能正确访问到 self
    hooksecurefunc(GameTooltip, "SetUnitAura", function(tooltip, unit, index, filter)
        if not self.db.profile.show_source then return end
        
        local name, _, _, _, _, _, caster = UnitAura(unit, index, filter)
        if name and caster then
            local casterName = UnitName(caster) or caster
            if UnitIsPlayer(caster) then
                local _, className = UnitClass(caster)
                local classColor = RAID_CLASS_COLORS[className]
                tooltip:AddLine(L["Source"]..": |c"..classColor.colorStr..casterName.."|r")
            else
                tooltip:AddLine(L["Source"]..": "..casterName, 1, 0.82, 0)
            end
            tooltip:Show()
        end
    end)
end

function BuffTimers:OnEnable()
    -- Hook the functions when addon is enabled
    if IsRetail then
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
    local profile = self.db.profile
    
    if profile.yellow_text then
        -- 强制黄色文本
        duration:SetTextColor(0.99999779462814, 0.81960606575012, 0, 1)
    elseif profile.colored_text then
        -- 根据时间变化颜色
        if not time then
            duration:SetTextColor(0.1, 1, 0.1, 1) -- N/A 状态也使用默认绿色
        else
            local minutes = GetMinutes(time)
            if minutes >= 10 then
                duration:SetTextColor(0.1, 1, 0.1, 1) -- 绿色
            elseif minutes >= 1 then
                duration:SetTextColor(0.99999779462814, 0.81960606575012, 0, 1) -- 黄色
            else
                duration:SetTextColor(1, 0.1, 0.1, 1) -- 红色
            end
        end
    else
        -- 默认使用绿色
        duration:SetTextColor(0.1, 1, 0.1, 1)
    end
end

function BuffTimers.OnAuraDurationUpdate(aura, time, source)
    if not aura then return end
    
    local duration = IsRetail and aura.Duration or aura.duration
    if not duration then return end

    local self = BuffTimers
    local profile = self.db.profile

    -- 应用自定义文本设置
    if profile.customize_text then
        -- 只有当实际设置了相关选项时才应用更改
        if profile.vertical_position ~= -34 then
            local verticalPosition = profile.vertical_position
            if (IsRetail and verticalPosition == -40) then 
                verticalPosition = -39.9
            end
            duration:SetPoint("BOTTOM", aura, "TOP", 0, verticalPosition)
        end

        -- 只有当实际设置了字体相关选项时才应用
        local currentFont, currentSize, currentOutline = duration:GetFont()
        if profile.font ~= "" then
            currentFont = BuffTimersLibSharedMedia:Fetch("font", profile.font)
        end
        if profile.font_size > 0 then
            currentSize = profile.font_size
        end
        if profile.font_outline ~= "" then
            currentOutline = profile.font_outline
        end
        
        duration:SetFont(currentFont, currentSize, currentOutline)
    end

    -- 设置文本和颜色
    if time and time > 0 then
        local timeText = self:FormatTime(time)
        if profile.show_source and source then
            local sourceName = UnitName(source) or source
            duration:SetText(timeText .. " |cffffffff(" .. sourceName .. ")|r")
        else
            duration:SetText(timeText)
        end
    else
        if self.db.profile.show_na then
            if profile.show_source and source then
                local sourceName = UnitName(source) or source
                duration:SetText("N/A |cffffffff(" .. sourceName .. ")|r")
            else
                duration:SetText("N/A")
            end
        else
            duration:SetText("")
        end
    end
    
    self:SetDurationColor(duration, time)
    duration:SetShown(duration:GetText() ~= "")
end

function BuffTimers.OnAuraUpdate(...)
    if IsRetail then
        local aura = ...
        local expirationTime = aura.buttonInfo.expirationTime
        local remaining = expirationTime > 0 and (expirationTime - GetTime()) or nil
        -- 增加时间耗尽检查（剩余时间<=0时传nil）
        BuffTimers.OnAuraDurationUpdate(aura, remaining and remaining > 0 and remaining or nil)
    else
        -- 经典版需要主动触发更新
        local auraSlot, index, filter = ...
        -- 修复经典版按钮索引问题
        local buttonName = "BuffButton"..index  -- 根据实际按钮命名规则调整
        local aura = _G[buttonName]
        
        if aura then
            local name, _, _, _, _, expirationTime = UnitAura("player", index, filter)
            local remaining = name and expirationTime > 0 and (expirationTime - GetTime()) or nil
            BuffTimers.OnAuraDurationUpdate(aura, remaining)
        end
    end
end

function BuffTimers:RefreshAllAuras()
    -- 经典版刷新逻辑
    if not IsRetail then
        for i = 1, BUFF_MAX_DISPLAY do
            local button = _G["BuffButton"..i]
            if button then
                AuraButton_Update("player", i, "HELPFUL")
            end
        end
        return
    end
    
    -- 正式服刷新逻辑
    BuffFrame:UpdateAllAuras()
    DebuffFrame:UpdateAllAuras()
end
