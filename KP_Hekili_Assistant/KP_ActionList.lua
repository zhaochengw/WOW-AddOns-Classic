-- ======================== KP游戏版本检测 =======================
_KP_GAME_VERSION = {}
_KP_GAME_VERSION.major, _KP_GAME_VERSION.minor, _KP_GAME_VERSION.build = GetBuildInfo()
_KP_GAME_VERSION.isWLK = (_KP_GAME_VERSION.major == 3)
_KP_GAME_VERSION.isMOP = (_KP_GAME_VERSION.major == 5)

-- ======================== KP专精名称翻译 =======================
_KP_SpecializationNames = {
    -- 德鲁伊
    DRUID = {
        ["Balance"] = "平衡",
        ["Feral"] = "野性",
        ["Restoration"] = "恢复"
    }
}

-- ======================== KP全职业Hekili助手核心技能列表 =======================
-- 全版本支持 ：不再区分WLK、MOP、以及其它版本， ClassActionLists 包含所有版本的技能.
-- 模块化设计 ：基础技能列表独立存储在KP_ActionList.lua文件中.
-- 持久化保存 ：动态添加的技能不会在重新加载或重新登录后丢失.
-- 同一个职业的不同角色共享同一个技能列表，需要根据HEKILI的技能推荐手打一遍让插件自动学习技能.
-- 自动学习 ：插件会自动学习新技能，第一次遇到新技能时会自动添加到KP_Hekili_Assistant_DB数据文件中。
-- 自动攻击{6603, "macro"},永远位于技能列表的最后一项.

