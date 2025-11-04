local _, addonTable = ...

addonTable.AmplificationItems = {
  [104976] = true, -- Prismatic Prison of Pride, Raid Finder
  [104727] = true, -- Prismatic Prison of Pride, Flexible
  [102299] = true, -- Prismatic Prison of Pride
  [105225] = true, -- Prismatic Prison of Pride, Warforged
  [104478] = true, -- Prismatic Prison of Pride, Heroic
  [105474] = true, -- Prismatic Prison of Pride, Heroic Warforged

  [104924] = true, -- Purified Bindings of Immerseus, Raid Finder
  [104675] = true, -- Purified Bindings of Immerseus, Flexible
  [102293] = true, -- Purified Bindings of Immerseus
  [105173] = true, -- Purified Bindings of Immerseus, Warforged
  [104426] = true, -- Purified Bindings of Immerseus, Heroic
  [105422] = true, -- Purified Bindings of Immerseus, Heroic Warforged

  [105111] = true, -- Thok's Tail Tip, Raid Finder
  [104862] = true, -- Thok's Tail Tip, Flexible
  [102305] = true, -- Thok's Tail Tip
  [105360] = true, -- Thok's Tail Tip, Warforged
  [104613] = true, -- Thok's Tail Tip, Heroic
  [105609] = true, -- Thok's Tail Tip, Heroic Warforged
}


addonTable.RandPropPoints = {
    [463] = {1710, 1270, 953, 733, 538},
    [528] = {3134, 2328, 1746, 1343, 985},
    [529] = {3163, 2350, 1762, 1356, 994},
    [530] = {3193, 2372, 1779, 1368, 1003},
    [531] = {3223, 2394, 1796, 1381, 1013},
    [532] = {3253, 2416, 1812, 1394, 1022},
    [533] = {3283, 2439, 1829, 1407, 1032},
    [534] = {3314, 2462, 1846, 1420, 1042},
    [535] = {3345, 2485, 1864, 1434, 1051},
    [536] = {3376, 2508, 1881, 1447, 1061},
    [537] = {3408, 2532, 1899, 1461, 1071},
    [538] = {3440, 2555, 1917, 1474, 1081},
    [539] = {3472, 2579, 1934, 1488, 1091},
    [540] = {3505, 2603, 1953, 1502, 1101},
    [541] = {3537, 2628, 1971, 1516, 1112},
    [542] = {3571, 2652, 1989, 1530, 1122},
    [543] = {3604, 2677, 2008, 1545, 1133},
    [544] = {3638, 2702, 2027, 1559, 1143},
    [545] = {3672, 2728, 2046, 1574, 1154},
    [546] = {3706, 2753, 2065, 1588, 1165},
    [547] = {3741, 2779, 2084, 1603, 1176},
    [548] = {3776, 2805, 2104, 1618, 1187},
    [549] = {3811, 2831, 2123, 1633, 1198},
    [550] = {3847, 2858, 2143, 1649, 1209},
    [551] = {3883, 2884, 2163, 1664, 1220},
    [552] = {3919, 2911, 2184, 1680, 1232},
    [553] = {3956, 2939, 2204, 1695, 1243},
    [554] = {3993, 2966, 2225, 1711, 1255},
    [555] = {4030, 2994, 2245, 1727, 1267},
    [556] = {4068, 3022, 2266, 1743, 1279},
    [557] = {4106, 3050, 2288, 1760, 1290},
    [558] = {4145, 3079, 2309, 1776, 1303},
    [559] = {4183, 3108, 2331, 1793, 1315},
    [560] = {4222, 3137, 2353, 1810, 1327},
    [561] = {4262, 3166, 2375, 1827, 1339},
    [562] = {4302, 3196, 2397, 1844, 1352},
    [563] = {4342, 3226, 2419, 1861, 1365},
    [564] = {4383, 3256, 2442, 1878, 1377},
    [565] = {4424, 3286, 2465, 1896, 1390},
    [566] = {4465, 3317, 2488, 1914, 1403},
    [567] = {4507, 3348, 2511, 1932, 1417},
    [568] = {4549, 3379, 2535, 1950, 1430},
    [569] = {4592, 3411, 2558, 1968, 1443},
    [570] = {4635, 3443, 2582, 1986, 1457},
    [571] = {4678, 3475, 2606, 2005, 1470},
    [572] = {4722, 3508, 2631, 2024, 1484},
    [573] = {4766, 3541, 2655, 2043, 1498},
    [574] = {4811, 3574, 2680, 2062, 1512},
    [575] = {4856, 3607, 2705, 2081, 1526},
    [576] = {4901, 3641, 2731, 2101, 1540},
    [577] = {4947, 3675, 2756, 2120, 1555},
    [578] = {4994, 3709, 2782, 2140, 1569},
    [579] = {5040, 3744, 2808, 2160, 1584},
    [580] = {5087, 3779, 2834, 2180, 1599},
}

---Gets random property points for an item level and slot type
---@param iLvl number Item level
---@param t number Slot type index
---@return number points Random property points for the item level and slot
function addonTable.GetRandPropPoints(iLvl, t)
    return (addonTable.RandPropPoints[iLvl] and addonTable.RandPropPoints[iLvl][t] or 0)
end
