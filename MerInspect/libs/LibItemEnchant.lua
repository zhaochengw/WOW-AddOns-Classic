
-------------------------------------
-- 物品附魔信息庫 Author: M
-------------------------------------

local MAJOR, MINOR = "LibItemEnchant.7000", 1
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end

lib.ScanTip = CreateFrame("GameTooltip", "LibItemEnchant_ScanTooltip", nil, "GameTooltipTemplate")
lib.ScanTipName = lib.ScanTip:GetName()

-- GENERATE BY https://wago.tools/db2/ItemEffect
local EnchantItemDB = {
    [15] = 2304, -- 轻型护甲片
    [16] = 2313, -- 中型护甲片
    [17] = 4265, -- 重型护甲片
    [18] = 8173, -- 厚重护甲片
    [30] = 4405, -- 粗制瞄准镜
    [32] = 4406, -- 普通瞄准镜
    [33] = 4407, -- 精确瞄准镜
    [34] = 6043, -- 铁质平衡锤
    [36] = 5421, -- 炽热魔符
    [37] = 6041, -- 钢质武器链
    [43] = 6042, -- 铁质盾刺
    [463] = 7967, -- 秘银盾刺
    [464] = 7969, -- 秘银马刺
    [663] = 10546, -- 致命瞄准镜
    [664] = 10548, -- 狙击瞄准镜
    [1483] = 11622, -- 次级冥思秘药
    [1503] = 11642, -- 次级体质秘药
    [1504] = 11643, -- 次级坚韧秘药
    [1505] = 11644, -- 次级适应秘药
    [1506] = 11645, -- 次级贪婪秘药
    [1507] = 11646, -- 次级贪婪秘药
    [1508] = 11647, -- 次级贪婪秘药
    [1509] = 11648, -- 次级贪婪秘药
    [1510] = 11649, -- 次级贪婪秘药
    [1704] = 12645, -- 瑟银盾刺
    [1843] = 15564, -- 毛皮护甲片
    [2483] = 18169, -- 火焰黎明衬肩
    [2484] = 18170, -- 冰霜黎明衬肩
    [2485] = 18171, -- 奥术黎明衬肩
    [2486] = 18172, -- 自然黎明衬肩
    [2487] = 18173, -- 暗影黎明衬肩
    [2488] = 18182, -- 多彩黎明衬肩
    [2503] = 18251, -- 熔火护甲片
    [2543] = 18329, -- 急速秘药
    [2544] = 18330, -- 专注秘药
    [2545] = 18331, -- 防护秘药
    [2583] = 19782, -- 力量的证明
    [2584] = 19783, -- 调和的徽记
    [2587] = 19786, -- 巫毒的警觉
    [2588] = 19787, -- 魔法的视域
    [2589] = 19788, -- 不祥的妖术
    [2590] = 19789, -- 预言的光环
    [2591] = 19790, -- 灵魂的安抚
    [2604] = 20078, -- 赞达拉宁静徽记
    [2605] = 20076, -- 赞达拉魔精徽记
    [2606] = 20077, -- 赞达拉力量徽记
    [2681] = 22635, -- 野性戒卫
    [2682] = 22636, -- 寒冰戒卫
    [2683] = 22638, -- 暗影戒卫
    [2714] = 23530, -- 魔钢盾刺
    [2715] = 23547, -- 天灾的活力
    [2716] = 23549, -- 天灾的坚韧
    [2717] = 23548, -- 天灾的威严
    [2721] = 23545, -- 天灾的力量
    [2722] = 23764, -- 精金瞄准镜
    [2723] = 23765, -- 氪金瞄准镜
    [2745] = 24275, -- 银色魔线
    [2746] = 24276, -- 金色魔线
    [2747] = 24273, -- 秘法魔线
    [2748] = 24274, -- 符文魔线
    [2792] = 25650, -- 结缔皮护甲片
    [2793] = 25651, -- 守备官的护甲片
    [2794] = 25652, -- 魔导师的护甲片
    [2841] = 34330, -- 厚重结缔皮护甲片
    [2977] = 28882, -- 护卫铭文
    [2978] = 28889, -- 强力护卫铭文
    [2979] = 28878, -- 信仰铭文
    [2980] = 28887, -- 强力信仰铭文
    [2981] = 28881, -- 戒律铭文
    [2982] = 28886, -- 强力戒律铭文
    [2983] = 28885, -- 复仇铭文
    [2984] = 29483, -- 暗影护甲片
    [2985] = 29485, -- 烈焰护甲片
    [2986] = 28888, -- 强力复仇铭文
    [2987] = 29486, -- 冰霜护甲片
    [2988] = 29487, -- 自然护甲片
    [2989] = 29488, -- 奥术护甲片
    [2990] = 28908, -- 骑士铭文
    [2991] = 28911, -- 强力骑士铭文
    [2992] = 28904, -- 神谕铭文
    [2993] = 28912, -- 强力神谕铭文
    [2994] = 28903, -- 宝珠铭文
    [2995] = 28909, -- 强力宝珠铭文
    [2996] = 28907, -- 利刃铭文
    [2997] = 28910, -- 强力利刃铭文
    [2998] = 29187, -- 耐久铭文
    [2999] = 29186, -- 防御者秘药
    [3001] = 29189, -- 恢复秘药
    [3002] = 29191, -- 强能秘药
    [3003] = 29192, -- 凶暴秘药
    [3004] = 29193, -- 角斗士秘药
    [3005] = 29194, -- 自然防护秘药
    [3006] = 29195, -- 奥术防护秘药
    [3007] = 29196, -- 火焰防护秘药
    [3008] = 29198, -- 冰霜防护秘药
    [3009] = 29199, -- 暗影防护秘药
    [3010] = 29533, -- 眼镜蛇皮腿甲片
    [3011] = 29534, -- 裂蹄腿甲片
    [3012] = 29535, -- 虚空毒蛇腿甲片
    [3013] = 29536, -- 虚空裂蹄腿甲片
    [3095] = 30845, -- 多彩防护秘药
    [3096] = 30846, -- 流放者秘药
    [3223] = 33185, -- 精金武器链
    [3260] = 34207, -- 手套强化护甲片
    [3269] = 34836, -- 真银渔线
    [3290] = 39300, -- 弹簧披风扩张器
    [3325] = 38371, -- 冰虫腿甲片
    [3326] = 38372, -- 蛛魔腿甲片
    [3329] = 38375, -- 北地护甲片
    [3330] = 38376, -- 厚北地护甲片
    [3331] = 38377, -- 龙鳞腿甲片
    [3332] = 38378, -- 巨龙鳞腿甲片
    [3599] = 40776, -- 单兵电磁脉冲发生器
    [3601] = 40800, -- 远距离侦测腰带夹
    [3603] = 41091, -- 手部火箭发射器
    [3605] = 41111, -- 高弹力衬垫
    [3606] = 41118, -- 硝化甘油推进器
    [3607] = 41146, -- 太阳瞄准镜
    [3608] = 41167, -- 觅心瞄准镜
    [3718] = 41601, -- 闪光魔线
    [3719] = 41602, -- 辉煌魔线
    [3720] = 41603, -- 碧蓝魔线
    [3721] = 41604, -- 天蓝魔线
    [3731] = 41976, -- 泰坦神铁武器链
    [3748] = 42500, -- 泰坦神铁盾刺
    [3754] = 19785, -- 猎鹰的召唤
    [3755] = 19784, -- 死亡的拥抱
    [3756] = 43097, -- 毛皮衬垫 - 攻击强度
    [3775] = 43302, -- 铁律铭文
    [3776] = 43303, -- 霜刃铭文
    [3777] = 43304, -- 王者铭文
    [3794] = 44068, -- 统御铭文
    [3797] = 44075, -- 统御秘药
    [3806] = 44129, -- 次级风暴铭文
    [3807] = 44130, -- 次级峭壁铭文
    [3808] = 44133, -- 强效利斧铭文
    [3809] = 44134, -- 强效峭壁铭文
    [3810] = 44135, -- 强效风暴铭文
    [3811] = 44136, -- 强效巅峰铭文
    [3812] = 44137, -- 冰霜之魂秘药
    [3813] = 44138, -- 防毒秘药
    [3814] = 44139, -- 消散之影秘药
    [3815] = 44140, -- 月食秘药
    [3816] = 44141, -- 烈焰之魂秘药
    [3817] = 44149, -- 折磨秘药
    [3818] = 44150, -- 坚定防御者秘药
    [3819] = 44152, -- 祝福治愈秘药
    [3820] = 44159, -- 燃烧谜团秘药
    [3822] = 38373, -- 霜皮腿甲片
    [3823] = 38374, -- 冰鳞腿甲片
    [3842] = 44701, -- 凶残角斗士秘药
    [3843] = 44739, -- 钻石折射瞄准镜
    [3849] = 44936, -- 泰坦神铁护板
    [3852] = 44957, -- 强效角斗士铭文
    [3853] = 44963, -- 土灵腿甲片
    [3875] = 44131, -- 次级利斧铭文
    [3876] = 44132 -- 次级巅峰铭文
}

