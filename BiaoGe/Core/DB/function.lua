local _, ADDONSELF = ...

local L = ADDONSELF.L

local pt = print

local RR = "|r"
ADDONSELF.RR = RR
local NN = "\n"
ADDONSELF.NN = NN
local RN = "|r\n"
ADDONSELF.RN = RN

BG = {}

----------tbl元素个数----------
local function Size(t)
    local s = 0
    for k, v in pairs(t) do
        if v ~= nil then s = s + 1 end
    end
    return s
end
ADDONSELF.Size = Size

----------把16进制颜色转换成0-1RGB----------
local function RGB(hex, Alpha)
    local red = string.sub(hex, 1, 2)
    local green = string.sub(hex, 3, 4)
    local blue = string.sub(hex, 5, 6)

    red = tonumber(red, 16) / 255
    green = tonumber(green, 16) / 255
    blue = tonumber(blue, 16) / 255

    if Alpha then
        return red, green, blue, Alpha
    else
        return red, green, blue
    end
end
ADDONSELF.RGB = RGB

----------DB_Loot插入职业任务文本----------
local function ClassQuest(classID)
    local className, classFile, classID = GetClassInfo(classID)
    local color = select(4, GetClassColor(classFile))
    return "|c" .. color .. className .. "|r" .. BG.STC_y1(QUESTS_LABEL)
end
ADDONSELF.ClassQuest = ClassQuest

-- 版本号
local ver = select(4, GetBuildInfo())
local function IsVanilla()
    if ver < 20000 then
        return true
    end
end
ADDONSELF.IsVanilla = IsVanilla

local function IsVanilla_Sod()
    if BG.IsVanilla() and (C_Engraving and C_Engraving.IsEngravingEnabled()) then
        return true
    end
end
ADDONSELF.IsVanilla_Sod = IsVanilla_Sod

local function IsVanilla_60()
    if BG.IsVanilla() and not (C_Engraving and C_Engraving.IsEngravingEnabled()) then
        return true
    end
end
ADDONSELF.IsVanilla_60 = IsVanilla_60

local function IsWLK()
    if ver >= 30000 and ver < 40000 then
        return true
    end
end
ADDONSELF.IsWLK = IsWLK

local function IsCTM()
    if ver >= 40000 and ver < 50000 then
        return true
    end
end
ADDONSELF.IsCTM = IsCTM

function BG.Is11501()
    if ver == 11501 then return true end
end

function BG.IsWLKFB(FB)
    local FB = FB or BG.FB1
    if (FB == "NAXX" and not BG.IsVanilla()) or FB == "ULD" or FB == "TOC" or FB == "ICC" then
        return true
    end
end

-- 阵营
local function IsAlliance()
    return UnitFactionGroup("player") == "Alliance"
    -- return UnitFactionGroup("player") == "Horde"
end
ADDONSELF.IsAlliance = IsAlliance

local function IsHorde()
    return UnitFactionGroup("player") == "Horde"
    -- return UnitFactionGroup("player") == "Alliance"
end
ADDONSELF.IsHorde = IsHorde
