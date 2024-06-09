if not BG.IsVanilla_Sod() then return end

local _, ADDONSELF = ...

local LibBG = ADDONSELF.LibBG
local L = ADDONSELF.L

local pt = print

local function AddDB(usetoitem, needitem, fullitem, emptygive, fullgive, needcount)
    BG.CommerceAuthority[usetoitem] = { needitem = needitem, emptygive = emptygive, fullgive = fullgive }
    BG.CommerceAuthority[needitem] = { usetoitem = usetoitem, emptygive = emptygive, fullgive = fullgive, needcount = needcount }
    if not BG.CommerceAuthority[fullitem] then
        BG.CommerceAuthority[fullitem] = { isfullitem = true, fullgive = fullgive }
    end
end

BG.CommerceAuthority = {}

AddDB(211331, 6290, 211365, 100, 300, 20)
AddDB(210771, 2840, 211365, 100, 300, 20)
AddDB(211332, 2581, 211365, 100, 300, 10)
AddDB(211329, 6888, 211365, 100, 300, 20)
AddDB(211315, 2318, 211365, 100, 300, 14)
AddDB(211316, 2447, 211365, 100, 300, 20)
AddDB(211933, 2835, 211365, 100, 300, 10)
AddDB(211317, 765, 211365, 100, 300, 20)
AddDB(211330, 2680, 211365, 100, 300, 20)

AddDB(211327, 4343, 211367, 100, 450, 6)
AddDB(211328, 6238, 211367, 100, 450, 4)
AddDB(211319, 2847, 211367, 100, 450, 6)
AddDB(211326, 2300, 211367, 100, 450, 3)
AddDB(211325, 4237, 211367, 100, 450, 5)
AddDB(211934, 929, 211367, 100, 450, 10)
AddDB(211321, 11287, 211367, 100, 450, 2)
AddDB(211318, 118, 211367, 100, 450, 20)
AddDB(211322, 20744, 211367, 100, 450, 2)
AddDB(211324, 4362, 211367, 100, 450, 3)
AddDB(211323, 4360, 211367, 100, 450, 12)
AddDB(211320, 3473, 211367, 100, 450, 3)

AddDB(211819, 2841, 211839, 200, 500, 12)
AddDB(211822, 2453, 211839, 200, 500, 20)
AddDB(211837, 5527, 211839, 200, 500, 8)
AddDB(211838, 3531, 211839, 200, 500, 15)
AddDB(211821, 2319, 211839, 200, 500, 12)
AddDB(211820, 2842, 211839, 200, 500, 6)
AddDB(211836, 6890, 211839, 200, 500, 20)
AddDB(211835, 21072, 211839, 200, 500, 15)
AddDB(211823, 2452, 211839, 200, 500, 20)

AddDB(211831, 2316, 211840, 200, 650, 2)
AddDB(211833, 2587, 211840, 200, 650, 4)
AddDB(211824, 3385, 211840, 200, 650, 20)
AddDB(211828, 20745, 211840, 200, 650, 2)
AddDB(211825, 6350, 211840, 200, 650, 3)
AddDB(211829, 4374, 211840, 200, 650, 12)

AddDB(211935, 6373, 211841, 200, 800, 15)
AddDB(211832, 4251, 211841, 200, 800, 2)
AddDB(211830, 5507, 211841, 200, 800, 2)
AddDB(211834, 5542, 211841, 200, 800, 3)
AddDB(211827, 6339, 211841, 200, 800, 1)
AddDB(211826, 15869, 211841, 200, 800, 14)

-- pt("|cffffffff|Hitem:211827::::::::::::::::::|h[测试物品]|h|r")
-- pt("|cffffffff|Hitem:211828::::::::::::::::::|h[测试物品]|h|r")
-- pt("|cffffffff|Hitem:211829::::::::::::::::::|h[测试物品]|h|r")
-- pt("|cffffffff|Hitem:211830::::::::::::::::::|h[测试物品]|h|r")
-- pt("|cffffffff|Hitem:211831::::::::::::::::::|h[测试物品]|h|r")
-- pt("|cffffffff|Hitem:2319::::::::::::::::::|h[测试物品]|h|r")
--[[
/run print(GetItemInfo(211831))
 ]]
