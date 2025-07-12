local _, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local pt = print

BG.Loot.encounterID = {}
-- Sod
if BG.IsVanilla_Sod then
    BG.Loot.encounterID.BD = {
        2694,
        2697,
        2699,
        2704,
        2710,
        2825,
        2891,
    }
    BG.Loot.encounterID.Gno = {
        2925,
        2928,
        2899,
        2927,
        2935,
        2940,
    }
    BG.Loot.encounterID.Temple = {
        2952,
        2953,
        2954,
        2955,
        2957,
        2958,
        2959,
        2956,
    }
    BG.Loot.encounterID.MCsod = {
        663,
        664,
        665,
        666,
        667,
        668,
        669,
        670,
        671,
        672,
        3018, -- 熔火之心
    }
    BG.Loot.encounterID.ZUGsod = {
        785,
        784,
        786,
        787,
        788,
        790,
        789,
        791,
        792,
        793,
    }
    BG.Loot.encounterID.BWLsod = {
        610,
        611,
        612,
        613,
        0, -- 5号6号合并，因为是同时击杀
        616,
        617,
    }
    BG.Loot.encounterID.Worldsod = {
        1084, -- 黑龙
        3027, -- 蓝龙
        3026, -- 卡扎克
        3079, -- 桑兰德
        0,    -- 莱索恩
        0,    -- 艾莫莉丝
        0,    -- 泰拉尔
        0,    -- 伊森德雷
    }
end

-- 60
if BG.IsVanilla then
    BG.Loot.encounterID.MC = {
        663,
        664,
        665,
        666,
        667,
        668,
        669,
        670,
        671,
        672,
        1084,
    }
    BG.Loot.encounterID.BWL = {
        610,
        611,
        612,
        613,
        614,
        615,
        616,
        617,
    }
    BG.Loot.encounterID.ZUG = {
        785,
        784,
        786,
        787,
        788,
        790,
        789,
        791,
        792,
        793,
    }
    BG.Loot.encounterID.AQL = {
        718,
        719,
        720,
        721,
        722,
        723,
    }
    BG.Loot.encounterID.TAQ = {
        709,
        710,
        711,
        712,
        713,
        714,
        715,
        716,
        717,
    }
    BG.Loot.encounterID.NAXX = {
        1107,
        1110,
        1116,
        1117,
        1112,
        1115,
        1113,
        1109,
        1121,
        1118,
        1111,
        1108,
        1120,
        1119,
        1114,
    }
end

-- WLK
if BG.IsWLK then
    BG.Loot.encounterID.NAXX = {
        1107,
        1110,
        1116,
        1118,
        1111,
        1108,
        1120,
        1113,
        1109,
        1121,
        1117,
        1112,
        1115,
        1119,
        1114,
        742,
        734,
    }
    BG.Loot.encounterID.ULD = {
        744,
        746,
        745,
        747,
        748,
        749,
        750,
        751,
        752,
        753,
        754,
        755,
        756,
        757,
    }
    BG.Loot.encounterID.TOC = {
        629,
        633,
        637,
        641,
        645,
        0,
        1084,
    }
    BG.Loot.encounterID.ICC = {
        845,
        846,
        847,
        848,
        849,
        850,
        851,
        852,
        853,
        854,
        855,
        856,
        887,
    }

    -- TBC
    BG.Loot.encounterID.SW = {
        724,
        725,
        726,
        727,
        728,
        729,
    }
    BG.Loot.encounterID.BT = {
        601,
        602,
        603,
        604,
        605,
        606,
        607,
        608,
        609,
    }
    BG.Loot.encounterID.HS = {
        618,
        619,
        620,
        621,
        622,
    }
    BG.Loot.encounterID.SSC = {
        623,
        624,
        625,
        626,
        627,
        628,
        730,
        731,
        732,
        733,
    }
    BG.Loot.encounterID.BWL = {
        610,
        611,
        612,
        613,
        614,
        615,
        616,
        617,
    }
    BG.Loot.encounterID.TAQ = {
        709,
        710,
        711,
        712,
        713,
        714,
        715,
        716,
        717,
    }
elseif BG.IsCTM then
    BG.Loot.encounterID.NAXX = {
        1107,
        1110,
        1116,
        1118,
        1111,
        1108,
        1120,
        1113,
        1109,
        1121,
        1117,
        1112,
        1115,
        1119,
        1114,
        1119,
        1114,
        1090,
        1094,
    }
    BG.Loot.encounterID.ULD = {
        1132,
        1139,
        1136,
        1142,
        1140,
        1137,
        1131,
        1135,
        1141,
        1133,
        1138,
        1134,
        1143,
        1130,
    }
    BG.Loot.encounterID.TOC = {
        1088,
        1087,
        1086,
        1089,
        1085,
        0,
        1084,
    }
    BG.Loot.encounterID.ICC = {
        1101,
        1100,
        1099,
        1096,
        1097,
        1104,
        1102,
        1095,
        1103,
        1098,
        1105,
        1106,
        1150,
    }
end

-- CTM
if BG.IsCTM or BG.IsMOP then
    BG.Loot.encounterID.BOT = {
        1030,
        1032,
        1028,
        1029,
        1082,
        1027,
        1024,
        1022,
        1023,
        1025,
        1026,
        1035,
        1034,
    }
    BG.Loot.encounterID.FL = {
        1197,
        1204,
        1206,
        1205,
        1200,
        1185,
        1203,
    }
    BG.Loot.encounterID.DS = {
        1292,
        1294,
        1295,
        1296,
        1297,
        1298,
        1291,
        1299,
    }
end

-- CTM
if BG.IsMOP then
    BG.Loot.encounterID.MSV = {
        1395,
        1390,
        1434,
        1436,
        1500,
        1407,
        1507,
        1504,
        1463,
        1498,
        1499,
        1501,
        1409,
        1505,
        1506,
        1431,
    }
end
--[[

        { name = L["石\n头\n守卫"], color = "87CEFA" },
        { name = L["受\n诅\n者\n魔\n封"], color = "87CEFA" },
        { name = L["缚\n灵\n者\n戈\n拉\n亚"], color = "87CEFA" },
        { name = L["先\n王\n之\n魂"], color = "87CEFA" },
        { name = L["伊\n拉\n贡"], color = "87CEFA" },
        { name = L["皇\n帝\n的\n意\n志"], color = "87CEFA" },

        { name = L["皇\n家\n宰\n相\n佐\n尔\n洛\n克"], color = "87CEFA" },
        { name = L["刀\n锋\n领\n主\n塔\n亚\n克"], color = "87CEFA" },
        { name = L["加\n拉\n隆"], color = "87CEFA" },
        { name = L["风\n领\n主\n梅\n尔\n加\n拉\n克"], color = "87CEFA" },
        { name = L["琥\n珀\n塑\n形\n者\n昂\n舒\n克"], color = "87CEFA" },
        { name = L["大\n女\n皇\n夏\n柯\n希\n尔"], color = "87CEFA" },

        { name = L["无\n尽\n守\n护\n者"], color = "87CEFA" },
        { name = L["烛\n龙"], color = "87CEFA" },
        { name = L["雷\n施"], color = "87CEFA" },
        { name = L["惧\n之\n煞"], color = "87CEFA" },
]]
-- Retail
if BG.IsRetail then
    BG.Loot.encounterID.NP = {
        2902,
        2917,
        2898,
        2918,
        2919,
        2920,
        2921,
        2922,
    }
end