-- GENERATE BY https://wago.tools/db2/SpellEffect
local EnchantSpellDB = {
    [1] = 2605, -- 打磨利刃
    [15] = 2831, -- 护甲 +8
    [16] = 2832, -- 护甲 +16
    [17] = 2833, -- 护甲 +24
    [18] = 10344, -- 护甲 +32
    [24] = 7443, -- 附魔胸甲 - 初级法力
    [30] = 3974, -- 粗制瞄准镜
    [32] = 3975, -- 普通瞄准镜
    [33] = 3976, -- 精确瞄准镜
    [34] = 7218, -- 武器平衡锤
    [36] = 6296, -- 附魔：火焰
    [37] = 7220, -- 武器链
    [43] = 7216, -- 铁质盾刺
    [44] = 7426, -- 附魔胸甲 - 初级吸收
    [63] = 13538, -- 附魔胸甲 - 次级吸收
    [65] = 7454, -- 附魔披风 - 初级抗性
    [242] = 7748, -- 附魔胸甲 - 次级生命
    [243] = 7766, -- 附魔护腕 - 初级精神
    [246] = 7776, -- 附魔胸甲 - 次级法力
    [248] = 7782, -- 附魔护腕 - 初级力量
    [249] = 7786, -- 附魔武器 - 初级屠兽
    [250] = 7788, -- 附魔武器 - 初级攻击
    [254] = 7857, -- 附魔胸甲 - 生命
    [256] = 7861, -- 附魔披风 - 次级火焰抗性
    [368] = 34004, -- 附魔披风 - 强效敏捷
    [369] = 34001, -- 附魔护腕 - 特效智力
    [463] = 9781, -- 秘银盾刺
    [464] = 9783, -- 秘银马刺
    [663] = 12459, -- 致命瞄准镜
    [664] = 12460, -- 狙击瞄准镜
    [684] = 33995, -- 附魔手套 - 特效力量
    [744] = 13421, -- 附魔披风 - 次级防护
    [783] = 7771, -- 附魔披风 - 初级防护
    [803] = 13898, -- 附魔武器 - 烈焰
    [804] = 13522, -- 附魔披风 - 次级暗影抵抗
    [805] = 13943, -- 附魔武器 - 强效攻击
    [823] = 13536, -- 附魔护腕 - 次级力量
    [843] = 13607, -- 附魔胸甲 - 法力
    [844] = 13612, -- 附魔手套 - 采矿
    [845] = 13617, -- 附魔手套 - 草药学
    [847] = 13626, -- 附魔胸甲 - 初级属性
    [850] = 13640, -- 附魔胸甲 - 强效生命
    [853] = 13653, -- 附魔武器 - 次级屠兽
    [854] = 13655, -- 附魔武器 - 次级元素杀手
    [857] = 13663, -- 附魔胸甲 - 强效法力
    [863] = 13689, -- 附魔盾牌 - 次级格挡
    [865] = 13698, -- 附魔手套 - 剥皮
    [866] = 13700, -- 附魔胸甲 - 次级状态
    [884] = 13746, -- 附魔披风 - 强效防御
    [903] = 13794, -- 附魔披风 - 抗性
    [905] = 13822, -- 附魔护腕 - 智力
    [906] = 13841, -- 附魔手套 - 高级采矿
    [908] = 13858, -- 附魔胸甲 - 超强生命
    [909] = 13868, -- 附魔手套 - 高级草药学
    [911] = 13890, -- 附魔靴子 - 初级速度
    [912] = 13915, -- 附魔武器 - 屠魔
    [913] = 13917, -- 附魔胸甲 - 超强法力
    [923] = 13931, -- 附魔护腕 - 偏斜
    [924] = 7428, -- 附魔护腕 - 初级偏斜
    [925] = 13646, -- 附魔护腕 - 次级偏斜
    [928] = 13941, -- 附魔胸甲 - 状态
    [930] = 13947, -- 附魔手套 - 骑乘
    [931] = 13948, -- 附魔手套 - 初级加速
    [1071] = 34009, -- 附魔盾牌 - 特效耐力
    [1075] = 44528, -- 附魔靴子 - 强效坚韧
    [1099] = 60663, -- 附魔披风 - 特效敏捷
    [1103] = 44633, -- 附魔武器 - 优异敏捷
    [1128] = 60653, -- 附魔盾牌 - 强效智力
    [1144] = 33990, -- 附魔胸甲 - 特效精神
    [1257] = 34005, -- 附魔披风 - 强效奥术抗性
    [1262] = 44596, -- 附魔披风 - 超强奥术抗性
    [1354] = 44556, -- 附魔披风 - 超强火焰抗性
    [1400] = 44494, -- 附魔披风 - 超强自然抗性
    [1441] = 34006, -- 附魔披风 - 强效暗影抗性
    [1446] = 44590, -- 附魔披风 - 超强暗影抗性
    [1483] = 15340, -- 次级奥术融合
    [1503] = 15389, -- 次级奥术融合
    [1504] = 15391, -- 次级奥术融合
    [1505] = 15394, -- 次级奥术融合
    [1506] = 15397, -- 次级奥术融合
    [1507] = 15400, -- 次级奥术融合
    [1508] = 15402, -- 次级奥术融合
    [1509] = 15404, -- 次级奥术融合
    [1510] = 15406, -- 次级奥术融合
    [1523] = 15427, -- 强效奥术融合
    [1524] = 15429, -- 强效奥术融合
    [1525] = 15439, -- 强效奥术融合
    [1526] = 15441, -- 强效奥术融合
    [1527] = 15444, -- 强效奥术融合
    [1528] = 15446, -- 强效奥术融合
    [1529] = 15449, -- 强效奥术融合
    [1530] = 15458, -- 强效奥术融合
    [1532] = 15463, -- 传说奥术融合
    [1543] = 15490, -- 传说奥术融合
    [1594] = 33996, -- 附魔手套 - 突袭
    [1597] = 60763, -- 附魔靴子 - 强效突袭
    [1600] = 60616, -- 附魔护腕 - 打击
    [1603] = 60668, -- 附魔手套 - 碾压
    [1606] = 60621, -- 附魔武器 - 强效潜能
    [1704] = 16623, -- 瑟银盾刺
    [1843] = 19057, -- 护甲 +40
    [1883] = 20008, -- 附魔护腕 - 强效智力
    [1884] = 20009, -- 附魔护腕 - 超强精神
    [1885] = 20010, -- 附魔护腕 - 超强力量
    [1886] = 20011, -- 附魔护腕 - 超强耐力
    [1889] = 20015, -- 附魔披风 - 超强防御
    [1890] = 20016, -- 附魔盾牌 - 活力
    [1892] = 20026, -- 附魔胸甲 - 特效生命
    [1893] = 20028, -- 附魔胸甲 - 特效法力
    [1894] = 20029, -- 附魔武器 - 冰寒
    [1896] = 20030, -- 附魔双手武器 - 超强冲击
    [1899] = 20033, -- 附魔武器 - 邪恶武器
    [1900] = 20034, -- 附魔武器 - 十字军
    [1903] = 20035, -- 附魔双手武器 - 特效精神
    [1904] = 20036, -- 附魔双手武器 - 特效智力
    [1952] = 44489, -- 附魔盾牌 - 防御
    [1953] = 47766, -- 附魔胸甲 - 强效防御
    [2322] = 33999, -- 附魔手套 - 特效治疗
    [2326] = 44635, -- 附魔护腕 - 强效法术强度
    [2332] = 60767, -- 附魔护腕 - 超强法术能量
    [2381] = 44509, -- 附魔胸甲 - 强效法力回复
    [2443] = 21931, -- 附魔武器 - 寒冬之力
    [2463] = 13657, -- 附魔披风 - 火焰抗性
    [2483] = 22593, -- 火焰黎明衬肩
    [2484] = 22594, -- 冰霜黎明衬肩
    [2485] = 22598, -- 奥术黎明衬肩
    [2486] = 22597, -- 自然黎明衬肩
    [2487] = 22596, -- 暗影黎明衬肩
    [2488] = 22599, -- 多彩黎明衬肩
    [2503] = 22725, -- 防御等级 +5
    [2504] = 22749, -- 附魔武器 - 法术能量
    [2505] = 22750, -- 附魔武器 - 治疗能量
    [2543] = 22840, -- 急速秘药
    [2544] = 22844, -- 专注秘药
    [2545] = 22846, -- 防护秘药
    [2563] = 23799, -- 附魔武器 - 力量
    [2565] = 23801, -- 附魔护腕 - 法力回复
    [2568] = 23804, -- 附魔武器 - 强效智力
    [2583] = 24149, -- 力量的证明
    [2584] = 24160, -- 调和的徽记
    [2587] = 24163, -- 巫毒的警觉
    [2588] = 24164, -- 魔法的视域
    [2589] = 24165, -- 不祥的妖术
    [2590] = 24167, -- 预言的光环
    [2591] = 24168, -- 灵魂的安抚
    [2603] = 13620, -- 附魔手套 - 钓鱼
    [2604] = 24420, -- 赞达拉宁静徽记
    [2605] = 24421, -- 赞达拉魔精徽记
    [2606] = 24422, -- 赞达拉力量徽记
    [2614] = 25073, -- 附魔手套 - 暗影能量
    [2615] = 25074, -- 附魔手套 - 冰霜能量
    [2616] = 25078, -- 附魔手套 - 火焰能量
    [2617] = 25079, -- 附魔手套 - 治疗能量
    [2622] = 25086, -- 附魔披风 - 躲闪
    [2646] = 27837, -- 附魔双手武器 - 敏捷
    [2647] = 27899, -- 附魔护腕 - 强壮
    [2653] = 27944, -- 附魔盾牌 - 坚韧盾牌
    [2654] = 27945, -- 附魔盾牌 - 智力
    [2655] = 27946, -- 附魔盾牌 - 盾牌格挡
    [2656] = 27948, -- 附魔长靴 - 活力
    [2657] = 27951, -- 附魔长靴 - 灵巧
    [2658] = 27954, -- 附魔长靴 - 稳固
    [2659] = 27957, -- 附魔胸甲 - 优异生命
    [2662] = 27961, -- 附魔披风 - 特效护甲
    [2664] = 27962, -- 附魔披风 - 特效抗性
    [2666] = 27968, -- 附魔武器 - 特效智力
    [2667] = 27971, -- 附魔双手武器 - 野蛮
    [2668] = 27972, -- 附魔武器 - 潜能
    [2669] = 27975, -- 附魔武器 - 特效法术能量
    [2670] = 27977, -- 附魔双手武器 - 特效敏捷
    [2671] = 27981, -- 附魔武器 - 阳炎
    [2672] = 27982, -- 附魔武器 - 魂霜
    [2673] = 27984, -- 附魔武器 - 猫鼬
    [2674] = 28003, -- 附魔武器 - 魔法激荡
    [2675] = 28004, -- 附魔武器 - 作战专家
    [2679] = 27913, -- 附魔护腕 - 优秀法力回复
    [2681] = 28161, -- 野性戒卫
    [2682] = 28163, -- 寒冰戒卫
    [2683] = 28165, -- 暗影戒卫
    [2714] = 29454, -- 魔钢盾刺
    [2715] = 29475, -- 天灾的活力
    [2716] = 29480, -- 天灾的坚韧
    [2717] = 29483, -- 天灾的威严
    [2721] = 29467, -- 天灾的力量
    [2722] = 30250, -- 精金瞄准镜
    [2723] = 30252, -- 氪金瞄准镜
    [2745] = 31369, -- 银色魔线
    [2746] = 31370, -- 金色魔线
    [2747] = 31371, -- 秘法魔线
    [2748] = 31372, -- 符文魔线
    [2792] = 32397, -- 结缔皮护甲片
    [2793] = 32398, -- 守备官的护甲片
    [2794] = 32399, -- 魔导师的护甲片
    [2841] = 44968, -- 厚重结缔皮护甲片
    [2928] = 27924, -- 附魔戒指 - 法术能量
    [2929] = 27920, -- 附魔戒指 - 打击
    [2930] = 27926, -- 附魔戒指 - 治疗能量
    [2931] = 27927, -- 附魔戒指 - 属性
    [2933] = 33992, -- 附魔胸甲 - 特效韧性
    [2934] = 33993, -- 附魔手套 - 冲击
    [2935] = 33994, -- 附魔手套 - 精确打击
    [2937] = 33997, -- 附魔手套 - 特效法术能量
    [2938] = 34003, -- 附魔披风 - 法术穿透
    [2939] = 34007, -- 附魔长靴 - 豹之迅捷
    [2940] = 34008, -- 附魔长靴 - 野猪之速
    [2977] = 35355, -- 护卫铭文
    [2978] = 35402, -- 强力护卫铭文
    [2979] = 35403, -- 信仰铭文
    [2980] = 35404, -- 强力信仰铭文
    [2981] = 35405, -- 戒律铭文
    [2982] = 35406, -- 强力戒律铭文
    [2983] = 35407, -- 复仇铭文
    [2984] = 35415, -- 暗影护甲片
    [2985] = 35416, -- 烈焰护甲片
    [2986] = 35417, -- 强力复仇铭文
    [2987] = 35418, -- 冰霜护甲片
    [2988] = 35419, -- 自然护甲片
    [2989] = 35420, -- 奥术护甲片
    [2990] = 35432, -- 骑士铭文
    [2991] = 35433, -- 强力骑士铭文
    [2992] = 35434, -- 神谕铭文
    [2993] = 35435, -- 强力神谕铭文
    [2994] = 35436, -- 宝珠铭文
    [2995] = 35437, -- 强力宝珠铭文
    [2996] = 35438, -- 利刃铭文
    [2997] = 35439, -- 强力利刃铭文
    [2998] = 35441, -- 耐久铭文
    [2999] = 35443, -- 防御者秘药
    [3001] = 35445, -- 恢复秘药
    [3002] = 35447, -- 强能秘药
    [3003] = 35452, -- 凶暴秘药
    [3004] = 35453, -- 角斗士秘药
    [3005] = 35454, -- 自然防护秘药
    [3006] = 35455, -- 奥术防护秘药
    [3007] = 35456, -- 火焰防护秘药
    [3008] = 35457, -- 冰霜防护秘药
    [3009] = 35458, -- 暗影防护秘药
    [3010] = 35488, -- 眼镜蛇皮腿甲片
    [3011] = 35489, -- 裂蹄腿甲片
    [3012] = 35490, -- 虚空毒蛇腿甲片
    [3013] = 35495, -- 虚空裂蹄腿甲片
    [3095] = 37889, -- 多彩防护秘药
    [3096] = 37891, -- 流放者秘药
    [3150] = 33991, -- 附魔胸甲 - 优秀法力回复
    [3223] = 42687, -- 精金武器链
    [3225] = 42974, -- 附魔武器 - 斩杀
    [3230] = 44483, -- 附魔披风 - 超强冰霜抗性
    [3232] = 47901, -- 附魔靴子 - 海象人的活力
    [3233] = 27958, -- 附魔胸甲 - 优异法力
    [3234] = 44488, -- 附魔手套 - 精确
    [3236] = 44492, -- 附魔胸甲 - 极效生命
    [3238] = 44506, -- 附魔手套 - 采集
    [3239] = 44524, -- 附魔武器 - 破冰
    [3241] = 44576, -- 附魔武器 - 生命护卫
    [3243] = 44582, -- 附魔披风 - 法术穿刺
    [3244] = 44584, -- 附魔靴子 - 强效活力
    [3245] = 44588, -- 附魔胸甲 - 优异韧性
    [3246] = 44592, -- 附魔手套 - 优异法术强度
    [3247] = 44595, -- 附魔双手武器 - 天灾斩除
    [3249] = 44612, -- 附魔手套 - 强效冲击
    [3251] = 44621, -- 附魔武器 - 巨人杀手
    [3252] = 44623, -- 附魔胸甲 - 超级属性
    [3253] = 44625, -- 附魔手套 - 士兵
    [3256] = 44631, -- 附魔披风 - 暗影护甲
    [3260] = 44769, -- 手套强固
    [3269] = 45697, -- 真银渔线
    [3273] = 46578, -- 附魔武器 - 死亡霜冻
    [3290] = 52639, -- 弹簧披风扩张器
    [3294] = 47672, -- 附魔披风 - 极效护甲
    [3296] = 47899, -- 附魔披风 - 智慧
    [3297] = 47900, -- 附魔胸甲 - 超级生命
    [3319] = 50465, -- 插槽单手武器
    [3325] = 50901, -- 冰虫腿甲片
    [3326] = 50902, -- 蛛魔腿甲片
    [3329] = 50906, -- 北地护甲片
    [3330] = 50909, -- 厚北地护甲片
    [3331] = 50911, -- 龙鳞腿甲片
    [3332] = 50913, -- 巨龙鳞腿甲片
    [3365] = 53323, -- 裂刃符文
    [3366] = 53331, -- 巫妖斩除符文
    [3367] = 53342, -- 法术碎裂符文
    [3368] = 53344, -- 堕落十字军符文
    [3369] = 53341, -- 灰烬冰河符文
    [3370] = 53343, -- 冰锋符文
    [3594] = 54446, -- 破刃符文
    [3595] = 54447, -- 法术阻断符文
    [3599] = 54736, -- 单兵电磁脉冲发生器
    [3601] = 54793, -- 弹带
    [3603] = 54998, -- 手部火箭发射器
    [3604] = 54999, -- 超级加速器
    [3605] = 55002, -- 高弹力衬垫
    [3606] = 55016, -- 硝化甘油推进器
    [3607] = 55076, -- 太阳瞄准镜
    [3608] = 55135, -- 觅心瞄准镜
    [3718] = 55630, -- 闪光魔线
    [3719] = 55631, -- 辉煌魔线
    [3720] = 55632, -- 碧蓝魔线
    [3721] = 55634, -- 天蓝魔线
    [3722] = 55642, -- 亮纹刺绣
    [3728] = 55769, -- 黑光刺绣
    [3730] = 55777, -- 剑刃刺绣
    [3731] = 55836, -- 泰坦神铁武器链
    [3748] = 56353, -- 泰坦神铁盾刺
    [3754] = 24162, -- 猎鹰的召唤
    [3755] = 24161, -- 死亡之拥
    [3756] = 57683, -- 毛皮衬垫 - 攻击强度
    [3757] = 57690, -- 毛皮衬垫 - 耐力
    [3758] = 57691, -- 毛皮衬垫 - 法术强度
    [3759] = 57692, -- 毛皮衬垫 - 火焰抗性
    [3760] = 57694, -- 毛皮衬垫 - 冰霜抗性
    [3761] = 57696, -- 毛皮衬垫 - 暗影抗性
    [3762] = 57699, -- 毛皮衬垫 - 自然抗性
    [3763] = 57701, -- 毛皮衬垫 - 奥术抗性
    [3775] = 58126, -- 铁律铭文
    [3776] = 58128, -- 霜刃铭文
    [3777] = 58129, -- 王者铭文
    [3788] = 59619, -- 附魔武器 - 精确
    [3789] = 59621, -- 附魔武器 - 狂暴
    [3790] = 59625, -- 附魔武器 - 黑魔法
    [3791] = 59636, -- 附魔戒指 - 耐力
    [3793] = 59771, -- 凯旋铭文
    [3794] = 59773, -- 统御铭文
    [3795] = 59777, -- 凯旋秘药
    [3796] = 59778, -- 统御秘药
    [3797] = 59784, -- 统御秘药
    [3806] = 59927, -- 风暴铭文
    [3807] = 59928, -- 峭壁铭文
    [3808] = 59934, -- 强效利斧铭文
    [3809] = 59936, -- 强效峭壁铭文
    [3810] = 59937, -- 强效风暴铭文
    [3811] = 59941, -- 强效巅峰铭文
    [3812] = 59944, -- 结霜之魂秘药
    [3813] = 59945, -- 剧毒防护秘药
    [3814] = 59946, -- 流离之影秘药
    [3815] = 59947, -- 蚀月秘药
    [3816] = 59948, -- 烈焰之魂秘药
    [3817] = 59954, -- 折磨秘药
    [3818] = 59955, -- 坚定守护者秘药
    [3819] = 59960, -- 祝福治愈秘药
    [3820] = 59970, -- 燃烧之谜秘药
    [3822] = 60581, -- 霜皮腿甲片
    [3823] = 60582, -- 冰鳞腿甲片
    [3824] = 60606, -- 附魔靴子 - 突袭
    [3825] = 60609, -- 附魔披风 - 速度
    [3826] = 60623, -- 附魔靴子 - 履冰
    [3827] = 60691, -- 附魔双手武器 - 杀戮
    [3828] = 44630, -- 附魔双手武器 - 强效野蛮
    [3829] = 44513, -- 附魔手套 - 强效突袭
    [3830] = 44629, -- 附魔武器 - 优异法术能量
    [3831] = 47898, -- 附魔披风 - 强效速度
    [3832] = 60692, -- 附魔胸甲 - 强力属性
    [3833] = 60707, -- 附魔武器 - 超强潜能
    [3834] = 60714, -- 附魔武器 - 极效法术能量
    [3835] = 61117, -- 大师的利斧铭文
    [3836] = 61118, -- 大师的峭壁铭文
    [3837] = 61119, -- 大师的巅峰铭文
    [3838] = 61120, -- 大师的风暴铭文
    [3839] = 44645, -- 附魔戒指 - 突袭
    [3840] = 44636, -- 附魔戒指 - 强效法术能量
    [3842] = 61271, -- 凶残角斗士秘药
    [3843] = 61468, -- 钻石折射瞄准镜
    [3844] = 44510, -- 附魔武器 - 优异精神
    [3845] = 44575, -- 附魔护腕 - 强效突袭
    [3846] = 34010, -- 附魔武器 - 特效治疗
    [3847] = 62158, -- 石肤石像鬼符文
    [3849] = 62201, -- 泰坦神铁护板
    [3850] = 62256, -- 附魔护腕 - 特效耐力
    [3851] = 62257, -- 附魔武器 - 泰坦护卫
    [3852] = 62384, -- 强效角斗士铭文
    [3853] = 62447, -- 土灵腿甲片
    [3854] = 62948, -- 附魔法杖 - 强效法术能量
    [3855] = 62959, -- 附魔法杖 - 法术能量
    [3858] = 63746, -- 附魔靴子 - 次级精确
    [3859] = 63765, -- 弹力蛛丝
    [3860] = 63770, -- 装甲护网
    [3869] = 64441, -- 附魔武器 - 利刃防护
    [3870] = 64579, -- 附魔武器 - 吸血
    [3872] = 56039, -- 神圣魔线
    [3873] = 56034, -- 大师的魔线
    [3875] = 59929, -- 利斧铭文
    [3876] = 59932, -- 巅峰铭文
    [3878] = 67839, -- 思维放大圆盘
    [3883] = 70164, -- 蛛魔甲壳符文

    -- [241] = 7745, -- 附魔双手武器 - 初级冲击
    [241] = 13503, -- 附魔武器 - 次级攻击
    [910] = 25083, -- 附魔披风 - 潜行
    -- [910] = 359640, -- 附魔披风 - 潜行
    [926] = 13933, -- 附魔盾牌 - 冰霜抗性
    -- [926] = 359895, -- 附魔盾牌 - 冰霜抗性
    -- [943] = 13529, -- 附魔双手武器 - 次级冲击
    [943] = 13693, -- 附魔武器 - 攻击
    -- [963] = 13937, -- 附魔双手武器 - 强效冲击
    [963] = 27967, -- 附魔武器 - 特效打击
    [1119] = 44555, -- 附魔护腕 - 优异智力
    -- [1119] = 47715, -- 附魔模板
    [1593] = 34002, -- 附魔护腕 - 突袭
    -- [1593] = 359639, -- 附魔护腕 - 突袭
    -- [1897] = 13695, -- 附魔双手武器 - 冲击
    [1897] = 20031, -- 附魔武器 - 超强打击
    [1898] = 20032, -- 附魔武器 - 生命吸取
    -- [1898] = 27964, -- 附魔武器 - 特效精神
    [2523] = 22779, -- 比兹尼克247x128精确瞄准镜
    -- [2523] = 30255, -- 稳定恒金瞄准镜
    [2567] = 23803, -- 附魔武器 - 强效精神
    -- [2567] = 359642, -- 附魔武器 - 强效精神
    [2613] = 25072, -- 附魔手套 - 威胁
    -- [2613] = 359858, -- 附魔手套 - 威胁
    [2619] = 25081, -- 附魔披风 - 强效火焰抗性
    -- [2619] = 359950, -- 附魔披风 - 强效火焰抗性
    [2620] = 25082, -- 附魔披风 - 强效自然抗性
    -- [2620] = 359949, -- 附魔披风 - 强效自然抗性
    [2621] = 25084, -- 附魔披风 - 狡诈
    -- [2621] = 359847, -- 附魔披风 - 狡诈
    -- [2650] = 23802, -- 附魔护腕 - 治疗能力
    -- [2650] = 27911, -- 附魔护腕 - 超强治疗
    [2650] = 27917, -- 附魔护腕 - 法术能量
    -- [2724] = 30258, -- 稳定恒金瞄准镜
    [2724] = 30260, -- 稳定恒金瞄准镜
    [3229] = 44383, -- 附魔盾牌 - 韧性
    -- [3229] = 359685, -- 附魔盾牌 - 抗性
    -- [3289] = 48555, -- 碎天者之鞭
    -- [3289] = 48557, -- 马鞭
    -- [3289] = 47103, -- 马鞭
    -- [3315] = 48401, -- 棍子上的胡萝卜
    -- [3315] = 48556, -- 棍子上的胡萝卜
    -- [3327] = 50903, -- 冰虫腿甲强化片
    [3327] = 60583, -- 冰虫腿甲强化片
    -- [3328] = 50904, -- 蛛魔腿甲强化片
    [3328] = 60584, -- 蛛魔腿甲强化片
}

