if not BG.IsVanilla_Sod then return end

local _, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local pt = print

local LibRecipes = LibStub("LibRecipes-3.0")

local function AddDB(usetoitem, needitem, needcount, fullitem, emptygive, fullgive, moneygive, topFactionValue)
    moneygive = moneygive * 10000 -- 转换金币银币铜币
    BG.CommerceAuthority[usetoitem] = { needitem = needitem, emptygive = emptygive, fullgive = fullgive, moneygive = moneygive, topFactionValue = topFactionValue }
    BG.CommerceAuthority[needitem] = { usetoitem = usetoitem, emptygive = emptygive, fullgive = fullgive, needcount = needcount, moneygive = moneygive, topFactionValue = topFactionValue }
    if not BG.CommerceAuthority[fullitem] then
        BG.CommerceAuthority[fullitem] = { isfullitem = true, fullgive = fullgive, moneygive = moneygive, topFactionValue = topFactionValue }
    end

    local peifang = LibRecipes:GetItemInfo(needitem)
    if peifang and not BG.CommerceAuthority[peifang] then
        BG.CommerceAuthority[peifang] = { usetoitem = usetoitem, needitem = needitem, emptygive = emptygive, fullgive = fullgive, needcount = needcount, moneygive = moneygive, topFactionValue = topFactionValue }
    end
end

BG.CommerceAuthority = {}

AddDB(211331, 6290, 20, 211365, 100, 300, 0.06, 5)
AddDB(210771, 2840, 20, 211365, 100, 300, 0.06, 5)
AddDB(211332, 2581, 10, 211365, 100, 300, 0.06, 5)
AddDB(211329, 6888, 20, 211365, 100, 300, 0.06, 5)
AddDB(211315, 2318, 14, 211365, 100, 300, 0.06, 5)
AddDB(211316, 2447, 20, 211365, 100, 300, 0.06, 5)
AddDB(211933, 2835, 10, 211365, 100, 300, 0.06, 5)
AddDB(211317, 765, 20, 211365, 100, 300, 0.06, 5)
AddDB(211330, 2680, 20, 211365, 100, 300, 0.06, 5)

AddDB(211327, 4343, 6, 211367, 100, 450, 0.15, 5)
AddDB(211328, 6238, 4, 211367, 100, 450, 0.15, 5)
AddDB(211319, 2847, 6, 211367, 100, 450, 0.15, 5)
AddDB(211326, 2300, 3, 211367, 100, 450, 0.15, 5)
AddDB(211325, 4237, 5, 211367, 100, 450, 0.15, 5)
AddDB(211934, 929, 10, 211367, 100, 450, 0.15, 5)
AddDB(211321, 11287, 2, 211367, 100, 450, 0.15, 5)
AddDB(211318, 118, 20, 211367, 100, 450, 0.15, 5)
AddDB(211322, 20744, 2, 211367, 100, 450, 0.15, 5)
AddDB(211324, 4362, 3, 211367, 100, 450, 0.15, 5)
AddDB(211323, 4360, 12, 211367, 100, 450, 0.15, 5)
AddDB(211320, 3473, 3, 211367, 100, 450, 0.15, 5)

AddDB(211819, 2841, 12, 211839, 200, 500, 0.15, 6)
AddDB(211822, 2453, 20, 211839, 200, 500, 0.15, 6)
AddDB(211837, 5527, 8, 211839, 200, 500, 0.15, 6)
AddDB(211838, 3531, 15, 211839, 200, 500, 0.15, 6)
AddDB(211821, 2319, 12, 211839, 200, 500, 0.15, 6)
AddDB(211820, 2842, 6, 211839, 200, 500, 0.15, 6)
AddDB(211836, 6890, 20, 211839, 200, 500, 0.15, 6)
AddDB(211835, 21072, 15, 211839, 200, 500, 0.15, 6)
AddDB(211823, 2452, 20, 211839, 200, 500, 0.15, 6)

AddDB(211831, 2316, 2, 211840, 200, 650, 0.20, 6)
AddDB(211833, 2587, 4, 211840, 200, 650, 0.20, 6)
AddDB(211824, 3385, 20, 211840, 200, 650, 0.20, 6)
AddDB(211828, 20745, 2, 211840, 200, 650, 0.20, 6)
AddDB(211825, 6350, 3, 211840, 200, 650, 0.20, 6)
AddDB(211829, 4374, 12, 211840, 200, 650, 0.20, 6)

AddDB(211935, 6373, 15, 211841, 200, 800, 0.30, 6)
AddDB(211832, 4251, 2, 211841, 200, 800, 0.30, 6)
AddDB(211830, 5507, 2, 211841, 200, 800, 0.30, 6)
AddDB(211834, 5542, 3, 211841, 200, 800, 0.30, 6)
AddDB(211827, 6339, 1, 211841, 200, 800, 0.30, 6)
AddDB(211826, 15869, 14, 211841, 200, 800, 0.30, 6)

-- P2

