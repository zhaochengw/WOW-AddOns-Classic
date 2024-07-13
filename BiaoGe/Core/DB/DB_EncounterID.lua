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
    BG.Loot.encounterID.UBRS = {
        276,
        277,
        0,
        0,
        278,
        279,
        280,
        0,
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
        1084, -- 黑龙
        3027, -- 蓝龙
        3026, -- 卡扎克
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
elseif BG.IsCTM then
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
if BG.IsCTM then
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