local EnchantMultiSpellDB = {
    [41] = {
        [5] = 7420, -- 附魔胸甲 - 初级生命
        [9] = 7418 -- 附魔护腕 - 初级生命
    },
    [66] = {
        [8] = 7863, -- 附魔靴子 - 初级耐力
        [9] = 7457, -- 附魔护腕 - 初级耐力
        [17] = 13378 -- 附魔盾牌 - 初级耐力
    },
    [247] = {
        [8] = 7867, -- 附魔靴子 - 初级敏捷
        [9] = 7779, -- 附魔护腕 - 初级敏捷
        [15] = 13419 -- 附魔披风 - 初级敏捷
    },
    [255] = {
        [9] = 7859, -- 附魔护腕 - 次级精神
        [16] = 13380, -- 附魔双手武器 - 次级精神
        [17] = 13485, -- 附魔盾牌 - 次级精神
        [8] = 13687 -- 附魔靴子 - 次级精神
    },
    [723] = {
        [16] = 7793, -- 附魔双手武器 - 次级智力
        [9] = 13622 -- 附魔护腕 - 次级智力
    },
    [724] = {
        [17] = 13631, -- 附魔盾牌 - 次级耐力
        [9] = 13501, -- 附魔护腕 - 次级耐力
        [8] = 13644 -- 附魔靴子 - 次级耐力
    },
    [846] = {
        [16] = 24302, -- 恒金渔线
        [10] = 71692 -- 附魔手套 - 垂钓
    },
    [848] = {
        [15] = 13635, -- 附魔披风 - 防御
        [17] = 13464 -- 附魔盾牌 - 次级防护
    },
    [849] = {
        [8] = 13637, -- 附魔靴子 - 次级敏捷
        [15] = 13882 -- 附魔披风 - 次级敏捷
    },
    [851] = {
        [9] = 13642, -- 附魔护腕 - 精神
        [17] = 13659, -- 附魔盾牌 - 精神
        [8] = 20024 -- 附魔靴子 - 精神
    },
    [852] = {
        [9] = 13648, -- 附魔护腕 - 耐力
        [17] = 13817, -- 附魔盾牌 - 耐力
        [8] = 13836 -- 附魔靴子 - 耐力
    },
    [856] = {
        [10] = 13887, -- 附魔手套 - 力量
        [9] = 13661 -- 附魔护腕 - 力量
    },
    [904] = {
        [8] = 13935, -- 附魔靴子 - 敏捷
        [10] = 13815 -- 附魔手套 - 敏捷
    },
    [907] = {
        [17] = 13905, -- 附魔盾牌 - 强效精神
        [9] = 13846 -- 附魔护腕 - 强效精神
    },
    [927] = {
        [9] = 13939, -- 附魔护腕 - 强效力量
        [10] = 20013 -- 附魔手套 - 强效力量
    },
    [929] = {
        [9] = 13945, -- 附魔护腕 - 强效耐力
        [17] = 20017, -- 附魔盾牌 - 强效耐力
        [8] = 20020 -- 附魔靴子 - 强效耐力
    },
    [983] = {
        [15] = 44500, -- 附魔披风 - 超强敏捷
        [8] = 44589 -- 附魔靴子 - 超强敏捷
    },
    [1147] = {
        [9] = 44593, -- 附魔护腕 - 特效精神
        [8] = 44508 -- 附魔靴子 - 强效精神
    },
    [1887] = {
        [10] = 20012, -- 附魔手套 - 强效敏捷
        [8] = 20023 -- 附魔靴子 - 强效敏捷
    },
    [1888] = {
        [15] = 20014, -- 附魔披风 - 强效抗性
        [17] = 27947 -- 附魔盾牌 - 抗性
    },
    [1891] = {
        [5] = 20025, -- 附魔胸甲 - 强效属性
        [9] = 27905 -- 附魔护腕 - 属性
    },
    [1951] = {
        [5] = 46594, -- 附魔胸甲 - 防御
        [15] = 44591 -- 附魔披风 - 泰坦之纹
    },
    [2564] = {
        [16] = 23800, -- 附魔武器 - 敏捷
        [17] = 23800, -- 附魔武器 - 敏捷
        [10] = 25080, -- 附魔手套 - 超强敏捷
        -- [10] = 359641 -- 附魔手套 - 超强敏捷
    },
    [2648] = {
        [9] = 27906, -- 附魔护腕 - 特效防御
        [15] = 47051 -- 附魔披风 - 钢纹
    },
    [2649] = {
        [9] = 27914, -- 附魔护腕 - 坚韧
        [8] = 27950 -- 附魔长靴 - 坚韧
    },
    [2661] = {
        [5] = 27960, -- 附魔胸甲 - 优异属性
        [9] = 44616 -- 附魔护腕 - 强效属性
    },
    [3222] = {
        [16] = 42620, -- 附魔武器 - 强效敏捷
        [17] = 42620, -- 附魔武器 - 强效敏捷
        [10] = 44529 -- 附魔手套 - 特效敏捷
    },
    [3231] = {
        [10] = 44484, -- 附魔手套 - 精准
        [9] = 44598 -- 附魔护腕 - 精准
    }
}