-- Lv30
AddDB(215413, 4334, 3, 217337, nil, 700, 2, 7)
AddDB(215421, 6371, 7, 217337, nil, 700, 2, 7)
AddDB(215391, 3819, 8, 217337, nil, 700, 2, 7)
AddDB(215420, 4594, 40, 217337, nil, 700, 2, 7)
AddDB(215389, 3818, 16, 217337, nil, 700, 2, 7)
AddDB(215400, 7966, 5, 217337, nil, 700, 2, 7)
AddDB(215387, 4235, 5, 217337, nil, 700, 2, 7)
-- Lv35
AddDB(215392, 8831, 8, 217337, nil, 700, 2, 7)
AddDB(215417, 3729, 10, 217337, nil, 700, 2, 7)
AddDB(215419, 6451, 10, 217337, nil, 700, 2, 7)
AddDB(215388, 4304, 10, 217337, nil, 700, 2, 7)
AddDB(215386, 3860, 6, 217337, nil, 700, 2, 7)
AddDB(215390, 3358, 10, 217337, nil, 700, 2, 7)

-- Lv30
AddDB(215411, 7377, 2, 217338, nil, 850, 5.50, 7)
AddDB(215408, 5966, 5, 217338, nil, 850, 5.50, 7)
AddDB(215398, 3835, 5, 217338, nil, 850, 5.50, 7)
AddDB(215402, 4394, 8, 217338, nil, 850, 5.50, 7)
-- Lv35
AddDB(215407, 5964, 4, 217338, nil, 850, 5.50, 7)
AddDB(215399, 7919, 3, 217338, nil, 850, 5.50, 7)
AddDB(215414, 7062, 4, 217338, nil, 850, 5.50, 7)
AddDB(215401, 4391, 2, 217338, nil, 850, 5.50, 7)
AddDB(215385, 3577, 4, 217338, nil, 850, 5.50, 7)
AddDB(215395, 8949, 6, 217338, nil, 850, 5.50, 7)
AddDB(215393, 1710, 16, 217338, nil, 850, 5.50, 7)
AddDB(215418, 17222, 5, 217338, nil, 850, 5.50, 7) -- 蜘蛛肉肠

-- lv40
AddDB(215416, 10008, 3, 217339, nil, 1000, 12, 7)
AddDB(215409, 8198, 2, 217339, nil, 1000, 12, 7)
AddDB(215397, 3855, 2, 217339, nil, 1000, 12, 7)
AddDB(215396, 8951, 14, 217339, nil, 1000, 12, 7)
AddDB(215404, 10508, 2, 217339, nil, 1000, 12, 7)
AddDB(215415, 4335, 5, 217339, nil, 1000, 12, 7)  -- 紫色丝质衬衣
AddDB(215403, 10546, 2, 217339, nil, 1000, 12, 7) -- 致命瞄准镜

-- P3
local topFactionValue = 8
local fullitem, fullgive, moneygive = 221008, 950, 3.85
AddDB(220918, 16766, 16, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220920, 18045, 12, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220922, 8838, 15, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220927, 8169, 8, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220919, 13931, 8, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220921, 8545, 14, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220923, 13463, 6, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220924, 6037, 12, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220926, 8170, 14, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220925, 12359, 16, fullitem, nil, fullgive, moneygive, topFactionValue)

local fullitem, fullgive, moneygive = 221009, 1300, 8.45
AddDB(220942, 10034, 4, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220940, 10024, 5, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220937, 15564, 12, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220938, 15084, 6, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220931, 10562, 16, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220934, 7931, 3, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220929, 13443, 6, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220930, 13446, 8, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220928, 12655, 4, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220932, 15993, 3, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220935, 12406, 5, fullitem, nil, fullgive, moneygive, topFactionValue)

local fullitem, fullgive, moneygive = 221010, 1850, 15.40
AddDB(220939, 15092, 5, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220941, 13856, 6, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220936, 7938, 2, fullitem, nil, fullgive, moneygive, topFactionValue)
AddDB(220933, 15995, 2, fullitem, nil, fullgive, moneygive, topFactionValue)

-- AddDB(, , , 217339, nil, 1000, 25000)
-- AddDB(, , , fullitem, nil, fullgive, moneygive, topFactionValue)

for itemID in pairs(BG.CommerceAuthority) do
    GetItemInfo(itemID)
end

-- print(GetItemInfo(221010))
-- print(GetItemInfo(220939))
-- print(GetItemInfo(15092))

-- print("|cffffffff|Hitem:211827::::::::::::::::::|h[测试物品]|h|r")
-- print("|cffffffff|Hitem:211828::::::::::::::::::|h[测试物品]|h|r")
-- print("|cffffffff|Hitem:211829::::::::::::::::::|h[测试物品]|h|r")
-- print("|cffffffff|Hitem:211830::::::::::::::::::|h[测试物品]|h|r")
-- print("|cffffffff|Hitem:211831::::::::::::::::::|h[测试物品]|h|r")
-- print("|cffffffff|Hitem:2319::::::::::::::::::|h[测试物品]|h|r")

--[[
5 - Friendly
6 - Honored
7 - Revered
8 - Exalted
 ]]
