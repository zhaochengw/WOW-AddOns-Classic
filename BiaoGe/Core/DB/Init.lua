local AddonName, ns = ...

local L = ns.L

local pt = print

local RR = "|r"
ns.RR = RR
local NN = "\n"
ns.NN = NN
local RN = "|r\n"
ns.RN = RN

BG = {}

----------tbl元素个数----------
local function Size(t)
    local s = 0
    for k, v in pairs(t) do
        if v ~= nil then s = s + 1 end
    end
    return s
end
ns.Size = Size

----------把16进制颜色转换成0-1RGB----------
local function RGB(hex, Alpha)
    local red = hex:sub(1, 2)
    local green = hex:sub(3, 4)
    local blue = hex:sub(5, 6)

    red = tonumber(red, 16) / 255
    green = tonumber(green, 16) / 255
    blue = tonumber(blue, 16) / 255

    if Alpha then
        return red, green, blue, Alpha
    else
        return red, green, blue
    end
end
ns.RGB = RGB

----------DB_Loot插入职业任务文本----------
local function ClassQuest(classID)
    local className, classFile, classID = GetClassInfo(classID)
    local color = select(4, GetClassColor(classFile))
    return "|c" .. color .. className .. "|r" .. BG.STC_y1(QUESTS_LABEL)
end
ns.ClassQuest = ClassQuest


-- 注册事件
do
    local addonLoadedFuncs = {}
    local f = CreateFrame("Frame")
    f:RegisterEvent("ADDON_LOADED")
    f:SetScript("OnEvent", function(self, event, addonName)
        if addonName ~= AddonName then return end
        self:UnregisterEvent("ADDON_LOADED")
        for _, func in ipairs(addonLoadedFuncs) do
            securecall(func)
        end
    end)
    function BG.Init(func)
        tinsert(addonLoadedFuncs, func)
    end

    local enterWorldFuncs = {}
    local f = CreateFrame("Frame")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:SetScript("OnEvent", function(self, event, ...)
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        for _, func in ipairs(enterWorldFuncs) do
            securecall(func)
        end
    end)
    function BG.Init2(func)
        tinsert(enterWorldFuncs, func)
    end

    local loginFuncs = {}
    local f = CreateFrame("Frame")
    f:RegisterEvent("PLAYER_LOGIN")
    f:SetScript("OnEvent", function(self, event)
        self:UnregisterEvent("PLAYER_LOGIN")
        for _, func in ipairs(loginFuncs) do
            securecall(func)
        end
    end)
    function BG.Init3(func)
        tinsert(loginFuncs, func)
    end

    local events = {}
    local f = CreateFrame("Frame")
    f:SetScript("OnEvent", function(_, event, ...)
        for _, func in ipairs(events[event]) do
            if event == "COMBAT_LOG_EVENT_UNFILTERED" then
                securecall(func, f, event, CombatLogGetCurrentEventInfo())
            else
                securecall(func, f, event, ...)
            end
        end
    end)
    function BG.RegisterEvent(event, func)
        if not events[event] then
            events[event] = {}
            f:RegisterEvent(event)
        end
        tinsert(events[event], func)
    end
end


-- 版本号
if GetCurrentRegion() ~= 5 then
    BG.IsTW = true
end

local ver = select(4, GetBuildInfo())
if ver < 30000 then
    BG.verLess2 = true
end
if ver >= 30000 then
    BG.verOver3 = true
end
if ver >= 40000 then
    BG.verOver4 = true
end
if ver >= 50000 then
    BG.verOver5 = true
end

if ver < 20000 then
    BG.IsVanilla = true
    BG.onlyOneHard = true
    if (C_Engraving and C_Engraving.IsEngravingEnabled()) then
        BG.IsVanilla_Sod = true
    else
        BG.IsVanilla_60 = true
    end
end

if ver >= 20000 and ver < 30000 then
    BG.IsTBC = true
    BG.onlyOneHard = true
end

if ver >= 30000 and ver < 40000 then
    BG.IsWLK = true
    if ver >= 38000 then
        BG.IsTitan = true
        BG.onlyOneHard = true
    else
        BG.IsWLK_80 = true
    end
end

if ver >= 40000 and ver < 50000 then
    BG.IsCTM = true
end

