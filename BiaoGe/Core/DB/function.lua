local _, ns = ...

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
ns.RGB = RGB

----------DB_Loot插入职业任务文本----------
local function ClassQuest(classID)
    local className, classFile, classID = GetClassInfo(classID)
    local color = select(4, GetClassColor(classFile))
    return "|c" .. color .. className .. "|r" .. BG.STC_y1(QUESTS_LABEL)
end
ns.ClassQuest = ClassQuest

-- 版本号
local ver = select(4, GetBuildInfo())
if ver < 20000 then
    BG.IsVanilla = true
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

if ver >= 40000 and ver < 50000 then
    BG.IsCTM = true
end

if ver == 11503 then
    BG.Is11503 = true
end

function BG.IsWLKFB(FB)
    local FB = FB or BG.FB1
    if (FB == "NAXX" and not BG.IsVanilla) or FB == "ULD" or FB == "TOC" or FB == "ICC" then
        return true
    end
end

-- 阵营
if UnitFactionGroup("player") == "Alliance" then
    BG.IsAlliance = true
end

if UnitFactionGroup("player") == "Horde" then
    BG.IsHorde = true
end