local ClassActionLists = {
    -- 德鲁伊 - 按专精分类
    DRUID = {
        -- 平衡德鲁伊
        Balance = {
            {48463, "spell"}, {48465, "spell"}, {48461, "spell"}, {48468, "spell"},
            {33831, "spell"}, {53201, "spell"}, {61384, "spell"}, {48469, "spell"},
            {53307, "spell"}, {48577, "spell"}, {16979, "spell"}, {29166, "spell"},
            {10, "item"}, {6603, "macro"},
        },
        -- 野性德鲁伊
        Feral = {
            {49376, "spell"}, {768, "spell"}, {9434, "spell"}, {783, "spell"},
            {52610, "spell"}, {48572, "spell"}, {48574, "spell"}, {49800, "spell"},
            {48577, "spell"}, {16857, "spell"}, {62078, "spell"}, {48443, "spell"},
            {50334, "spell"}, {50213, "spell"}, {48566, "spell"}, {49376, "spell"},
            {48564, "spell"}, {61336, "spell"}, {22812, "spell"}, {16979, "spell"},
            {48568, "spell"}, {48480, "spell"}, {48562, "spell"}, {16979, "spell"},
            {10, "item"}, {6603, "macro"},
        },
        -- 恢复德鲁伊
        Restoration = {
            {8983, "spell"}, {48443, "spell"}, {48442, "spell"}, {8936, "spell"},
            {26980, "spell"}, {48441, "spell"}, {48378, "spell"}, {48577, "spell"},
            {29166, "spell"}, {16979, "spell"}, {770, "spell"}, {10, "item"},
            {6603, "macro"},
        }
    },
    -- 德鲁伊默认列表（向后兼容）
    DRUID_DEFAULT = {
        {49376, "spell"}, {768, "spell"}, {9434, "spell"}, {783, "spell"}, {53307, "spell"}, {48470, "spell"},
        {48469, "spell"}, {48477, "spell"}, {50763, "spell"}, {48505, "spell"}, {48568, "spell"}, {53307, "spell"},
        {48574, "spell"}, {48578, "spell"}, {29166, "spell"}, {48507, "spell"}, {50334, "spell"},
        {40120, "spell"}, {33943, "spell"}, {16857, "spell"}, {49800, "spell"}, {52610, "spell"},
        {48566, "spell"}, {50213, "spell"}, {62078, "spell"}, {48572, "spell"}, {5229, "spell"},
        {48564, "spell"}, {48568, "spell"}, {48560, "spell"}, {48562, "spell"}, {48480, "spell"},
        {50259, "spell"}, {5209, "spell"}, {16979, "spell"}, {8983, "spell"}, {48443, "spell"},
        {48442, "spell"}, {8936, "spell"}, {26980, "spell"}, {48441, "spell"}, {48378, "spell"},
        {6795, "spell"}, {24858, "spell"}, {770, "spell"}, {48463, "spell"}, {48465, "spell"},
        {48461, "spell"}, {48468, "spell"}, {33831, "spell"}, {53201, "spell"}, {61384, "spell"},
        {48469, "spell"}, {48577, "spell"}, {10, "item"}, {6603, "macro"},
    },
    -- 猎人
    HUNTER = {
        {53224, "spell"}, {34026, "spell"}, {56641, "spell"}, {53301, "spell"},
        {53290, "spell"}, {53238, "spell"}, {53249, "spell"}, {53480, "spell"}, {54216, "spell"},
        {53271, "spell"}, {53228, "spell"}, {53351, "spell"}, {53341, "spell"}, {53239, "spell"},
        {53209, "spell"}, {53270, "spell"}, {53210, "spell"}, {53220, "spell"}, {53340, "spell"},
        {53237, "spell"}, {53354, "spell"}, {10, "item"}, {6603, "macro"},
    },
    -- 萨满
    SHAMAN = {
        {51490, "spell"}, {49271, "spell"}, {49238, "spell"}, {49233, "spell"},
        {49243, "spell"}, {51491, "spell"}, {51485, "spell"}, {51531, "spell"}, {51505, "spell"},
        {51530, "spell"}, {30809, "spell"}, {30706, "spell"}, {8042, "spell"}, {324, "spell"},
        {49206, "spell"}, {17364, "spell"}, {10, "item"}, {6603, "macro"},
    },
    -- 圣骑士
    PALADIN = {
        {25780, "spell"}, {35395, "spell"}, {53600, "spell"}, {48819, "spell"},
        {31789, "spell"}, {53601, "spell"}, {53622, "spell"}, {642, "spell"}, {62124, "spell"},
        {48788, "spell"}, {31884, "spell"}, {35395, "spell"}, {53385, "spell"}, {53408, "spell"},
        {48819, "spell"}, {48801, "spell"}, {48932, "spell"}, {20375, "spell"}, {20271, "spell"},
        {48817, "spell"}, {10, "item"}, {6603, "macro"},
    },
    -- 牧师
    PRIEST = {
        {48073, "spell"}, {48074, "spell"}, {48161, "spell"}, {48162, "spell"},
        {48160, "spell"}, {48125, "spell"}, {48156, "spell"}, {48127, "spell"}, {15473, "spell"},
        {15286, "spell"}, {48158, "spell"}, {48300, "spell"}, {14751, "spell"}, {48168, "spell"},
        {10890, "spell"}, {34433, "spell"}, {586, "spell"}, {47585, "spell"},{53023, "spell"},
        {10, "item"}, {6603, "macro"},
    },
    -- 术士
    WARLOCK = {
        {47241, "spell"}, {48181, "spell"}, {47669, "spell"}, {47960, "spell"},
        {47961, "spell"}, {48505, "spell"}, {47914, "spell"}, {47986, "spell"}, {48018, "spell"},
        {47930, "spell"}, {47897, "spell"}, {47670, "spell"}, {47686, "spell"}, {47667, "spell"},
        {47913, "spell"}, {47893, "spell"}, {48180, "spell"}, {48183, "spell"}, {48438, "spell"},
        {10, "item"}, {6603, "macro"},
    },
    -- 法师
    MAGE = {
        {12042, "spell"}, {44614, "spell"}, {47610, "spell"}, {44620, "spell"}, {44572, "spell"},
        {44670, "spell"}, {44635, "spell"}, {44544, "spell"}, {55215, "spell"}, {44654, "spell"},
        {44685, "spell"}, {55316, "spell"}, {55300, "spell"}, {55347, "spell"}, {55362, "spell"},
        {55375, "spell"}, {11426, "spell"}, {55399, "spell"}, {55439, "spell"}, {55360, "spell"},
        {55342, "spell"}, {55368, "spell"}, {55378, "spell"}, {55384, "spell"}, {55396, "spell"},
        {11129, "spell"}, {55428, "spell"}, {10, "item"}, {6603, "macro"},
    },
    -- 盗贼
    ROGUE = {
        {51690, "spell"}, {13877, "spell"}, {14177, "spell"}, {1776, "spell"}, {14183, "spell"},
        {51625, "spell"}, {3408, "spell"}, {51723, "spell"}, {2818, "spell"}, {8679, "spell"},
        {51698, "spell"}, {31224, "spell"}, {51610, "spell"}, {185567, "spell"}, {13750, "spell"},
        {49016, "spell"}, {13878, "spell"}, {51722, "spell"}, {6774, "spell"}, {8647, "spell"},
        {48691, "spell"}, {48688, "spell"}, {48660, "spell"}, {48672, "spell"}, {57934, "spell"},
        {57993, "spell"}, {11305, "spell"}, {1282538, "spell"}, {26669, "spell"}, {36554, "spell"},
        {14185, "spell"}, {5938, "spell"}, {51724, "spell"}, {14278, "spell"}, {51723, "spell"},
        {1784, "spell"}, {51713, "spell"}, {31224, "spell"}, {48691, "spell"}, {1284409, "spell"},
        {48659, "spell"}, {8643, "spell"}, {1284398, "spell"}, {1766, "spell"}, {36554, "spell"},
        {48676, "spell"}, {48668, "spell"},{10, "item"}, {6603, "macro"},
    },
    -- 死亡骑士
    DEATHKNIGHT = {
        {49909, "spell"}, {48792, "spell"}, {47528, "spell"}, {57623, "spell"},
        {56815, "spell"}, {47568, "spell"}, {46584, "spell"}, {49938, "spell"}, {42650, "spell"},
        {49576, "spell"}, {49895, "spell"}, {49924, "spell"}, {49921, "spell"}, {48707, "spell"},
        {50842, "spell"}, {48982, "spell"}, {55233, "spell"}, {49941, "spell"}, {49930, "spell"},
        {45529, "spell"}, {51425, "spell"}, {10, "item"}, {6603, "macro"},
    },
    -- 战士
    WARRIOR = {
        {48920, "spell"}, {47475, "spell"}, {47482, "spell"}, {47427, "spell"},
        {47428, "spell"}, {47430, "spell"}, {47436, "spell"}, {47484, "spell"}, {47487, "spell"},
        {47498, "spell"}, {48921, "spell"}, {47479, "spell"}, {47483, "spell"}, {47490, "spell"},
        {47492, "spell"}, {47493, "spell"}, {47494, "spell"}, {47497, "spell"}, {48949, "spell"},
        {47400, "spell"}, {47429, "spell"}, {47478, "spell"}, {47568, "spell"}, {47536, "spell"},
        {47481, "spell"}, {47517, "spell"}, {10, "item"}, {6603, "macro"},
    },
    --  武僧
    MONK = {
        {107428, "spell"}, {101546, "spell"}, {100784, "spell"}, {100780, "spell"},
        {100788, "spell"}, {102543, "spell"}, {106113, "spell"}, {115399, "spell"}, {115450, "spell"},
        {109132, "spell"}, {116849, "spell"}, {115175, "spell"}, {101643, "spell"}, {113656, "spell"},
        {115288, "spell"}, {100863, "spell"}, {119611, "spell"}, {122278, "spell"}, {10, "item"}, {6603, "macro"},
    }
}

_KP_ClassActionLists = ClassActionLists