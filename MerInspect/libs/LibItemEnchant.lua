-------------------------------------
-- 物品附魔信息庫 Author: M
-------------------------------------
local MAJOR, MINOR = "LibItemEnchant.7000", 1
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then
    return
end

-- Thanks to RRRRBUA(NGA)
local EnchantItemDB = {

    [1483] = 11622, -- 次级冥思秘药
    [1503] = 11642, -- 次级体质秘药
    [1504] = 11643, -- 次级坚韧秘药
    [1505] = 11644, -- 次级适应秘药
    [1506] = 11645, -- 次级贪婪秘药
    [1507] = 11646, -- 次级贪婪秘药
    [1508] = 11647, -- 次级贪婪秘药
    [1509] = 11648, -- 次级贪婪秘药
    [1510] = 11649, -- 次级贪婪秘药
    [2483] = 18169, -- 火焰黎明衬肩
    [2484] = 18170, -- 冰霜黎明衬肩
    [2485] = 18171, -- 奥术黎明衬肩
    [2486] = 18172, -- 自然黎明衬肩
    [2487] = 18173, -- 暗影黎明衬肩
    [2488] = 18182, -- 多彩黎明衬肩
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
    [2715] = 23547, -- 天灾的活力
    [2716] = 23549, -- 天灾的坚韧
    [2717] = 23548, -- 天灾的威严
    [2721] = 23545, -- 天灾的力量
    [2745] = 24275, -- 银色魔线
    [2746] = 24276, -- 金色魔线
    [2747] = 24273, -- 秘法魔线
    [2748] = 24274, -- 符文魔线
    [2977] = 28882, -- 护卫铭文
    [2978] = 28889, -- 强力护卫铭文
    [2979] = 28878, -- 信仰铭文
    [2980] = 28887, -- 强力信仰铭文
    [2981] = 28881, -- 戒律铭文
    [2982] = 28886, -- 强力戒律铭文
    [2983] = 28885, -- 复仇铭文
    [2986] = 28888, -- 强力复仇铭文
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
    [3325] = 38371, -- 冰虫腿甲片
    [3326] = 38372, -- 蛛魔腿甲片
    [3331] = 38377, -- 龙鳞腿甲片
    [3332] = 38378, -- 巨龙鳞腿甲片
    [3718] = 41601, -- 闪光魔线
    [3719] = 41602, -- 辉煌魔线
    [3720] = 41603, -- 碧蓝魔线
    [3721] = 41604, -- 天蓝魔线
    [3754] = 19785, -- 猎鹰的召唤
    [3755] = 19784, -- 死亡的拥抱
    [3775] = 43302, -- 铁律铭文
    [3776] = 43303, -- 霜刃铭文
    [3777] = 43304, -- 王者铭文
    [3793] = 44067, -- 凯旋铭文
    [3794] = 44068, -- 统御铭文
    [3795] = 44069, -- 凯旋秘药
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
    [3852] = 44957, -- 强效角斗士铭文
    [3853] = 44963, -- 土灵腿甲片
    [3875] = 44131, -- 次级利斧铭文
    [3876] = 44132 -- 次级巅峰铭文

}

