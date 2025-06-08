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

function BG.Init(func)
    local f = CreateFrame("Frame")
    f:RegisterEvent("ADDON_LOADED")
    f:SetScript("OnEvent", function(self, event, addonName)
        if addonName ~= AddonName then return end
        self:UnregisterEvent("ADDON_LOADED")
        self:Hide()
        func()
    end)
end

function BG.Init2(func)
    local f = CreateFrame("Frame")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:SetScript("OnEvent", function(self, event)
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        self:Hide()
        func()
    end)
end

-- 版本号
local ver = select(4, GetBuildInfo())
if ver < 20000 then
    BG.IsVanilla = true
    BG.IsNewUI = true
end

if BG.IsVanilla and (C_Engraving and C_Engraving.IsEngravingEnabled()) then
    BG.IsVanilla_Sod = true
end

if BG.IsVanilla and not (C_Engraving and C_Engraving.IsEngravingEnabled()) then
    BG.IsVanilla_60 = true
end

if ver >= 30000 and ver < 40000 then
    BG.IsWLK = true
end

if ver >= 40000 and ver < 60000 then
    BG.IsCTM = true
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

local tbl = { "SW", "BT", "HS", "TK", "SSC", "ZA", "KZ", "BWL" ,"TAQ",}
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

function BG.GFN(name)
    if not name then return end
    local name, realm = strsplit("-", name)
    realm = realm or GetRealmName()
    return name .. "-" .. realm
end

function BG.GSN(name)
    if not name then return end
    local name, realm = strsplit("-", name)
    if not realm or realm == "" or realm == GetRealmName() then
        return name
    else
        return name .. "-" .. realm
    end
end

function BG.SPN(name)
    if not name then return end
    return strsplit("-", name)
end