function lib:GetEnchantInfo(link, slotID)
    local enchantID = tonumber(string.match(link, "item:%d+:(%d+):"))
    if not enchantID then
        return nil, nil, nil
    end
    local enchantItemID = EnchantItemDB[enchantID]
    local enchantSpellID = EnchantMultiSpellDB[enchantID] and EnchantMultiSpellDB[enchantID][slotID] or EnchantSpellDB[enchantID]
    return enchantItemID, enchantSpellID, enchantID
end

if not (C_Engraving and C_Engraving.IsEngravingEnabled()) then return end

lib.EnchantRuneDB = {}

do
    local CURRENT_MASK
    local CURRENT_ID
    local LOCALE_INDEX = {}
    local LOCALE = GetLocale()

    local function DefineLocalIndexs(val)
        for i, locale in ipairs(strsplittable('/', val)) do
            LOCALE_INDEX[locale] = i
        end
    end

    local function CreateRune(classMask, id)
        CURRENT_MASK = classMask
        CURRENT_ID = id
        lib.EnchantRuneDB[classMask] = lib.EnchantRuneDB[classMask] or {}
    end

    local function SetRuneName(names)
        local index = LOCALE_INDEX[LOCALE] or LOCALE_INDEX.enUS
        local name = strsplittable('/', names)[index]
        lib.EnchantRuneDB[CURRENT_MASK][name] = CURRENT_ID
    end

    -- GENERATE BY script
    local L, R, N = DefineLocalIndexs, CreateRune, SetRuneName
    L[[enUS/deDE/esES/esMX/frFR/itIT/koKR/ptBR/ruRU/zhCN/zhTW]]R(8,399969)N[[Deadly Brew/Tödliche Mischung/Brebaje letal/Brebaje letal/Breuvage mortel/Deadly Brew/맹독 조합/Mistura Mortífera/Смертельное варево/致命阴谋/致命毒釀]]R(8,400033)N[[Between the Eyes/Zwischen die Augen/Entre ceja y ceja/Entre los ojos/Entre les deux yeux/Between the Eyes/미간 적중/No Meio da Testa/Промеж глаз/正中眉心/正中眉心]]R(8,400039)N[[Just a Flesh Wound/Nur eine Fleischwunde/Una simple herida superficial/Heridas superficiales/Juste une égratignure/Just a Flesh Wound/얕은 상처일 뿐/Só Um Arranhão/Просто царапина/只是皮肉伤/不過是點皮肉傷]]R(8,400040)N[[Rolling with the Punches/Schläge abschwächen/Improvisación defensiva/Bravura ante los golpes/Encaisser les coups/Rolling with the Punches/충격 완화/Adaptar à Situação/Держать удар/闪转腾挪/重拳連發]]R(8,398197)N[[Quick Draw/Pistolenheld/Desenvainado rápido/Desenfunde rápido/Tireur rapide/Quick Draw/빠른 사격/Saque Rápido/Быстрая реакция/速射/拔槍快手]]R(8,399962)N[[Mutilate/Verstümmeln/Mutilar/Mutilar/Estropier/Mutilate/절단/Mutilar/Расправа/毁伤/截肢]]R(8,400038)N[[Blade Dance/Klingentanz/Danza de hojas/Danza de hojas/Danse des lames/Blade Dance/칼춤/Dança de Lâminas/Танец клинков/刃舞/劍刃之舞]]R(8,400037)N[[Shadowstep/Schattenschritt/Paso de las Sombras/Paso de las Sombras/Pas de l’ombre/Shadowstep/그림자 밟기/Passo Furtivo/Шаг сквозь тень/暗影步/暗影閃現]]R(8,399968)N[[Envenom/Vergiften/Envenenar/Envenenar/Envenimer/Envenom/독살/Envenenar/Отравление/毒伤/毒化]]R(8,400037)N[[Shadowstep/Schattenschritt/Paso de las Sombras/Paso de las Sombras/Pas de l’ombre/Shadowstep/그림자 밟기/Passo Furtivo/Шаг сквозь тень/暗影步/暗影閃現]]R(8,400031)N[[Shadowstrike/Schattenschlag/Tenebrosa/Golpesombra/Frappe-ténèbres/Shadowstrike/그림자 일격/Golpe Sombrio/Теневой удар/暗影打击/暗影打擊]]R(8,400032)N[[Shuriken Toss/Shurikenwurf/Lanzamiento de shuriken/Lanzamiento de shuriken/Lancer de shuriken/Shuriken Toss/표창 투척/Lançar Shuriken/Бросок сюрикэна/飞镖投掷/手裏劍]]R(128,401744)N[[Living Flame/Lebende Flamme/Llama viviente/Llama viva/Flamme vivante/Living Flame/살아있는 불꽃/Chama Viva/Живой жар/活体烈焰/活化烈焰]]R(128,401743)N[[Regeneration/Regeneration/Regeneración/Regeneración/Régénération/Regeneration/재생/Regeneração/Регенерация/再生/再生]]R(128,401741)N[[Fingers of Frost/Eisige Finger/Dedos de Escarcha/Dedos de Escarcha/Doigts de givre/Fingers of Frost/서리의 손가락/Dedos Glaciais/Ледяные пальцы/寒冰指/冰霜之指]]R(128,401736)N[[Missile Barrage/Geschosssalve/Tromba de misiles/Tromba de misiles/Barrage de projectiles/Missile Barrage/화살 탄막/Salva de Mísseis/Заградительные стрелы/飞弹连射/飛彈彈幕]]R(128,401735)N[[Frostfire Bolt/Frostfeuerblitz/Descarga de Pirofrío/Descarga de pirofrío/Éclair de givrefeu/Frostfire Bolt/얼음불꽃 화살/Seta de Fogofrio/Стрела ледяного огня/霜火之箭/霜火箭]]R(128,401734)N[[Rewind Time/Zeit zurückdrehen/Retroceder en el tiempo/Retroceder en el tiempo/Remonter le temps/Rewind Time/시간 되돌리기/Retroceder Tempo/Перемотка времени/时光倒转/時光倒流]]R(128,401732)N[[Ice Lance/Eislanze/Lanza de hielo/Lanza de hielo/Javelot de glace/Ice Lance/얼음창/Lança de Gelo/Ледяное копье/冰枪术/冰霜長矛]]R(128,415460)N[[Burnout/Feuerfontäne/Consunción/Incendio/Ardeur épuisante/Burnout/완전 연소/Combustão/Выгорание/燃尽/燃盡]]R(128,401729)N[[Arcane Blast/Arkanschlag/Explosión Arcana/Explosión arcana/Déflagration des arcanes/Arcane Blast/비전 작렬/Impacto Arcano/Чародейская вспышка/奥术冲击/秘法衝擊]]R(128,401726)N[[Advanced Warding/Fortgeschrittener Schutzzauber/Protección avanzada/Resguardo avanzado/Protection avancée/Advanced Warding/고급 수호물/Proteção Avançada/Улучшенные обереги/进阶结界/進階結界]]R(128,401725)N[[Brain Freeze/Hirnfrost/Congelación cerebral/Congelación cerebral/Gel mental/Brain Freeze/두뇌 빙결/Congelamento Cerebral/Заморозка мозгов/冰冷智慧/腦部凍結]]R(128,401724)N[[Hot Streak/Kampfeshitze/Buena racha/Una buena racha/Bonne série/Hot Streak/몰아치는 열기/Embalo de Fogo/Полоса везения/炽热连击/熱門連勝]]R(16,402832)N[[Prayer of Mending/Gebet der Besserung/Rezo de alivio/Rezo de alivio/Prière de guérison/Prayer of Mending/회복의 기원/Prece da Recomposição/Молитва восстановления/愈合祷言/癒合禱言]]R(16,402833)N[[Shadow Word: Death/Schattenwort: Tod/Palabra de las Sombras: muerte/Palabra de las Sombras: muerte/Mot de l’ombre : Mort/Shadow Word: Death/어둠의 권능: 죽음/Palavra Sombria: Morte/Слово Тьмы: Смерть/暗言术：灭/暗言術：死]]R(16,402836)N[[Homunculi/Homunculi/Homúnculos/Homúnculos/Homoncules/Homunculi/호문쿨루스/Homúnculos/Гомункулы/裂魂魔/魔胎]]R(16,402838)N[[Shared Pain/Geteilter Schmerz/Dolor compartido/Dolor compartido/Souffrance partagée/Shared Pain/나누는 고통/Dor Compartilhada/Общая боль/分担痛苦/共享苦痛]]R(16,402839)N[[Pain Suppression/Schmerzunterdrückung/Supresión de dolor/Supresión de dolor/Suppression de la douleur/Pain Suppression/고통 억제/Supressão de Dor/Подавление боли/痛苦压制/痛苦鎮壓]]R(16,402842)N[[Circle of Healing/Kreis der Heilung/Círculo de sanación/Círculo de sanación/Cercle de soins/Circle of Healing/치유의 마법진/Círculo de Cura/Круг исцеления/治疗之环/治療之環]]R(16,402843)N[[Shadowfiend/Schattengeist/Maligno de las Sombras/Maligno de las Sombras/Ombrefiel/Shadowfiend/어둠의 마귀/Demônio das Sombras/Исчадие Тьмы/暗影魔/暗影惡魔]]R(16,402844)N[[Penance/Sühne/Penitencia/Penitencia/Pénitence/Penance/회개/Penitência/Исповедь/苦修/懺悟]]R(16,402846)N[[Eye of the Void/Auge der Leere/Ojo del Vacío/Ojo del Vacío/Œil du Vide/Eye of the Void/공허의 눈/Olho do Caos/Око Бездны/虚空之眼/虛無之眼]]R(1,403434)N[[Victory Rush/Siegesrausch/Ataque de la victoria/Ataque de la victoria/Ivresse de la victoire/Victory Rush/승리의 돌진/Ímpeto da Vitória/Победный раж/乘胜追击/勝利衝擊]]R(1,403349)N[[Endless Rage/Endlose Wut/Ira interminable/Ira infinita/Rage infinie/Endless Rage/끝없는 분노/Raiva Infinita/Бесконечная ярость/无尽怒气/無盡狂怒]]R(1,403344)N[[Flagellation/Geißelung/Flagelación/Flagelación/Flagellation/Flagellation/채찍질/Flagelação/Флагелляция/狂热鞭笞/鞭策]]R(1,403355)N[[Devastate/Verwüsten/Devastar/Devastar/Dévaster/Devastate/압도/Devastar/Сокрушение/毁灭打击/挫敗]]R(1,403356)N[[Furious Thunder/Wütender Donner/Trueno de furia/Rayo furioso/Tonnerre furieux/Furious Thunder/격노의 천둥/Trovão Furioso/Неистовый гром/狂怒雷霆/盛怒轟雷]]R(1,403352)N[[Blood Frenzy/Blutraserei/Frenesí sangriento/Frenesí sangriento/Frénésie sanglante/Blood Frenzy/피의 광란/Frenesi de Sangue/Кровавое бешенство/血之狂暴/血之狂暴]]R(1,403435)N[[Commanding Shout/Befehlsruf/Grito de orden/Grito de orden/Cri de commandement/Commanding Shout/지휘의 외침/Brado de Comando/Командирский крик/命令怒吼/命令之吼]]R(1,403359)N[[Enraged Regeneration/Wütende Regeneration/Regeneración iracunda/Regeneración iracunda/Régénération enragée/Enraged Regeneration/분노의 재생력/Regeneração Enfurecida/Безудержное восстановление/狂怒回复/狂怒恢復]]R(1,403437)N[[Intervene/Einschreiten/Intervenir/Intervenir/Intervention/Intervene/가로막기/Comprar Briga/Вмешательство/援护/阻擾]]R(256,403873)N[[Metamorphosis/Metamorphose/Metamorfosis/Metamorfosis/Métamorphose/Metamorphosis/탈태/Metamorfose/Метаморфоза/恶魔变形/惡魔化身]]R(256,403872)N[[Lake of Fire/See des Feuers/Lago de Fuego/Lago de fuego/Lac de feu/Lake of Fire/불꽃의 호수/Lago de Fogo/Огненное озеро/火焰之湖/火焰之湖]]R(256,403871)N[[Shadow Bolt Volley/Schattenblitzsalve/Salva de descarga de las Sombras/Salva de descarga de las Sombras/Salve de traits de l’ombre/Shadow Bolt Volley/연발 어둠의 화살/Salva de Setas Sombrias/Залп стрел Тьмы/暗影箭雨/暗影箭雨]]R(256,403868)N[[Master Channeler/Meisterkanalisierer/Maestro canalizador/Canalización maestra/Maîtrise de la canalisation/Master Channeler/역술의 대가/Mestre Canalizador/Мастер-чаротворец/引导大师/引導大師]]R(256,403860)N[[Chaos Bolt/Chaosblitz/Descarga de caos/Descarga de caos/Trait du chaos/Chaos Bolt/혼돈의 화살/Seta do Caos/Стрела Хаоса/混乱之箭/混沌箭]]R(256,403863)N[[Soul Siphon/Seelenentzug/Succión de alma/Succión de alma/Siphon d’âme/Soul Siphon/영혼 착취/Sifão da Alma/Вытягивание души/灵魂虹吸/靈魂虹吸]]R(256,403858)N[[Haunt/Heimsuchung/Poseer/Poseer/Hanter/Haunt/유령 출몰/Assombrar/Блуждающий дух/鬼影缠身/蝕魂術]]R(1,415745)N[[Focused Rage/Fokussierte Wut/Ira enfocada/Ira concentrada/Rage concentrée/Focused Rage/분노 집중/Raiva Concentrada/Сосредоточенная ярость/怒火聚焦/集中怒氣]]R(2,409906)N[[Beacon of Light/Flamme des Glaubens/Señal de la Luz/Señal de la Luz/Guide de lumière/Beacon of Light/빛의 봉화/Foco de Luz/Частица Света/圣光道标/聖光信標]]R(2,409914)N[[Crusader Strike/Kreuzfahrerstoß/Golpe de cruzado/Golpe de cruzado/Frappe du croisé/Crusader Strike/성전사의 일격/Golpe do Cruzado/Удар воина Света/十字军打击/十字軍聖擊]]R(2,409935)N[[Divine Sacrifice/Heilige Opferung/Sacrificio divino/Sacrificio divino/Sacrifice divin/Divine Sacrifice/성스러운 희생/Sacrifício Divino/Священная жертва/神圣牺牲/神性犧牲]]R(2,409936)N[[Inspiration Exemplar/Inspirationsvorbild/Inspiración ejemplar/Inspiración ejemplar/Source d’inspiration/Inspiration Exemplar/영감의 모범/Modelo de Inspiração/Пример для подражания/激励典范/鼓舞楷模]]R(2,409933)N[[Avenger's Shield/Schild des Rächers/Escudo de vengador/Escudo de vengador/Bouclier du vengeur/Avenger's Shield/응징의 방패/Escudo do Vingador/Щит мстителя/复仇者之盾/復仇之盾]]R(2,409925)N[[Seal of Martyrdom/Siegel des Märtyrertums/Sello de martirio/Sello de martirio/Sceau du martyr/Seal of Martyrdom/헌신의 문장/Selo do Martírio/Печать мученичества/殉道圣印/殉難聖印]]R(2,409922)N[[Hammer of the Righteous/Hammer der Rechtschaffenen/Martillo del honrado/Martillo del honrado/Marteau du vertueux/Hammer of the Righteous/정의의 망치/Martelo do Íntegro/Молот праведника/正义之锤/公正之錘]]R(2,409924)N[[Divine Storm/Göttlicher Sturm/Tormenta divina/Tormenta divina/Tempête divine/Divine Storm/천상의 폭풍/Tempestade Divina/Божественная буря/神圣风暴/神性風暴]]R(2,409911)N[[Hand of Reckoning/Hand der Abrechnung/Mano de expiación/Mano de expiación/Main de rétribution/Hand of Reckoning/심판의 손길/Mão da Desforra/Длань возмездия/清算之手/清算聖禦]]R(1024,409830)N[[Nourish/Pflege/Nutrir/Nutrir/Nourrir/Nourish/육성/Nutrir/Покровительство природы/滋养/滋補術]]R(1024,409828)N[[Mangle/Zerfleischen/Destrozar/Destrozar/Mutilation/Mangle/짓이기기/Destroçar/Увечье/割碎/割碎]]R(1024,409832)N[[Fury of Stormrage/Furor von Sturmgrimm/Furia de Tempestira/Furia de Tempestira/Fureur de Hurlorage/Fury of Stormrage/스톰레이지의 격노/Fúria de Tempesfúria/Гнев Ярости Бури/怒风之怒/怒風之怒]]R(1024,409831)N[[Dreamstate/Traumzustand/Estado onírico/Estado onírico/État de rêve/Dreamstate/꿈결/Estado Onírico/Состояние сна/迷梦/夢境]]R(1024,409819)N[[Savage Roar/Wildes Brüllen/Rugido salvaje/Rugido salvaje/Rugissement sauvage/Savage Roar/야생의 포효/Rugido Selvagem/Дикий рев/野蛮咆哮/兇蠻咆哮]]R(1024,409824)N[[Lifebloom/Blühendes Leben/Flor de vida/Flor de vida/Fleur de vie/Lifebloom/피어나는 생명/Brotar da Vida/Жизнецвет/生命绽放/生命之花]]R(1024,409805)N[[Wild Strikes/Wilde Stöße/Golpes descontrolados/Golpes feroces/Frappes féroces/Wild Strikes/야생의 강타/Golpes Selvagens/Дикие удары/狂野打击/狂野打擊]]R(1024,409810)N[[Wild Growth/Wildwuchs/Crecimiento salvaje/Crecimiento salvaje/Croissance sauvage/Wild Growth/급속 성장/Crescimento Silvestre/Буйный рост/野性成长/野性痊癒]]R(1024,409809)N[[Survival Instincts/Überlebensinstinkte/Instintos de supervivencia/Instintos de supervivencia/Instincts de survie/Survival Instincts/생존 본능/Instintos de Sobrevivência/Инстинкты выживания/生存本能/求生本能]]R(1024,409813)N[[Eclipse/Finsternis/Eclipse/Eclipse/Éclipse/Eclipse/일월식/Eclipse/Затмение/日月之蚀/蝕星蔽月]]R(4,409960)N[[Heart of the Lion/Löwenherz/Corazón del león/Corazón del león/Cœur de lion/Heart of the Lion/사자의 심장/Coração de Leão/Львиное сердце/雄狮之心/雄獅之心]]R(4,409961)N[[Dual Wield Specialization/Beidhändigkeitsspezialisierung/Especialización en doble empuñadura/Especialización en doble empuñadura/Spécialisation Ambidextrie/Dual Wield Specialization/쌍수 무기 전문화/Especialização em Duas Armas/Специализация на бое с оружием в обеих руках/双武器专精/雙武器專精]]R(4,409959)N[[Expose Weakness/Schwäche aufdecken/Exponer debilidad/Exponer debilidad/Perce-faille/Expose Weakness/결점 노출/Expor Fraqueza/Выявление слабости/破甲虚弱/弱點識破]]R(4,409958)N[[Master Marksman/Meister der Treffsicherheit/Maestro Tirador/Maestro tirador/Maître tireur/Master Marksman/사격의 명수/Mestre Atirador Perito/Мастер стрельбы/神射手/狙擊大師]]R(4,409957)N[[Steady Shot/Zuverlässiger Schuss/Disparo firme/Disparo firme/Tir assuré/Steady Shot/고정 사격/Tiro Firme/Верный выстрел/稳固射击/穩固射擊]]R(4,409962)N[[Beast Mastery/Meister der Tiere/Maestría en bestias/Maestría de bestias/Maîtrise des bêtes/Beast Mastery/야수 숙련/Domínio das Feras/Повелитель зверей/野兽控制/野獸控制]]R(4,409968)N[[Trap Launcher/Fallenschleuder/Lanzador de trampas/Lanzador de trampas/Lance-piège/Trap Launcher/덫 발사/Lançador de Armadilhas/Бросок ловушки/陷阱发射器/發動陷阱]]R(4,409976)N[[Chimera Shot/Schimärenschuss/Disparo de quimera/Disparo de quimera/Tir de la chimère/Chimera Shot/키메라 사격/Tiro Quimérico/Выстрел химеры/奇美拉射击/奇美拉射擊]]R(4,409978)N[[Explosive Shot/Explosivschuss/Disparo explosivo/Disparo explosivo/Tir explosif/Explosive Shot/폭발 사격/Tiro Explosivo/Разрывной выстрел/爆炸射击/爆裂射擊]]R(4,409974)N[[Kill Command/Tötungsbefehl/Matar/Matar/Ordre de tuer/Kill Command/살상 명령/Comando para Matar/Команда "Взять!"/杀戮命令/擊殺命令]]R(4,409979)N[[Lone Wolf/Einsamer Wolf/Lobo solitario/Lobo solitario/Loup solitaire/Lone Wolf/고독한 늑대/Lobo Solitário/Одинокий волк/独来独往/孤狼]]R(64,409944)N[[Ancestral Guidance/Führung der Ahnen/Guía ancestral/Guía ancestral/Soutien ancestral/Ancestral Guidance/고대의 인도/Conselho dos Ancestrais/Наставления предков/先祖指引/先祖導引]]R(64,409940)N[[Dual Wield Specialization/Beidhändigkeitsspezialisierung/Especialización en doble empuñadura/Especialización en doble empuñadura/Spécialisation Ambidextrie/Dual Wield Specialization/쌍수 무기 전문화/Especialização em Duas Armas/Специализация на бое с оружием в обеих руках/双武器专精/雙武器專精]]R(64,409938)N[[Fire Nova/Feuernova/Nova de Fuego/Nova de Fuego/Nova de feu/Fire Nova/불꽃 회오리/Nova de Fogo/Кольцо огня/火焰新星/火焰新星]]R(64,409943)N[[Shield Mastery/Schildmeisterschaft/Maestría con escudos/Maestría con escudos/Maîtrise du bouclier/Shield Mastery/방패 숙련/Proficiência em Escudo/Мастерское владение щитом/盾牌精通/精通盾牌]]R(64,409941)N[[Water Shield/Wasserschild/Escudo de agua/Escudo de agua/Bouclier d’eau/Water Shield/물의 보호막/Escudo de Água/Водный щит/水之护盾/水之盾]]R(64,409947)N[[Earth Shield/Erdschild/Escudo de tierra/Escudo de tierra/Bouclier de terre/Earth Shield/대지의 보호막/Escudo da Terra/Щит земли/大地之盾/大地之盾]]R(64,409946)N[[Maelstrom Weapon/Waffe des Mahlstroms/Arma vorágine/Arma vorágine/Arme du Maelström/Maelstrom Weapon/소용돌이치는 무기/Arma da Voragem/Оружие Водоворота/漩涡武器/氣漩武器]]R(64,409945)N[[Overload/Überladung/Sobrecarga/Sobrecarga/Surcharge/Overload/과부하/Sobrecarga/Перегрузка/过载/超載]]R(64,409951)N[[Spirit of the Alpha/Geist des Alphas/Espíritu del alfa/Espíritu del alfa/Esprit de l’alpha/Spirit of the Alpha/우두머리의 영혼/Espírito do Alfa/Дух вожака стаи/头狼之魂/獸群首領之靈]]R(64,409952)N[[Lava Burst/Lavaeruption/Ráfaga de lava/Ráfaga de lava/Explosion de lave/Lava Burst/용암 폭발/Estouro de Lava/Выброс лавы/熔岩爆裂/熔岩爆發]]R(64,409953)N[[Lava Lash/Lavapeitsche/Latigazo de lava/Latigazo de lava/Fouet de lave/Lava Lash/용암 채찍/Açoite de Lava/Вскипание лавы/熔岩猛击/熔岩暴擊]]R(64,409954)N[[Riptide/Springflut/Mareas Vivas/Mareas Vivas/Remous/Riptide/성난 해일/Contracorrente/Быстрина/激流/激流]]R(64,409955)N[[Way of Earth/Weg der Erde/Camino de la tierra/Tradición de tierra/Voie de la terre/Way of Earth/대지의 길/Caminho Telúrico/Путь земли/土之道/大地之道]]R(1024,415709)N[[Survival of the Fittest/Überleben des Stärkeren/Supervivencia del más fuerte/Supervivencia del más fuerte/Survie du plus fort/Survival of the Fittest/적자 생존/Lei da Selva/Выживание сильнейших/优胜劣汰/適者生存]]R(1024,414692)N[[Sunfire/Sonnenfeuer/Fuego solar/Fuego solar/Éclat solaire/Sunfire/태양섬광/Fogo Solar/Солнечный огонь/阳炎术/日炎術]]R(128,415459)N[[Spell Power/Zaubermacht/Poder con hechizos/Poder con hechizos/Puissance des sorts/Spell Power/주문력/Poder Mágico/Сила заклинаний/法术强权/法術能量]]R(1,415599)N[[Single-Minded Fury/Zielstrebiger Furor/Furia enfocada/Furia enfilada/Fureur obsessionnelle/Single-Minded Fury/하나된 분노/Fúria Obcecada/Свирепая неистовость/鲁莽怒火/一心狂怒]]R(2,415703)N[[Sacred Shield/Geheiligter Schild/Escudo sacro/Escudo sacro/Bouclier saint/Sacred Shield/성스러운 보호막/Escudo Sagrado/Священный щит/圣洁护盾/崇聖護盾]]R(64,415712)N[[Power Surge/Kraftwoge/Oleada de poder/Oleada de poder/Vague de puissance/Power Surge/마력의 쇄도/Surto de Poder/Волна силы/能量涌动/能量激增]]R(16,415481)N[[Pain and Suffering/Schmerz und Leid/Dolor y sufrimiento/Dolor y sufrimiento/Douleur et souffrance/Pain and Suffering/고통과 고뇌/Dor e Sofrimento/Боль и страдание/饱受折磨/苦痛受難]]R(64,415713)N[[Mental Dexterity/Geistige Gewandtheit/Maña mental/Maña mental/Dextérité mentale/Mental Dexterity/교묘한 정신/Destreza Mental/Гибкость разума/聪慧/心靈迅敏]]R(4,415723)N[[Melee Specialist/Nahkampfspezialist/Especialista cuerpo a cuerpo/Especialista cuerpo a cuerpo/Spécialiste de la mêlée/Melee Specialist/근접 전투 전문가/Especialista em Corpo a Corpo/Специалист по ближнему бою/近战专家/近戰專家]]R(128,415467)N[[Mass Regeneration/Massenregeneration/Regeneración en masa/Regeneración en masa/Régénération de masse/Mass Regeneration/대규모 재생력/Regeneração em Massa/Массовая регенерация/群体再生/群體恢復]]R(4,415719)N[[Lock and Load/Sichern und Laden/Bloquear y cargar/Bloquear y cargar/Prêt à tirer/Lock and Load/실탄 장전/Largar o Dedo/На изготовку!/荷枪实弹/蓄勢待發]]R(128,401731)N[[Living Bomb/Lebende Bombe/Bomba viva/Bomba viva/Bombe vivante/Living Bomb/살아있는 폭탄/Bomba Viva/Живая бомба/活动炸弹/活體爆彈]]R(64,415714)N[[Healing Rain/Heilender Regen/Lluvia de sanación/Lluvia de sanación/Pluie guérisseuse/Healing Rain/치유의 비/Chuva Curativa/Исцеляющий дождь/治疗之雨/治癒之雨]]R(1,415598)N[[Gladiator Stance/Gladiatorhaltung/Actitud de gladiador/Actitud de gladiador/Posture du gladiateur/Gladiator Stance/검투사 태세/Postura do Gladiador/Стойка гладиатора/角斗姿态/鬥士姿態]]R(256,415604)N[[Everlasting Affliction/Immerwährende Gebrechen/Aflicción eterna/Aflicción eterna/Affliction éternelle/Everlasting Affliction/영원한 고통/Agonia Eterna/Беспрерывное колдовство/持久痛苦/無間痛苦]]R(256,415605)N[[Demonic Tactics/Dämonische Taktiken/Tácticas demoníacas/Tácticas demoníacas/Tactique démoniaque/Demonic Tactics/악마의 술책/Táticas Demoníacas/Власть над демонами/恶魔战术/惡魔策略]]R(4,415717)N[[Catlike Reflexes/Katzenhafte Reflexe/Reflejos felinos/Reflejos felinos/Réflexes félins/Catlike Reflexes/살쾡이의 반사 신경/Reflexos Felinos/Кошачьи рефлексы/猎豹敏捷/靈貓迅閃]]R(4,415718)N[[Aspect of the Viper/Aspekt der Viper/Aspecto de la víbora/Aspecto de la víbora/Aspect de la vipère/Aspect of the Viper/독사의 상/Aspecto da Víbora/Дух гадюки/蝰蛇守护/蝮蛇的化身]]R(2,415706)N[[The Art of War/Die Kunst des Krieges/El arte de la guerra/El arte de la guerra/L’art de la guerre/The Art of War/전쟁의 기술/A Arte da Guerra/Искусство войны/战争艺术/戰爭藝術]]R(8,415725)N[[Waylay/Auflauern/Acecho/Acecho/Affût/Waylay/습격/Atocaiar/Засада/埋伏/埋伏]]R(16,415740)N[[Strength of Soul/Kraftvolle Seele/Fuerza del alma/Fuerza del alma/Force d’âme/Strength of Soul/굳건한 정신/Força da Alma/Сила души/灵魂之力/靈魂之力]]R(128,415734)N[[Spellfrost Bolt/Zauberfrostblitz/Descarga de Fríoarcano/Descarga de fríoarcano/Trait givre-sort/Spellfrost Bolt/비전냉기 화살/Seta de Gelo Mágico/Стрела чар льда/法术冰霜箭/法霜箭]]R(4,415818)N[[Sniper Training/Scharfschützentraining/Instrucción de francotirador/Instrucción de francotirador/Entraînement de sniper/Sniper Training/저격 훈련/Treinamento de Franco-atirador/Навыки снайпера/狙击训练/狙擊訓練]]R(1024,415759)N[[Skull Bash/Schädelstoß/Testarazo/Testarazo/Coup de crâne/Skull Bash/두개골 강타/Esmagar Crânio/Лобовая атака/迎头痛击/碎顱猛擊]]R(16,415737)N[[Serendipity/Glücksfall/Serendipia/Serendipia/Heureux hasard/Serendipity/우연한 행운/Serendipidade/Прозорливость/妙手回春/機緣回復]]R(4,415822)N[[Raptor Fury/Raptorenfuror/Furia de raptor/Furia de raptor/Fureur du raptor/Raptor Fury/랩터의 격노/Fúria do Raptor/Неистовство ящера/猛禽之怒/迅猛龍狂怒]]R(4,415817)N[[Rapid Killing/Schneller Tod/Matanza rápida/Matanza rápida/Tueur rapide/Rapid Killing/신속한 사냥/Matança Veloz/Быстрые убийства/疾速杀戮/急速殺戮]]R(1,415744)N[[Precise Timing/Präzises Timing/Sincronización precisa/Tiempo preciso/Moment exact/Precise Timing/정확한 시간 감각/Momento Exato/Точный расчет/精准猛击/精準時機]]R(16,415738)N[[Mind Sear/Gedankenexplosion/Abrasamiento mental/Abrasamiento mental/Incandescence mentale/Mind Sear/정신 불태우기/Calcinação Mental/Иссушение разума/精神灼烧/心靈烙印]]R(1024,415761)N[[Living Seed/Samenkorn des Lebens/Semilla viviente/Semilla viviente/Graine de vie/Living Seed/살아있는 씨앗/Semente Viva/Семя жизни/生命之种/生命種子]]R(1024,415760)N[[Lacerate/Aufschlitzen/Lacerar/Lacerar/Lacérer/Lacerate/가르기/Lacerar/Растерзать/割伤/割裂]]R(4,415816)N[[Invigoration/Kräftigung/Vigorización/Vigorización/Revigoration/Invigoration/사기 고취/Envigorar/Окрыление/鼓舞/精神鼓舞]]R(256,415750)N[[Incinerate/Verbrennen/Incinerar/Incinerar/Incinérer/Incinerate/소각/Incinerar/Испепеление/烧尽/燒盡]]R(2,415755)N[[Guarded by the Light/Vom Licht behütet/Custodiado por la Luz/Custodiado por la Luz/Gardé par la Lumière/Guarded by the Light/빛의 인도/Protegido pela Luz/Под охраной света/圣光守护/聖光守護]]R(2,415756)N[[Exorcist/Exorzist/Exorcista/Exorcista/Exorciste/Exorcist/퇴마사/Exorcista/Экзорцист/驱魔人/驅邪術]]R(128,415729)N[[Enlightenment/Erleuchtung/Esclarecimiento/Esclarecimiento/Illumination/Enlightenment/깨달음/Esclarecimento/Просветление/启迪/啟蒙]]R(1024,415762)N[[Elune's Fires/Feuer Elunes/Fuegos de Elune/Fuegos de Elune/Feux d’Élune/Elune's Fires/엘룬의 불꽃/Chamas de Eluna/Огни Элуны/艾露恩之火/伊露恩之火]]R(256,415749)N[[Demonic Knowledge/Dämonisches Wissen/Conocimiento demoníaco/Conocimiento demoníaco/Connaissance démoniaque/Demonic Knowledge/악마의 지식/Conhecimento Demoníaco/Демоническое знание/恶魔知识/惡魔知識]]R(256,415751)N[[Dance of the Wicked/Tanz des Tückischen/Danza de los malditos/Danza de los malvados/Dance des malveillants/Dance of the Wicked/악인의 춤/Dança dos Perversos/Гибельный танец/堕落之舞/邪惡之舞]]R(64,415768)N[[Burn/Brennen/Quemar/Quemar/Brûler/Burn/태우기/Queimar/Горение/燃烧/燃燒]]R(1,415743)N[[Blood Surge/Blutwoge/Oleada sangrienta/Oleada de sangre/Vague de sang/Blood Surge/피 분출/Rebentação de Sangue/Всплеск крови/血涌/鮮血澎湃]]R(1024,424715)N[[Starsurge/Sternensog/Oleada de estrellas/Oleada de estrellas/Éruption stellaire/Starsurge/별빛쇄도/Surto Estelar/Звездный поток/星涌术/星湧術]]R(1024,424762)N[[King of the Jungle/König des Dschungels/Rey de la selva/Rey de la selva/Roi de la jungle/King of the Jungle/정글의 왕/Rei da Selva/Король джунглей/丛林之王/叢林之王]]R(1024,424759)N[[Berserk/Berserker/Rabia/Rabia/Berserk/Berserk/광폭화/Berserk/Берсерк/狂暴/狂暴]]R(8,424983)N[[Slaughter from the Shadows/Hinterhältiger Mord/Matanza desde las Sombras/Matanza desde las Sombras/Ombres meurtrières/Slaughter from the Shadows/어둠의 학살자/Atacar das Sombras/Резня во тьме/暗影杀手/伏影抹殺]]R(8,424979)N[[Saber Slash/Säbelschlitzer/Tajo de sable/Sablazo/Coup de sabre/Saber Slash/사브르 베기/Talho de Sabre/Удар саблей/军刀猛刺/刀劍斬擊]]R(8,424980)N[[Shiv/Tückische Klinge/Puyazo/Puyazo/Kriss/Shiv/독칼/Estocada/Отравляющий укол/毒刃/毒襲]]R(8,424982)N[[Main Gauche/Parierdolch/Daga de guardamano/Daga de guardamano/Main gauche/Main Gauche/맹고쉬/Adaga de Bloqueio/Главный аргумент/左右开弓/左右開弓]]R(8,425101)N[[Master of Subtlety/Meister des hinterhältigen Angriffs/Maestro de la sutileza/Maestro de la sutileza/Maître de la discrétion/Master of Subtlety/잠행의 대가/Mestre do Subterfúgio/Мастер скрытности/敏锐大师/敏銳大師]]R(8,425100)N[[Poisoned Knife/Vergiftetes Messer/Cuchillo envenenado/Cuchillo envenenado/Couteau empoisonné/Poisoned Knife/독 칼/Faca Envenenada/Отравленный нож/剧毒之刃/塗毒小刀]]R(128,425168)N[[Arcane Surge/Arkane Woge/Oleada Arcana/Oleada Arcana/Éruption d’arcanes/Arcane Surge/비전 쇄도/Surto Arcano/Чародейский выброс/奥术涌动/秘法奔騰]]R(128,425169)N[[Icy Veins/Eisige Adern/Venas heladas/Venas heladas/Veines glaciales/Icy Veins/얼음 핏줄/Veias Gélidas/Стылая кровь/冰冷血脉/冰寒脈動]]R(128,425187)N[[Chronostatic Preservation/Chronostatische Bewahrung/Preservación cronostática/Preservación cronoestática/Préservation chronostatique/Chronostatic Preservation/시간의 보존/Preservação Cronostática/Темпоральное спасение/凝时恩护/時滯存護]]R(16,425212)N[[Power Word: Barrier/Machtwort: Barriere/Palabra de poder: barrera/Palabra de poder: barrera/Mot de pouvoir : Barrière/Power Word: Barrier/신의 권능: 방벽/Palavra de Poder: Barreira/Слово Силы: Барьер/真言术：障/真言術：壁]]R(16,425211)N[[Void Plague/Pest der Leere/Plaga del Vacío/Plaga del Vacío/Fléau du Vide/Void Plague/공허의 역병/Peste do Caos/Чума Бездны/虚空疫病/虛無瘟疫]]R(16,425210)N[[Twisted Faith/Okkultismus/Fe distorsionada/Fe distorsionada/Foi distordue/Twisted Faith/뒤틀린 믿음/Fé Corrompida/Обман разума/扭曲信仰/扭曲信念]]R(16,425302)N[[Empowered Renew/Machterfüllte Erneuerung/Renovar potenciado/Renovar potenciado/Rénovation surpuissante/Empowered Renew/소생 강화/Renovação Potencializada/Усиленное обновление/恢复增效/強力恢復]]R(16,425303)N[[Renewed Hope/Erneuerte Hoffnung/Esperanza renovada/Esperanza renovada/Regain d’espoir/Renewed Hope/새로운 희망/Esperança Renovada/Новая надежда/新生希望/嶄新希望]]R(16,425304)N[[Spirit of the Redeemer/Geist des Erlösers/Espíritu del redentor/Espíritu del redentor/Esprit du rédempteur/Spirit of the Redeemer/구원자의 영혼/Espírito do Redentor/Дух воздаяния/救赎者之魂/救星之靈]]R(16,425307)N[[Dispersion/Dispersion/Dispersión/Dispersión/Dispersion/Dispersion/분산/Dispersão/Слияние с Тьмой/消散/影散]]R(64,425340)N[[Molten Blast/Schmelzschlag/Explosión de arrabio/Explosión de arrabio/Éclair de lave/Molten Blast/용암 작열/Impacto Derretido/Всплеск лавы/熔火爆裂/熔岩爆裂]]R(64,425341)N[[Shamanistic Rage/Schamanistische Wut/Ira del chamán/Ira del chamán/Rage du chaman/Shamanistic Rage/주술의 분노/Fúria Xamanística/Ярость шамана/萨满之怒/薩滿之怒]]R(1,425428)N[[Quick Strike/Rasanter Schlag/Golpe rápido/Golpe rápido/Frappe rapide/Quick Strike/속전속결/Golpe Rápido/Быстрый удар/迅捷打击/快速打擊]]R(1,425429)N[[Raging Blow/Wütender Schlag/Arremetida enfurecida/Arremetida enfurecida/Coup déchaîné/Raging Blow/분노의 강타/Golpe Furioso/Яростный выпад/怒击/狂怒之擊]]R(1,425430)N[[Warbringer/Kriegstreiber/Belisario/Belisario/Porteguerre/Warbringer/돌격대장/Armipotente/Вестник войны/战神/戰爭使者]]R(1,425440)N[[Consumed by Rage/Von Wut zerfressen/Consumido por la ira/Consumido por la ira/Consumé par la rage/Consumed by Rage/분노 잠식/Consumido pela Raiva/Неконтролируемая ярость/噬心狂怒/怒火攻心]]R(1,425442)N[[Frenzied Assault/Rasender Angriff/Asalto frenético/Asalto frenético/Assaut frénétique/Frenzied Assault/광란의 공격/Ataque Frenético/Неистовый натиск/狂乱攻击/狂暴襲擊]]R(256,425474)N[[Demonic Grace/Dämonische Anmut/Gracia demoníaca/Gracia demoníaca/Grâce démoniaque/Demonic Grace/악마의 은총/Graça Demoníaca/Демоническая грация/恶魔优雅/魔化恩典]]R(256,425473)N[[Demonic Pact/Dämonischer Pakt/Pacto demoníaco/Pacto demoníaco/Pacte démoniaque/Demonic Pact/악마의 서약/Pacto Demoníaco/Демонический союз/恶魔契约/惡魔契印]]R(2,425614)N[[Horn of Lordaeron/Horn von Lordaeron/Cuerno de Lordaeron/Cuerno de Lordaeron/Cor de Lordaeron/Horn of Lordaeron/로데론의 뿔피리/Trompa de Lordaeron/Горн Лордерона/洛丹伦号角/羅德隆號角]]R(2,425615)N[[Aegis/Aegis/Égida/Égida/Égide/Aegis/보호/Égide/Покровительство/神盾/神禦]]R(2,425616)N[[Rebuke/Zurechtweisung/Reprimenda/Reprimenda/Réprimandes/Rebuke/비난/Repreensão/Укор/责难/責難]]R(4,425754)N[[Carve/Zerlegen/Trinchar/Cuchillada/Écharper/Carve/저미기/Trinchar/Разделка туши/削凿/橫劈]]R(4,425756)N[[Serpent Spread/Schlangenspur/Propagar serpientes/Propagación serpentina/Propagation du serpent/Serpent Spread/독사 확산/Espalhar de Serpente/Распространяющийся укус/毒蛇扩散/蛇毒蔓延]]R(4,425757)N[[Flanking Strike/Flankenangriff/Golpe de flanco/Golpe lateral/Frappe latérale/Flanking Strike/측방 강타/Ataque Flanqueante/Обходной удар/侧翼打击/側翼攻擊]]R(4,425755)N[[Cobra Strikes/Kobrastöße/Golpes de cobra/Golpes de cobra/Frappes de cobra/Cobra Strikes/코브라의 일격/Golpes de Naja/Бросок кобры/眼镜蛇打击/眼鏡蛇之擊]]R(64,425879)N[[Ancestral Awakening/Erwachen der Ahnen/Despertar ancestral/Despertar ancestral/Éveil ancestral/Ancestral Awakening/고대의 각성/Despertar Ancestral/Пробуждение древних/先祖复苏/先祖復甦]]R(64,425881)N[[Decoy Totem/Täuschtotem/Tótem señuelo/Tótem señuelo/Totem de leurre/Decoy Totem/미끼 토템/Totem Chamariz/Тотем-приманка/诱饵图腾/誘餌圖騰]]R(2,426174)N[[Enlightened Judgements/Erleuchtete Richturteile/Sentencias iluminadas/Sentencias iluminadas/Jugements éclairés/Enlightened Judgements/깨달음의 심판/Julgamentos Esclarecidos/Просветленное суждение/开明审判/啟發審判]]R(2,426176)N[[Sheath of Light/Ummantelung des Lichts/Vaina de Luz/Vaina de Luz/Fourreau de lumière/Sheath of Light/수호의 빛/Bainha de Luz/Покров Света/圣光出鞘/聖光之鞘]]R(2,426179)N[[Infusion of Light/Lichtinfusion/Infusión de Luz/Infusión de Luz/Imprégnation de lumière/Infusion of Light/빛 주입/Infusão de Luz/Прилив Света/圣光灌注/聖光灌注]]R(256,426442)N[[Invocation/Anrufung/Invocación/Invocación/Évocation/Invocation/환기/Invocação/Заклятие/祈告/祈咒]]R(256,426444)N[[Grimoire of Synergy/Grimoire der Synergie/Grimorio de sinergia/Grimorio de sinergia/Grimoire de synergie/Grimoire of Synergy/흑마법서: 결속/Grimório de Sinergia/Гримуар уз/协同魔典/協調魔典]]R(256,426449)N[[Shadow and Flame/Schatten und Flamme/Sombras y llamas/Sombras y llamas/Ombre et flammes/Shadow and Flame/어둠과 불길/Sombra e Chama/Тьма и пламя/影与焰/暗影與火焰]]R(256,426454)N[[Shadowflame/Schattenflamme/Pirosombra/Llama de las Sombras/Ombreflamme/Shadowflame/암흑불길/Chama Sombria/Пламя Тьмы/暗影烈焰/暗影之焰]]R(256,426469)N[[Vengeance/Rache/Venganza/Venganza/Vengeance/Vengeance/복수/Vingança/Отмщение/复仇/復仇]]R(1,426492)N[[Rallying Cry/Anspornender Schrei/Berrido de convocación/Berrido de convocación/Cri de ralliement/Rallying Cry/재집결의 함성/Brado de Convocação/Ободряющий клич/集结呐喊/振奮咆哮]]R(1,427067)N[[Taste for Blood/Verlangen nach Blut/Gusto por la sangre/Gusto por la sangre/Goût du sang/Taste for Blood/피의 맛/Apetite por Sangue/Вкус крови/血之气息/血腥體驗]]R(1,427068)N[[Vigilance/Wachsamkeit/Vigilancia/Vigilancia/Vigilance/Vigilance/경계/Vigilância/Бдительность/警戒/戒備守護]]R(1,427069)N[[Shield Mastery/Schildmeisterschaft/Maestría con escudos/Maestría con escudos/Maîtrise du bouclier/Shield Mastery/방패 숙련/Proficiência em Escudo/Мастерское владение щитом/盾牌精通/精通盾牌]]R(1,427070)N[[Rampage/Toben/Desenfreno/Desenfreno/Saccager/Rampage/광란/Alvoroço/Буйство/暴怒/暴怒]]R(1,427073)N[[Sword and Board/Schwert und Schild/Escudo y espada/Escudo y espada/Épée et bouclier/Sword and Board/검과 방패/Espada e Escudo/Щит и меч/剑盾猛攻/劍盾合璧]]R(1,427074)N[[Wrecking Crew/Abrisskommando/Equipo de demolición/Equipo de demolición/Démolisseurs/Wrecking Crew/파괴자/Violência Gratuita/Погром/破坏能手/破壞專家]]R(2,429250)N[[Fanaticism/Fanatismus/Fanatismo/Fanatismo/Fanatisme/Fanaticism/광신/Fanatismo/Фанатизм/狂信/狂熱]]R(2,429248)N[[Wrath/Zorn/Cólera/Cólera/Colère/Wrath/천벌/Ira/Гнев/愤怒/憤怒]]R(2,429245)N[[Improved Sanctuary/Verbessertes Refugium/Salvaguardia mejorada/Santuario mejorado/Sanctuaire amélioré/Improved Sanctuary/성역 연마/Santuário Aprimorado/Улучшенное святилище/强化庇护/強化庇護]]R(2,429243)N[[Light's Grace/Anmut des Lichts/Gracia de Luz/Gracia de Luz/Grâce de la Lumière/Light's Grace/빛의 은총/Graça da Luz/Благоволение Света/光之优雅/聖光恩典]]R(2,429259)N[[Improved Hammer of Wrath/Verbesserter Hammer des Zorns/Martillo de cólera mejorado/Martillo de cólera mejorado/Marteau de courroux amélioré/Improved Hammer of Wrath/천벌의 망치 연마/Martelo da Ira Aprimorado/Улучшенный молот гнева/强化愤怒之锤/強化憤怒之錘]]R(2,429254)N[[Purifying Power/Reinigende Macht/Poder purificador/Poder purificador/Puissance purifiante/Purifying Power/정화의 힘/Poder Purificador/Очищающая сила/净化之力/淨化能量]]R(128,429305)N[[Temporal Anomaly/Zeitanomalie/Anomalía temporal/Anomalía temporal/Anomalie temporelle/Temporal Anomaly/시간 변칙/Anomalia Temporal/Временная аномалия/时空畸体/時空異象]]R(128,429303)N[[Deep Freeze/Tieffrieren/Congelación profunda/Congelación profunda/Congélation/Deep Freeze/동결/Congelamento Profundo/Глубокая заморозка/深度冻结/極度冰凍]]R(128,429310)N[[Balefire Bolt/Qualfeuerblitz/Descarga de Fuegotorvo/Descarga de fuego fardo/Trait de bûcher/Balefire Bolt/재앙불꽃 화살/Seta Incendiária/Стрела гибельного огня/怨火之箭/野火箭]]R(128,428863)N[[Displacement/Verzerrung/Desplazamiento/Desplazamiento/Déplacement/Displacement/변위/Deslocamento/Смещение/闪回/位移]]R(128,429307)N[[Molten Armor/Glühende Rüstung/Armadura de arrabio/Armadura de arrabio/Armure de la fournaise/Molten Armor/타오르는 갑옷/Armadura Derretida/Раскаленный доспех/熔岩护甲/炎甲術]]R(1024,431448)N[[Improved Barkskin/Verbesserte Baumrinde/Piel de corteza mejorada/Piel de corteza mejorada/Écorce améliorée/Improved Barkskin/나무 껍질 연마/Pele de Árvore Aprimorada/Улучшенная дубовая кожа/强化树皮术/強化樹皮術]]R(1024,431446)N[[Gore/Aufspießen/Cornada/Cornada/Étripage/Gore/꿰뚫기/Escornar/Кровавая атака/淤血/浴血奮戰]]R(1024,431450)N[[Gale Winds/Orkanwinde/Viento huracanado/Vientos huracanados/Grands vents/Gale Winds/강풍/Tormenta/Штормовые ветра/烈风/強風]]R(1024,431458)N[[Improved Frenzied Regeneration/Verbesserte rasende Regeneration/Regeneración frenética mejorada/Regeneración frenética mejorada/Régénération frénétique améliorée/Improved Frenzied Regeneration/광포한 재생력 연마/Glifo de Regeneração Frenética Aprimorada/Улучшенное неистовое восстановление/强化狂暴回复/強化狂暴恢復]]R(1024,431466)N[[Efflorescence/Erblühen/Floración/Floración/Efflorescence/Efflorescence/꽃피우기/Eflorescência/Период цветения/百花齐放/生命綻放]]R(4,431610)N[[T.N.T./T.N.T./TNT/TNT/T.N.T./T.N.T./강력한 폭탄/T.N.T./Тротил/T.N.T./黃色炸藥]]R(4,431600)N[[Focus Fire/Fokussiertes Feuer/Enfocar Fuego/Enfocar fuego/Focalisation du feu/Focus Fire/화력 집중/Fogo Concentrado/Сконцентрированный огонь/集中火力/專注射擊]]R(16,431649)N[[Divine Aegis/Göttliche Aegis/Égida divina/Égida divina/Égide divine/Divine Aegis/신의 보호/Égide Divina/Божественное покровительство/神圣庇护/神禦之盾]]R(16,431662)N[[Mind Spike/Gedankenstachel/Púa mental/Púa mental/Pointe mentale/Mind Spike/정신의 쐐기/Aguilhão Mental/Пронзание разума/心灵尖刺/心靈鑽刺]]R(16,431668)N[[Surge of Light/Woge des Lichts/Oleada de Luz/Oleada de Luz/Vague de Lumière/Surge of Light/빛의 쇄도/Torrente de Luz/Пробуждение Света/圣光涌动/光之澎湃]]R(16,431675)N[[Despair/Verzweiflung/Desesperación/Desesperación/Désespoir/Despair/절망/Desespero/Отчаяние/绝望/絕望]]R(16,431704)N[[Void Zone/Zone der Leere/Zona de vacío/Zona de vacío/Zone de Vide/Void Zone/공허의 지대/Área de Caos/Портал Бездны/虚空领域/虛無區域]]R(256,429283)N[[Pandemic/Pandemie/Pandemia/Pandemia/Pandémie/Pandemic/병균 확산/Pandemia/Пандемия/恶疾/災疫]]R(256,431742)N[[Backdraft/Pyrolyse/Explosión de humo/Explosión de humo/Explosion de fumées/Backdraft/역류/Cortina de fogo/Обратный поток/爆燃/爆燃]]R(256,431748)N[[Unstable Affliction/Instabiles Gebrechen/Aflicción inestable/Aflicción inestable/Affliction instable/Unstable Affliction/불안정한 고통/Agonia Instável/Нестабильное колдовство/痛苦无常/痛苦動盪]]R(256,431754)N[[Summon Felguard/Teufelswache beschwören/Invocar a guardia vil/Invocar guardia vil/Invocation de gangregarde/Summon Felguard/지옥수호병 소환/Evocar Guarda Vil/Призыв стража Скверны/召唤恶魔卫士/召喚惡魔守衛]]R(256,431757)N[[Immolation Aura/Feuerbrandaura/Aura de Inmolación/Aura de inmolación/Aura d’immolation/Immolation Aura/제물의 오라/Aura de Imolação/Обжигающий жар/献祭光环/獻祭光環]]R(64,432233)N[[Tidal Waves/Flutwellen/Maremotos/Maremotos/Raz-de-marée/Tidal Waves/굽이치는 물결/Mar Revolto/Приливные волны/潮汐奔涌/治療之潮]]R(64,432237)N[[Static Shock/Statischer Schock/Choque estático/Choque estático/Horion statique/Static Shock/전하 충격/Choque Estático/Статический шок/静电震击/靜電震擊]]R(64,432235)N[[Rolling Thunder/Rollender Donner/Trueno ondulante/Trueno ensordecedor/Tonnerre grondant/Rolling Thunder/구르는 천둥/Eco Ribombante/Громовые раскаты/滚雷/轟天雷]]R(64,432240)N[[Overcharged/Überladen/Sobrecargado/Sobrecarga/Surchargé/Overcharged/과충전/Sobrecarga/Перегруженность/能量超载/超載]]R(8,432294)N[[Honor Among Thieves/Ehre unter Dieben/Honor entre ladrones/Honor entre ladrones/Honneur des voleurs/Honor Among Thieves/도둑의 명예/Honra Entre Ladrões/Воровская честь/盗贼的尊严/盜亦有道]]R(8,432290)N[[Focused Attacks/Fokussierte Angriffe/Ataques centrados/Ataques centrados/Attaques focalisées/Focused Attacks/집중 공격/Ataques Concentrados/Целенаправленные атаки/专注攻击/會心攻擊]]R(8,432292)N[[Combat Potency/Kampfkraft/Potencia de combate/Potencia de combate/Toute-puissance de combat/Combat Potency/전투 능력/Vigor em Combate/Боевой потенциал/作战潜能/作戰潛能]]R(8,432300)N[[Unfair Advantage/Unfairer Vorteil/Ventaja desleal/Ventaja desleal/Avantage déloyal/Unfair Advantage/부당 이득/Vantagem Desleal/Незаслуженное преимущество/压倒优势/卑劣優勢]]R(8,432296)N[[Cut to the Chase/In Stücke schneiden/Acortar/Acortar/Tailler dans le vif/Cut to the Chase/신속한 결말/Ir ao Ponto/Сразу к делу/穷追猛砍/急起直追]]R(8,432298)N[[Carnage/Massaker/Carnicería/Carnicería/Carnage/Carnage/살육자/Chacina/Резня/诛灭/大屠殺]]R(64,436367)N[[Two-Handed Mastery/Zweihandmeisterschaft/Maestría con arma a dos manos/Maestría en dos manos/Maîtrise à deux mains/Two-Handed Mastery/양손 장비 숙련/Maestria em Duas Mãos/Мастер двуручного оружия/双手精通/雙手精通]]
end

-- C_Engraving.IsEquipmentSlotEngravable
function lib:IsEquipmentSlotEngravable(slot)
    if not lib.RuneCategories then
        if GetMaxPlayerLevel() == 40 then -- phase2
            lib.RuneCategories = {
                [5] = true,
                [6] = true,
                [7] = true,
                [8] = true,
                [10] = true,
            }
        else
            lib.RuneCategories = {}
            C_Engraving.RefreshRunesList()
            for _, categories in ipairs(C_Engraving.GetRuneCategories(false, false)) do
                lib.RuneCategories[categories] = true
            end
        end
    end

    return not not lib.RuneCategories[slot]
end

function lib:GetRuneInfo(unit, slot)
    local classMask = 2^(select(2, UnitClassBase(unit)) - 1)
    if not lib.EnchantRuneDB[classMask] then return end

    local tip = lib.ScanTip
    tip:SetOwner(UIParent, "ANCHOR_NONE")
    tip:SetInventoryItem(unit, slot)
    for i = 2, tip:NumLines() do
        local line = _G[lib.ScanTipName.."TextLeft"..i]
        if not line then break end

        local text = line:GetText()
        local spell = text and lib.EnchantRuneDB[classMask][text]
        if spell then
            return text, spell
        end
    end
end