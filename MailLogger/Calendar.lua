-- 日曆Frame

local _, Addon = ...

local Calendar = Addon.Calendar
local TradeLog = Addon.TradeLog
local L = Addon.L
local AvailableDate = {}

-- 辅助函数：解析日期字符串为年、月、日
local function ParseDate(dateStr)
    local year, month, day = strsplit("-", dateStr or "")
    return year, month, day
end

-- 辅助函数：获取指定月份的最后一天
local function GetEndDayOfMonth(year, month)
    if month == 2 then
        if (year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0 then
            return 29 -- 闰年二月有29天
        else
            return 28 -- 平年二月有28天
        end
    elseif month == 4 or month == 6 or month == 9 or month == 11 then
        return 30 -- 四月、六月、九月和十一月有30天
    else
        return 31 -- 其他月份有31天
    end
end

-- 获取可用日期
function Addon:GetAvailableDate(IsFirst)
    AvailableDate = {}
    if #TradeLog > 0 and TradeLog[#TradeLog].Date then
        for i = 1, #TradeLog do
            local year, month, day = ParseDate(TradeLog[i].Date)
            if not AvailableDate[year] then
                AvailableDate[year] = {}
            end
            if not AvailableDate[year][month] then
                AvailableDate[year][month] ={}
            end
            AvailableDate[year][month][day] = true
       end
       if IsFirst then
            Addon.SetYear, Addon.SetMonth, Addon.SetDay = ParseDate(TradeLog[#TradeLog].Date)
       end
    else
        if IsFirst then
            Addon.SetYear, Addon.SetMonth, Addon.SetDay = ParseDate(date("%Y-%m-%d"))
        end
    end
end

--- 刷新日期按钮
function Addon:RefreshCalendar()
    local CurrentMonth = { year = Addon.SetYear, month = Addon.SetMonth, day = "01" }
    local SkipDays = date("%w", time(CurrentMonth))
    local EndDay = GetEndDayOfMonth(tonumber(Addon.SetYear), tonumber(Addon.SetMonth))

    for i = 1, 42 do
        Calendar.Days[i]:SetText("")
        Calendar.Days[i]:Disable()
    end

    for i = 1, EndDay do
        Calendar.Days[i + SkipDays]:SetText(i)

        if AvailableDate[Addon.SetYear] and AvailableDate[Addon.SetYear][Addon.SetMonth] and AvailableDate[Addon.SetYear][Addon.SetMonth][string.format("%02d",i)] then
            Calendar.Days[i + SkipDays]:Enable()
            Calendar.Days[i + SkipDays]:SetScript("OnClick", function()
                local SelectedDate = Addon.SetYear.."-"..Addon.SetMonth.."-"..string.format("%02d", i)
                Addon:PrintTradeLog(Addon.Config.Mode, Addon.Config.OnlyThisCharacter and Addon.Config.SelectName or nil, SelectedDate)
            end)
        end
    end
end


-- 創建日期按鈕
local function CreateDateButton(index)
    local b = CreateFrame("Button", "MLCalendarDay"..index.."Button", Calendar.background, "UIPanelButtonTemplate")
    b.texture = b:CreateTexture()
    b.texture:SetAllPoints(b)
    b:SetSize(40, 30)
    return b
end

-- 初始化日曆Frame
function Calendar:Initialize()
    local f = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
    f:SetWidth(320)
    f:SetHeight(320)
    f:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = {left = 8, right = 8, top = 10, bottom = 10}
    })
    f:SetBackdropColor(0, 0, 0)
    f:SetPoint("TOPRIGHT", Addon.Output.background, "TOPLEFT", 1, 0)
    f:SetToplevel(true)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", function(self)
        if not InCombatLockdown() then
            f:StartMoving()
        end
    end)
    f:SetScript("OnDragStop", function(self)
        f:StopMovingOrSizing()
    end)
    f:SetPropagateKeyboardInput(false)
    f:SetScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            f:SetPropagateKeyboardInput(false)
            f:Hide()
        else
            f:SetPropagateKeyboardInput(true)
        end
    end)
    f:Hide()
	self.background = f
    do -- 创建框体标题栏纹理
        local t = f:CreateTexture(nil, "ARTWORK")
        t:SetTexture("Interface/DialogFrame/UI-DialogBox-Header")
        t:SetWidth(360)
        t:SetHeight(64)
        t:SetPoint("TOP", f, 0, 12)
        f.texture = t
    end
    do -- 创建框体标题
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        t:SetText(L["Calendar"])
        t:SetPoint("TOP", f.texture, 0, -14)
        self.title = t
    end
    Addon:GetAvailableDate(true)
    do -- 年份下拉菜單
        local d = CreateFrame("Frame", nil, f, "UIDropDownMenuTemplate")
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmallLeft")
        t:SetText(L["Year"])
        t:SetPoint("LEFT", d, "LEFT", -25, 2)

        local value = {}
        local text = {}
        local index = 1

        for k in pairs(AvailableDate) do
            table.insert(value, index)
            table.insert(text, k)
            index = index + 1
        end

        UIDropDownMenu_Initialize(d, function(self)
            local info = UIDropDownMenu_CreateInfo()
            d.text = text
            for i = 1, #text do
                info.text = text[i]
                info.value = value[i]
                info.func = function(v)
                    Addon.SetYear = text[v.value]
                    UIDropDownMenu_SetText(d, text[v.value])
                    CloseDropDownMenus()
                end
                info.arg1, info.arg2 = d, value[i]
                UIDropDownMenu_AddButton(info)
            end
        end)
        d.SetValue = function(v) Addon.SetYear = text[v] end
        d:SetScript("OnShow", function(self)
            UIDropDownMenu_SetText(self, Addon.SetYear)
        end)
        UIDropDownMenu_JustifyText(d, "CENTER")
        UIDropDownMenu_SetWidth(d, 70)
        UIDropDownMenu_SetButtonWidth(d, 70)
        d:SetPoint("TOPLEFT", 50, -30)
        self.YearDropMenu = d
    end
    do -- 月份下拉菜單
        local d = CreateFrame("Frame", nil, f, "UIDropDownMenuTemplate")
        local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormalSmallLeft")
        t:SetText(L["Month"])
        t:SetPoint("LEFT", d, "LEFT", -35, 2)

        local value = {1,2,3,4,5,6,7,8,9,10,11,12,}
        local text = {"01","02","03","04","05","06","07","08","09","10","11","12",}

        UIDropDownMenu_Initialize(d, function(self)
            local info = UIDropDownMenu_CreateInfo()
            d.text = text
            for i = 1, #text do
                info.text = text[i]
                info.value = value[i]
                info.func = function(v)
                    Addon.SetMonth = text[v.value]
                    UIDropDownMenu_SetText(d, text[v.value])
                    CloseDropDownMenus()
                    Addon:RefreshCalendar()
                end
                info.arg1, info.arg2 = d, value[i]
                UIDropDownMenu_AddButton(info)
            end
        end)
        d.SetValue = function(v)
            Addon.SetMonth = text[v]
        end
        d:SetScript("OnShow", function(self)
            UIDropDownMenu_SetText(self, Addon.SetMonth)
        end)
        UIDropDownMenu_JustifyText(d, "CENTER")
        UIDropDownMenu_SetWidth(d, 55)
        UIDropDownMenu_SetButtonWidth(d, 55)
        d:SetPoint("TOPLEFT", 200, -30)
        self.MonthDropMenu = d
    end
    do -- 创建关闭按钮
        local cls = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        cls:SetWidth(80)
        cls:SetHeight(30)
        cls:SetPoint("BOTTOMLEFT", 220, 15)
        cls:SetText(CLOSE)
        cls:SetScript("OnClick", function()
            f:Hide()
            Addon.Output.background:Hide()
        end)
    end
    do -- 创建全部按钮
        local all = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        all:SetWidth(80)
        all:SetHeight(30)
        all:SetPoint("BOTTOMLEFT", 20, 15)
        all:SetText(L["All Dates"])
        all:SetScript("OnClick", function()
            Addon.Output.dropdowntitle:Show()
			Addon.Output.dropdownlist:Show()
			Addon.Output.dropdownbutton:Show()
            if Addon.Config.OnlyThisCharacter then
                Addon:PrintTradeLog(Addon.Config.Mode, Addon.Config.SelectName)
            else
                Addon:PrintTradeLog(Addon.Config.Mode, nil)
            end
			Addon:GetAvailableDate(false)
			Addon.Calendar.background:Show()
			Addon:RefreshCalendar()
        end)
    end
    do -- 初始化日期按鈕
        do
            local Week = {
                ["Text"] = {L["Sun"], L["Mon"], L["Tue"], L["Wed"], L["Thu"], L["Fri"], L["Sat"],},
                ["Button"] = {},
            }
            for i = 1, 7 do
                table.insert(Week.Button, CreateDateButton(Week.Text[i]))
                Week.Button[i]:SetText(Week.Text[i])
                Week.Button[i]:SetPoint("TOP", f, -120+(i-1)*40, -60)
                Week.Button[i]:Disable()
            end
        end
        Calendar.Days = {}
        for i = 1, 42 do
            table.insert(Calendar.Days, CreateDateButton(i))
        end
        for i = 1, 6 do
            for j = 1, 7 do
                Calendar.Days[(i-1)*7+j]:SetPoint("TOP", f, -120+(j-1)*40, -90-(i-1)*30)
                Calendar.Days[(i-1)*7+j]:Disable()
            end
        end
        Addon:RefreshCalendar()
    end
end
