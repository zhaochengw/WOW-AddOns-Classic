-- 日曆Frame

local _, Addon = ...

local Calendar = Addon.Calendar
local TradeLog = Addon.TradeLog
local L = Addon.L
local AvailableDate = Addon.AvailableDate

-- 統計可用日期
function Addon:GetAvailableDate()
    AvailableDate = {}
    if #TradeLog > 0 and TradeLog[#TradeLog].Date then
        for i = 1, #TradeLog do
            local year, month, day = strsplit("-", TradeLog[i].Date)
            if not AvailableDate[year] then
                AvailableDate[year] = {}
            end
            if not AvailableDate[year][month] then
                AvailableDate[year][month] = {}
            end
            if not AvailableDate[year][month][day] then
                AvailableDate[year][month][day] = true
            end
        end
        Addon.SetYear, Addon.SetMonth, Addon.SetDay = strsplit("-", TradeLog[#TradeLog].Date)
    else
        Addon.SetYear, Addon.SetMonth, Addon.SetDay = strsplit("-", date("%Y-%m-%d"))
    end
end

-- 刷新日期按鈕
function Addon:RefreshCalendar()
    local CurrentMonth = {}
    CurrentMonth.year, CurrentMonth.month, CurrentMonth.day = Addon.SetYear, Addon.SetMonth, "01"
    local SkipDays = date("%w", time(CurrentMonth))
    local BigMonth = {
        ["01"] = true,
        ["03"] = true,
        ["05"] = true,
        ["07"] = true,
        ["08"] = true,
        ["10"] = true,
        ["12"] = true,
    }
    local EndDay = 0
    if Addon.SetMonth == "02" then
        if math.fmod(Addon.SetYear, 4) == 0 and math.fmod(Addon.SetYear, 100) ~= 0 or math.fmod(Addon.SetYear, 400) == 0  then
            EndDay = 29
        else
            EndDay = 28
        end
    else
        EndDay = BigMonth[Addon.SetMonth] and 31 or 30
    end
    for i = 1, 42 do
        Calendar.Days[i]:SetText("")
        Calendar.Days[i]:Disable()
    end
    for i = 1, EndDay do
        Calendar.Days[i+SkipDays]:SetText(tostring(i))
        if AvailableDate[Addon.SetYear] and AvailableDate[Addon.SetYear][Addon.SetMonth] and AvailableDate[Addon.SetYear][Addon.SetMonth][string.format("%02d",i)] then
            Calendar.Days[i+SkipDays]:Enable()
            Calendar.Days[i+SkipDays]:SetScript("OnClick", function(self)
                Addon:PrintTradeLog("ALL", nil, Addon.SetYear.."-"..Addon.SetMonth.."-"..string.format("%02d",i))
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
    Addon:GetAvailableDate()
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