-- Data from: M, RRRRBUA(NGA), KibsItemLevel
local EnchantSpellDB = {

    [15] = 2831, -- 轻型护甲片
    [16] = 2832, -- 中型护甲片
    [17] = 2833, -- 重型护甲片
    [18] = 10344, -- 厚重护甲片
    [24] = 7443, -- 卷轴：附魔胸甲 - 初级法力
    [30] = 3974, -- 粗制瞄准镜
    [32] = 3975, -- 普通瞄准镜
    [33] = 3976, -- 精确瞄准镜
    [34] = 7218, -- 铁质平衡锤
    [36] = 6296, -- 炽热魔符
    [37] = 7220, -- 钢质武器链
    [43] = 7216, -- 铁质盾刺
    [44] = 7426, -- 卷轴：附魔胸甲 - 初级吸收
    [63] = 13538, -- 卷轴：附魔胸甲 - 次级吸收
    [65] = 7454, -- 卷轴：附魔披风 - 初级抗性
    [242] = 7748, -- 卷轴：附魔胸甲 - 次级生命
    [243] = 7766, -- 卷轴：附魔护腕 - 初级精神
    [246] = 7776, -- 卷轴：附魔胸甲 - 次级法力
    [248] = 7782, -- 卷轴：附魔护腕 - 初级力量
    [249] = 7786, -- 卷轴：附魔武器 - 初级屠兽
    [250] = 7788, -- 卷轴：附魔武器 - 初级攻击
    [254] = 7857, -- 卷轴：附魔胸甲 - 生命
    [256] = 7861, -- 卷轴：附魔披风 - 次级火焰抗性
    [368] = 34004, -- 附魔披风 - 强效敏捷
    [369] = 34001, -- 附魔护腕 - 特效智力
    [463] = 9781, -- 秘银盾刺
    [464] = 9783, -- 秘银马刺
    [663] = 12459, -- 致命瞄准镜
    [664] = 12460, -- 狙击瞄准镜
    [684] = 33995, -- 附魔手套 - 特效力量
    [744] = 13421, -- 卷轴：附魔披风 - 次级防护
    [783] = 7771, -- 卷轴：附魔披风 - 初级防护
    [803] = 13898, -- 卷轴：附魔武器 - 烈焰
    [804] = 13522, -- 卷轴：附魔披风 - 次级暗影抵抗
    [805] = 13943, -- 卷轴：附魔武器 - 强效攻击
    [823] = 13536, -- 卷轴：附魔护腕 - 次级力量
    [843] = 13607, -- 卷轴：附魔胸甲 - 法力
    [844] = 13612, -- 卷轴：附魔手套 - 采矿
    [845] = 13617, -- 卷轴：附魔手套 - 草药学
    [847] = 13626, -- 卷轴：附魔胸甲 - 初级属性
    [850] = 13640, -- 卷轴：附魔胸甲 - 强效生命
    [853] = 13653, -- 卷轴：附魔武器 - 次级屠兽
    [854] = 13655, -- 卷轴：附魔武器 - 次级元素杀手
    [857] = 13663, -- 卷轴：附魔胸甲 - 强效法力
    [863] = 13689, -- 卷轴：附魔盾牌 - 次级格挡
    [865] = 13698, -- 卷轴：附魔手套 - 剥皮
    [866] = 13700, -- 卷轴：附魔胸甲 - 次级状态
    [884] = 13746, -- 卷轴：附魔披风 - 强效防御
    [903] = 13794, -- 卷轴：附魔披风 - 抗性
    [905] = 13822, -- 卷轴：附魔护腕 - 智力
    [906] = 13841, -- 卷轴：附魔手套 - 高级采矿
    [908] = 13858, -- 卷轴：附魔胸甲 - 超强生命
    [909] = 13868, -- 卷轴：附魔手套 - 高级草药学
    [911] = 13890, -- 卷轴：附魔靴子 - 初级速度
    [912] = 13915, -- 卷轴：附魔武器 - 屠魔
    [913] = 13917, -- 卷轴：附魔胸甲 - 超强法力
    [923] = 13931, -- 卷轴：附魔护腕 - 偏斜
    [924] = 7428, -- 卷轴：附魔护腕 - 初级偏斜
    [925] = 13646, -- 卷轴：附魔护腕 - 次级偏斜
    [928] = 13941, -- 卷轴：附魔胸甲 - 状态
    [930] = 13947, -- 卷轴：附魔手套 - 骑乘
    [931] = 13948, -- 卷轴：附魔手套 - 初级加速
    [1071] = 34009, -- 附魔盾牌 - 特效耐力
    [1075] = 44528, -- 卷轴：附魔靴子 - 强效耐力
    [1099] = 60663, -- 卷轴：附魔披风 - 特效敏捷
    [1103] = 44633, -- 卷轴：附魔武器 - 优异敏捷
    [1128] = 60653, -- 卷轴：附魔盾牌 - 强效智力
    [1144] = 33990, -- 附魔胸甲 - 特效精神
    [1257] = 34005, -- 附魔披风 - 强效奥术抗性
    [1262] = 44596, -- 卷轴：附魔披风 - 超强奥术抗性
    [1354] = 44556, -- 卷轴：附魔披风 - 超强火焰抗性
    [1400] = 44494, -- 卷轴：附魔披风 - 超强自然抗性
    [1441] = 34006, -- 附魔披风 - 强效暗影抗性
    [1446] = 44590, -- 卷轴：附魔披风 - 超强暗影抗性
    [1594] = 33996, -- 附魔手套 - 突袭
    [1597] = 60763, -- 卷轴：附魔靴子 - 强效突袭
    [1600] = 60616, -- 卷轴：附魔护腕 - 打击
    [1603] = 60668, -- 卷轴：附魔手套 - 碾压
    [1606] = 60621, -- 卷轴：附魔武器 - 强效潜能
    [1704] = 16623, -- 瑟银盾刺
    [1843] = 19057, -- 毛皮护甲片
    [1883] = 20008, -- 卷轴：附魔护腕 - 强效智力
    [1884] = 20009, -- 卷轴：附魔护腕 - 超强精神
    [1885] = 20010, -- 卷轴：附魔护腕 - 超强力量
    [1886] = 20011, -- 卷轴：附魔护腕 - 超强耐力
    [1889] = 20015, -- 卷轴：附魔披风 - 超强防御
    [1890] = 20016, -- 卷轴：附魔盾牌 - 活力
    [1892] = 20026, -- 卷轴：附魔胸甲 - 特效生命
    [1893] = 20028, -- 卷轴：附魔胸甲 - 特效法力
    [1894] = 20029, -- 卷轴：附魔武器 - 冰寒
    [1896] = 20030, -- 卷轴：附魔双手武器 - 超强冲击
    [1899] = 20033, -- 卷轴：附魔武器 - 邪恶武器
    [1900] = 20034, -- 卷轴：附魔武器 - 十字军
    [1903] = 20035, -- 卷轴：附魔双手武器 - 特效精神
    [1904] = 20036, -- 卷轴：附魔双手武器 - 特效智力
    [1952] = 44489, -- 卷轴：附魔盾牌 - 防御
    [1953] = 47766, -- 卷轴：附魔胸甲 - 强效防御
    [2322] = 33999, -- 附魔手套 - 特效治疗
    [2326] = 44635, -- 卷轴：附魔护腕 - 强效法术能量
    [2332] = 60767, -- 卷轴：附魔护腕 - 超强法术能量
    [2381] = 44509, -- 卷轴：附魔胸甲 - 强效法力回复
    [2443] = 21931, -- 卷轴：附魔武器 - 寒冬之力
    [2463] = 13657, -- 卷轴：附魔披风 - 火焰抗性
    [2503] = 22725, -- 熔火护甲片
    [2504] = 22749, -- 卷轴：附魔武器 - 法术能量
    [2505] = 22750, -- 卷轴：附魔武器 - 治疗能量
    [2563] = 23799, -- 卷轴：附魔武器 - 力量
    [2565] = 23801, -- 卷轴：附魔护腕 - 法力回复
    [2568] = 23804, -- 卷轴：附魔武器 - 强效智力
    [2603] = 13620, -- 卷轴：附魔手套 - 钓鱼
    [2614] = 25073, -- 卷轴：附魔手套 - 暗影能量
    [2615] = 25074, -- 卷轴：附魔手套 - 冰霜能量
    [2616] = 25078, -- 卷轴：附魔手套 - 火焰能量
    [2617] = 25079, -- 卷轴：附魔手套 - 治疗能量
    [2622] = 25086, -- 卷轴：附魔披风 - 躲闪
    [2646] = 27837, -- 卷轴：附魔双手武器 - 敏捷
    [2647] = 27899, -- 附魔护腕 - 强壮
    [2653] = 27944, -- 卷轴：附魔盾牌 - 坚韧盾牌
    [2654] = 27945, -- 附魔盾牌 - 智力
    [2655] = 27946, -- 附魔盾牌 - 盾牌格档
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
    [2679] = 27913, -- 附魔护腕 - 原始法力
    [2714] = 29454, -- 魔钢盾刺
    [2722] = 30250, -- 精金瞄准镜
    [2723] = 30252, -- 氪金瞄准镜
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
    [2935] = 33994, -- 附魔手套 - 法术打击
    [2937] = 33997, -- 附魔手套 - 特效法术能量
    [2938] = 34003, -- 附魔披风 - 法术穿透
    [2939] = 34007, -- 附魔靴子 - 豹之迅捷
    [2940] = 34008, -- 附魔靴子 - 野猪之速
    [2984] = 35415, -- 暗影护甲片
    [2985] = 35416, -- 烈焰护甲片
    [2987] = 35418, -- 冰霜护甲片
    [2988] = 35419, -- 自然护甲片
    [2989] = 35420, -- 奥术护甲片
    [3150] = 33991, -- 卷轴：附魔胸甲 - 优秀法力回复
    [3223] = 42687, -- 精金武器链
    [3225] = 42974, -- 卷轴：附魔武器 - 斩杀
    [3228] = 44119, -- Enchant Bracer - Template
    [3230] = 44483, -- 卷轴：附魔披风 - 超强冰霜抗性
    [3232] = 47901, -- 卷轴：附魔靴子 - 海象人的活力
    [3233] = 27958, -- 卷轴：附魔胸甲 - 优异法力
    [3234] = 44488, -- 卷轴：附魔手套 - 精确
    [3236] = 44492, -- 卷轴：附魔胸甲 - 优异生命
    [3238] = 44506, -- 卷轴：附魔手套 - 采集
    [3239] = 44524, -- 卷轴：附魔武器 - 破冰
    [3241] = 44576, -- 卷轴：附魔武器 - 生命护卫
    [3243] = 44582, -- 卷轴：附魔披风 - 法术穿刺
    [3244] = 44584, -- 卷轴：附魔靴子 - 强效活力
    [3245] = 44588, -- 卷轴：附魔胸甲 - 优异韧性
    [3246] = 44592, -- 卷轴：附魔手套 - 优异法术能量
    [3247] = 44595, -- 卷轴：附魔双手武器 - 天灾斩除
    [3249] = 44612, -- 卷轴：附魔手套 - 强效冲击
    [3251] = 44621, -- 卷轴：附魔武器 - 巨人杀手
    [3252] = 44623, -- 卷轴：附魔胸甲 - 超级属性
    [3253] = 44625, -- 卷轴：附魔手套 - 士兵
    [3256] = 44631, -- 卷轴：附魔披风 - 暗影护甲
    [3260] = 44769, -- 手套强化护甲片
    [3269] = 45697, -- 真银渔线
    [3273] = 46578, -- 卷轴：附魔武器 - 死亡霜冻
    [3290] = 52639, -- 弹簧披风扩张器
    [3294] = 47672, -- 卷轴：附魔披风 - 极效护甲
    [3296] = 47899, -- 卷轴：附魔披风 - 智慧
    [3319] = 50465, -- 插槽单手武器
    [3329] = 50906, -- 北地护甲片
    [3330] = 50909, -- 厚北地护甲片
    [3365] = 53323, -- 裂刃符文
    [3366] = 53331, -- 巫妖斩除符文
    [3367] = 53342, -- 法术碎裂符文
    [3368] = 53344, -- 堕落十字军符文
    [3369] = 53341, -- 灰烬冰河符文
    [3370] = 53343, -- 冰锋符文
    [3594] = 54446, -- 破刃符文
    [3595] = 54447, -- 法术阻断符文
    [3599] = 54736, -- 单兵电磁脉冲发生器
    [3601] = 54793, -- 远距离侦测腰带夹
    [3603] = 54998, -- 手部火箭发射器
    [3604] = 54999, -- 超级加速器
    [3605] = 55002, -- 高弹力衬垫
    [3606] = 55016, -- 硝化甘油推进器
    [3607] = 55076, -- 太阳瞄准镜
    [3608] = 55135, -- 觅心瞄准镜
    [3722] = 55642, -- 亮纹刺绣
    [3728] = 55769, -- 黑光刺绣
    [3730] = 55777, -- 剑刃刺绣
    [3731] = 55836, -- 泰坦神铁武器链
    [3748] = 56353, -- 泰坦神铁盾刺
    [3756] = 57683, -- 毛皮衬垫 - 攻击强度
    [3757] = 57690, -- 毛皮衬垫 - 耐力
    [3758] = 57691, -- 毛皮衬垫 - 法术强度
    [3759] = 57692, -- 毛皮衬垫 - 火焰抗性
    [3760] = 57694, -- 毛皮衬垫 - 冰霜抗性
    [3761] = 57696, -- 毛皮衬垫 - 暗影抗性
    [3762] = 57699, -- 毛皮衬垫 - 自然抗性
    [3763] = 57701, -- 毛皮衬垫 - 奥术抗性
    [3788] = 59619, -- 卷轴：附魔武器 - 精确
    [3789] = 59621, -- 卷轴：附魔武器 - 狂暴
    [3790] = 59625, -- 卷轴：附魔武器 - 黑魔法
    [3791] = 59636, -- 附魔戒指 - 耐力
    [3796] = 59778, -- 统御秘药
    [3824] = 60606, -- 卷轴：附魔靴子 - 突袭
    [3825] = 60609, -- 卷轴：附魔披风 - 速度
    [3826] = 60623, -- 卷轴：附魔靴子 - 履冰
    [3827] = 60691, -- 卷轴：附魔双手武器 - 杀戮
    [3828] = 44630, -- 卷轴：附魔双手武器 - 强效野蛮
    [3829] = 44513, -- 卷轴：附魔手套 - 强效突袭
    [3830] = 44629, -- 卷轴：附魔武器 - 优异法术能量
    [3831] = 47898, -- 卷轴：附魔披风 - 急速
    [3832] = 60692, -- 卷轴：附魔胸甲 - 强力属性
    [3833] = 60707, -- 卷轴：附魔武器 - 超强潜能
    [3834] = 60714, -- 卷轴：附魔武器 - 极效法术能量
    [3835] = 61117, -- 大师的利斧铭文
    [3836] = 61118, -- 大师的峭壁铭文
    [3837] = 61119, -- 大师的巅峰铭文
    [3838] = 61120, -- 大师的风暴铭文
    [3839] = 44645, -- 附魔戒指 - 突袭
    [3840] = 44636, -- 附魔戒指 - 强效法术能量
    [3843] = 61468, -- 钻石折射瞄准镜
    [3844] = 44510, -- 卷轴：附魔武器 - 优异精神
    [3845] = 44575, -- 卷轴：附魔护腕 - 强效突袭
    [3846] = 34010, -- 附魔武器 - 特效治疗
    [3847] = 62158, -- 石肤石像鬼符文
    [3849] = 62201, -- 泰坦神铁护板
    [3850] = 62256, -- 卷轴：附魔护腕 - 特效耐力
    [3851] = 62257, -- 卷轴：附魔武器 - 泰坦护卫
    [3854] = 62948, -- 卷轴：附魔法杖 - 强效法术能量
    [3855] = 62959, -- 卷轴：附魔法杖 - 法术能量
    [3858] = 63746, -- 卷轴：附魔靴子 - 次级精确
    [3859] = 63765, -- 弹力蛛丝
    [3860] = 63770, -- 装甲护网
    [3869] = 64441, -- 卷轴：附魔武器 - 利刃防护
    [3870] = 64579, -- 卷轴：附魔武器 - 吸血
    [3872] = 56039, -- 神圣魔线
    [3873] = 56034, -- 大师的魔线
    [3878] = 67839, -- 思维放大圆盘
    [3883] = 70164, -- 蛛魔甲壳符文

    [846] = 71692, --	卷轴：附魔手套 - 垂钓
    [910] = 359640, --	附魔披风 - 潜行
    [926] = 359895, --	附魔盾牌 - 冰霜抗性
    [1119] = 44555, --	卷轴：附魔护腕 - 优异智力
    [1593] = 359639, --	附魔护腕 - 突袭
    [2523] = 30255, --	稳定恒金瞄准镜
    [2567] = 359642, --	附魔武器 - 强效精神
    [2613] = 359858, --	附魔手套 - 威胁
    [2619] = 359950, --	附魔披风 - 强效火焰抗性
    [2620] = 359949, --	附魔披风 - 强效自然抗性
    [2621] = 359847, --	附魔披风 - 狡诈
    [2650] = 27917, --	附魔护腕 - 法术能量
    [2724] = 30260, --	稳定恒金瞄准镜
    [3229] = 359685, --	附魔盾牌 - 韧性
    [3297] = 47900, --	卷轴：附魔胸甲 - 超级生命
    [3315] = 48401, --	棍子上的胡萝卜
    [3327] = 60583, --	冰虫腿甲强化片
    [3328] = 60584 --	蛛魔腿甲强化片

}

