-- 版本控制：2.0.9优化代码

local AddonName, Addon = ...
local L = Addon.L

-- 显示UI元素
local function ShowUIElements(show)
    Addon.Output.dropdowntitle:SetShown(show)
    Addon.Output.dropdownlist:SetShown(show)
    Addon.Output.dropdownbutton:SetShown(show)
    Addon.Calendar.background:Show(show)
end

-- 打印交易记录并刷新日历
local function PrintAndRefresh(mode)
    Addon:PrintTradeLog(mode, nil)
    Addon:GetAvailableDate()
    Addon:RefreshCalendar()
end

SLASH_MLC1 = "/maillogger"
SLASH_MLC2 = "/ml"

SlashCmdList["MLC"] = function(Command)
    local cmd = Command:lower()

    -- 映射命令到相应的模式
    local commandModes = {
        all = "ALL",
        tradelog = "TRADE",
        tl = "TRADE",  -- 添加对 /tl 的支持
        maillog = "MAIL",
        ml = "MAIL",   -- 添加对 /ml 的支持
        sent = "SMAIL",
        sm = "SMAIL", -- 添加对 /sm 的支持
        received = "RMAIL",
        rm = "RMAIL"  -- 添加对 /rm 的支持
    }

    local mode = commandModes[cmd]

    if cmd == "gui" then
        Addon.SetWindow.background:SetShown(not Addon.SetWindow.background:IsShown())
    elseif mode then
        ShowUIElements(true)  -- 显示UI元素
        PrintAndRefresh(mode) -- 打印交易记录并刷新日历
    else
        print(L["MAILLOGGER TIPS"])
    end
end