if ver >= 50000 and ver < 60000 then
    BG.IsMOP = true
    if BG.IsTW then
        BG.IsMOP_TW = true
    else
        BG.IsMOP_CN = true
    end
    -- BG.IsTW = true
    -- BG.IsMOP_TW = true
    -- BG.IsMOP_CN = nil
end

if ver >= 110000 then
    BG.IsRetail = true
end

BG.IsNewUI = true


function BG.IsWLKFB(FB)
    local FB = FB or BG.FB1
    if (FB == "NAXX" and not BG.IsVanilla) or FB == "ULD" or FB == "TOC" or FB == "ICC" then
        return true
    end
end

local tbl = { "SW", "BT", "HS", "TK", "SSC", "ZA", "KZ", "BWL", "TAQ", }
function BG.IsTBCFB(FB)
    if not BG.IsWLK then return false end
    local FB = FB or BG.FB1
    for _, _FB in ipairs(tbl) do
        if FB == _FB then
            return true
        end
    end
end

-- 阵营
if UnitFactionGroup("player") == "Alliance" then
    BG.IsAlliance = true
end

if UnitFactionGroup("player") == "Horde" then
    BG.IsHorde = true
end

function BG.GN(unit)
    unit = unit or "player"
    if unit == "t" then
        unit = "target"
    end
    return GetUnitName(unit, true)
end

BG.playerName = BG.GN()
BG.realmName = GetRealmName():gsub(" ", ""):gsub("%-", "")
BG.realmID = GetRealmID()

function BG.GFN(name)
    if not name then return end
    local name, realm = strsplit("-", name)
    realm = realm or BG.realmName
    return name .. "-" .. realm
end

function BG.GSN(name)
    if not name then return end
    local name, realm = strsplit("-", name)
    if not realm or realm == "" or realm == BG.realmName then
        return name
    else
        return name .. "-" .. realm
    end
end

function BG.SPN(name)
    if not name then return end
    return strsplit("-", name, 2)
end

-- 增加节日掉落
function BG.AddHolidayLoot(lootInfo)
    BG.hasHolidayLoot = true
    local f = CreateFrame("Frame")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:RegisterEvent("CALENDAR_UPDATE_EVENT_LIST")
    f:SetScript("OnEvent", function(self, event, isLogin, isReload)
        if event == "PLAYER_ENTERING_WORLD" then
            if isLogin then
                return
            else
                self:UnregisterEvent("PLAYER_ENTERING_WORLD")
            end
        end

        local all = {}

        local currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime()
        local day = currentCalendarTime.monthDay
        local numEvents = C_Calendar.GetNumDayEvents(0, day)
        if numEvents <= 0 then
            return
        end

        for i = 1, numEvents do
            local event = C_Calendar.GetDayEvent(0, day, i)
            if event and lootInfo[event.eventID] then
                BG.hasHoliday = true
                tinsert(all, lootInfo[event.eventID])
            end
        end

        for _, FB in pairs(BG.FBtable) do
            BG.Loot[FB].Holiday = all
        end

        if BG.hasHoliday then
            BG.InitHoliday()
        end
    end)
end

-- 特殊兑换物
function BG.InsertExLoot(FB, tbl)
    for exItem, loot in pairs(tbl) do
        BG.Loot[FB].ExchangeItems[exItem] = BG.Loot[FB].ExchangeItems[exItem] or {}
        for _, itemID in pairs(loot.items) do
            tinsert(BG.Loot[FB].ExchangeItems[exItem], itemID)
            for _, bossInfo in pairs(loot.boss) do
                local boss, hard = strsplit("-", bossInfo)
                BG.Loot[FB][hard]["boss" .. boss .. "other"] =
                    BG.Loot[FB][hard]["boss" .. boss .. "other"] or {}
                tinsert(BG.Loot[FB][hard]["boss" .. boss .. "other"], itemID)
            end
        end
    end
end

-- 套装相关
function BG.InsertSetLoot(FB, tbl)
    for boss, loot in pairs(tbl) do
        for hard, _loot in pairs(loot) do
            BG.Loot[FB][hard]["boss" .. boss .. "other"] =
                BG.Loot[FB][hard]["boss" .. boss .. "other"] or {}
            for exItemID, items in pairs(_loot) do
                BG.Loot[FB].ExchangeItems[exItemID] = items
                for _, itemID in pairs(items) do
                    tinsert(BG.Loot[FB][hard]["boss" .. boss .. "other"], itemID)
                end
            end
        end
    end
end