--[[

"INVTYPE_AMMO"	Ammo	0
"INVTYPE_HEAD"	Head	1
"INVTYPE_NECK"	Neck	2
"INVTYPE_SHOULDER"	Shoulder	3
"INVTYPE_BODY"	Shirt	4
"INVTYPE_CHEST"	Chest	5 胸部
"INVTYPE_ROBE"	Chest	5
"INVTYPE_WAIST"	Waist	6 腰部
"INVTYPE_LEGS"	Legs	7
"INVTYPE_FEET"	Feet	8
"INVTYPE_WRIST"	Wrist	9 手腕
"INVTYPE_HAND"	Hands	10
"INVTYPE_FINGER"	Fingers	11,12
"INVTYPE_TRINKET"	Trinkets	13,14
"INVTYPE_CLOAK"	Cloaks	15
"INVTYPE_WEAPON"	One-Hand	16,17
"INVTYPE_SHIELD"	Shield	17
"INVTYPE_2HWEAPON"	Two-Handed	16
]]
local EnchantSpellDBEx = {
    [41] = {
        INVTYPE_WRIST = 7418, --	卷轴：附魔护腕 - 初级生命
        INVTYPE_CHEST = 7420 --	卷轴：附魔胸甲 - 初级生命
    },
    [66] = {
        INVTYPE_WRIST = 7457, --	卷轴：附魔护腕 - 初级耐力
        INVTYPE_FEET = 7863, --	卷轴：附魔靴子 - 初级耐力
        INVTYPE_SHIELD = 13378 --	卷轴：附魔盾牌 - 初级耐力
    },
    [241] = {
        INVTYPE_2HWEAPON = 7745, --	卷轴：附魔双手武器 - 初级冲击
        INVTYPE_WEAPON = 13503 --	卷轴：附魔武器 - 次级攻击
    },
    [247] = {
        INVTYPE_WRIST = 7779, --	卷轴：附魔护腕 - 初级敏捷
        INVTYPE_FEET = 7867, --	卷轴：附魔靴子 - 初级敏捷
        INVTYPE_CLOAK = 13419 --	卷轴：附魔披风 - 初级敏捷
    },
    [255] = {
        INVTYPE_WRIST = 7859, --	卷轴：附魔护腕 - 次级精神
        INVTYPE_2HWEAPON = 13380, --	卷轴：附魔双手武器 - 次级精神
        INVTYPE_SHIELD = 13485, --	卷轴：附魔盾牌 - 次级精神
        INVTYPE_FEET = 13687 --	卷轴：附魔靴子 - 次级精神
    },
    [723] = {
        INVTYPE_2HWEAPON = 7793, --	卷轴：附魔双手武器 - 次级智力
        INVTYPE_WRIST = 13622 --	卷轴：附魔护腕 - 次级智力
    },
    [724] = {
        INVTYPE_WRIST = 13501, --	卷轴：附魔护腕 - 次级耐力
        INVTYPE_SHIELD = 13631, --	卷轴：附魔盾牌 - 次级耐力
        INVTYPE_FEET = 13644 --	卷轴：附魔靴子 - 次级耐力
    },
    [848] = {
        INVTYPE_SHIELD = 13464, --	卷轴：附魔盾牌 - 次级防护
        INVTYPE_CLOAK = 13635 --	卷轴：附魔披风 - 防御
    },
    [849] = {
        INVTYPE_FEET = 13637, --	卷轴：附魔靴子 - 次级敏捷
        INVTYPE_CLOAK = 13882 --	卷轴：附魔披风 - 次级敏捷
    },
    [851] = {
        INVTYPE_WRIST = 13642, --	卷轴：附魔护腕 - 精神
        INVTYPE_SHIELD = 13659, --	卷轴：附魔盾牌 - 精神
        INVTYPE_FEET = 20024 --	卷轴：附魔靴子 - 精神
    },
    [852] = {
        INVTYPE_WRIST = 13648, --	卷轴：附魔护腕 - 耐力
        INVTYPE_SHIELD = 13817, --	卷轴：附魔盾牌 - 耐力
        INVTYPE_FEET = 13836 --	卷轴：附魔靴子 - 耐力
    },
    [856] = {
        INVTYPE_WRIST = 13661, --	卷轴：附魔护腕 - 力量
        INVTYPE_HAND = 13887 --	卷轴：附魔手套 - 力量
    },
    [904] = {
        INVTYPE_HAND = 13815, --	卷轴：附魔手套 - 敏捷
        INVTYPE_FEET = 13935 --	卷轴：附魔靴子 - 敏捷
    },
    [907] = {
        INVTYPE_WRIST = 13846, --	卷轴：附魔护腕 - 强效精神
        INVTYPE_SHIELD = 13905 --	卷轴：附魔盾牌 - 强效精神
    },
    [927] = {
        INVTYPE_WRIST = 13939, --	卷轴：附魔护腕 - 强效力量
        INVTYPE_HAND = 20013 --	卷轴：附魔手套 - 强效力量
    },
    [929] = {
        INVTYPE_WRIST = 13945, --	卷轴：附魔护腕 - 强效耐力
        INVTYPE_SHIELD = 20017, --	卷轴：附魔盾牌 - 强效耐力
        INVTYPE_FEET = 20020 --	卷轴：附魔靴子 - 强效耐力
    },
    [943] = {
        INVTYPE_2HWEAPON = 13529, --	卷轴：附魔双手武器 - 次级冲击
        INVTYPE_WEAPON = 13693 --	卷轴：附魔武器 - 攻击
    },
    [963] = {
        INVTYPE_2HWEAPON = 13937, --	卷轴：附魔双手武器 - 强效冲击
        INVTYPE_WEAPON = 27967 --	附魔武器 - 特效打击
    },
    [983] = {
        INVTYPE_CLOAK = 44500, --	卷轴：附魔披风 - 超强敏捷
        INVTYPE_FEET = 44589 --	卷轴：附魔靴子 - 超强敏捷
    },
    [1147] = {
        INVTYPE_FEET = 44508, --	卷轴：附魔靴子 - 强效精神
        INVTYPE_WRIST = 44593 --	卷轴：附魔护腕 - 特效精神
    },
    [1887] = {
        INVTYPE_HAND = 20012, --	卷轴：附魔手套 - 强效敏捷
        INVTYPE_FEET = 20023 --	卷轴：附魔靴子 - 强效敏捷
    },
    [1888] = {
        INVTYPE_CLOAK = 20014, --	卷轴：附魔披风 - 强效抗性
        INVTYPE_SHIELD = 27947 --	附魔盾牌 - 抗性
    },
    [1891] = {
        INVTYPE_CHEST = 20025, --	卷轴：附魔胸甲 - 强效属性
        INVTYPE_WRIST = 27905 --	附魔护腕 - 属性
    },
    [1897] = {
        INVTYPE_2HWEAPON = 13695, --	卷轴：附魔双手武器 - 冲击
        INVTYPE_WEAPON = 20031 --	卷轴：附魔武器 - 超强打击
    },
    [1951] = {
        INVTYPE_CLOAK = 44591, --	卷轴：附魔披风 - 泰坦之纹
        INVTYPE_CHEST = 46594 --	卷轴：附魔胸甲 - 防御
    },
    [2564] = {
        INVTYPE_WEAPON = 23800, --	卷轴：附魔武器 - 敏捷
        INVTYPE_HAND = 359641 --	附魔手套 - 超强敏捷
    },
    [2648] = {
        INVTYPE_WRIST = 27906, --	附魔护腕 - 特效防御
        INVTYPE_CLOAK = 47051 --	卷轴：附魔披风 - 钢纹
    },
    [2649] = {
        INVTYPE_WRIST = 27914, --	附魔护腕 - 坚韧
        INVTYPE_FEET = 27950 --	附魔长靴 - 坚韧
    },

    [2661] = {
        INVTYPE_CHEST = 27960, -- 附魔胸甲 - 优异属性
        INVTYPE_WRIST = 44616 -- 卷轴：附魔护腕 - 强效属性
    },
    [3222] = {
        INVTYPE_WEAPON = 42620, --	附魔武器 - 强效敏捷
        INVTYPE_HAND = 44529 --	卷轴：附魔手套 - 特效敏捷
    },
    [3231] = {
        INVTYPE_HAND = 44484, --	卷轴：附魔手套 - 精准
        INVTYPE_WRIST = 44598 --	卷轴：附魔护腕 - 精准
    }
}
function lib:GetEnchantSpellID(ItemLink)
    local enchant = tonumber(string.match(ItemLink, "item:%d+:(%d+):"))

    local itemEquip = select(9, GetItemInfo(ItemLink)) -- 获取 装备类型
    if (enchant and EnchantSpellDBEx[enchant]) then -- 有附魔 并且主目录不存在
        local enchantItemID = EnchantSpellDBEx[enchant][itemEquip] -- 副目录校验
        if (enchantItemID ~= nil) then
            return EnchantSpellDBEx[enchant][itemEquip], enchant
        end
    end
    if (enchant and EnchantSpellDB[enchant]) then
        return EnchantSpellDB[enchant], enchant
    end
    return nil, enchant
end

function lib:GetEnchantItemID(ItemLink)
    local enchant = tonumber(string.match(ItemLink, "item:%d+:(%d+):"))
    if (enchant and EnchantItemDB[enchant]) then
        return EnchantItemDB[enchant], enchant
    end
    return nil, enchant
end
