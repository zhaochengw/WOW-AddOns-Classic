-- Config.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 7:22:32 PM
--
----LUA
local ipairs = ipairs
local tinsert = table.insert
-- @build>2@
local format = string.format
-- @end-build>2@

---- WOW
local GetSpellInfo = GetSpellInfo

---@class ns
local ns = select(2, ...)
local L = ns.L
local C = ns.C

local function Rule(name, icon, rule, c)
    local children
    if c then
        children = {}
        local exists = {}
        for i, v in ipairs(c) do
            local isAdv = ns.IsAdvanceRule(v)
            if isAdv and (not v.rule or not exists[v.rule]) then
                tinsert(children, v)
                if v.rule then
                    exists[v.rule] = true
                end
            end
            if not isAdv then
                tinsert(children, v)
            end
        end
    end
    return {rule = rule, comment = name, icon = icon, children = children}
end

local function Group(name, icon, children)
    return Rule(name, icon, nil, children)
end

local function Type(type, icon, children)
    local name = C.Item.GetItemClassInfo(type)
    return Rule(name, icon, 'class:' .. name, children)
end

local function SubType(type, subType, icon, children)
    local name = C.Item.GetItemSubClassInfo(type, subType)
    return Rule(name, icon, 'class:' .. name, children)
end

local function Weapon(subType, icon, children)
    return SubType(Enum.ItemClass.Weapon, subType, icon, children)
end

-- @build>2@
local function Misc(subType, icon, children)
    return SubType(Enum.ItemClass.Miscellaneous, subType, icon, children)
end

local function Trade(subType, icon, children)
    return SubType(Enum.ItemClass.Tradegoods, subType, icon, children)
end

local function Consumable(subType, icon, children)
    return SubType(Enum.ItemClass.Consumable, subType, icon, children)
end
-- @end-build>2@

local function Slot(name, icon, children)
    name = _G[name] or name
    return Rule(name, icon, 'inv:' .. name, children)
end

--[[@maybe@
maybe {L['COMMENT_CLASS'], L['KEYWORD_CLASS']}
--@end-maybe@]]

local function TipLocale(key, icon, children)
    return Rule(L['COMMENT_' .. key], icon, 'tip:' .. L['KEYWORD_' .. key], children)
end

local function Tip(tip, icon, children)
    return Rule(tip, icon, 'tip:' .. tip, children)
end

--[=[@build<2@
local function Tag(key, icon, children)
    local l = L['ITEM_TAG: ' .. key]
    return Rule(l, icon, 'tag:' .. l, children)
end
--@end-build<2@]=]

local function Spell(id, icon, children)
    local spellName = GetSpellInfo(id)
    return Rule(spellName, icon, 'spell:' .. spellName, children)
end

-- @build>2@
local function SpellId(id, icon, name, ...)
    local children
    if type(name) == 'table' then
        name, children = nil, name
    else
        children = ...
    end

    local spellName = GetSpellInfo(id)
    return Rule(spellName .. ' - ' .. (name or id), icon, 'spell:' .. id, children)
end

local function TypeOrTag(type, subType, icon, children)
    local name = C.Item.GetItemSubClassInfo(type, subType)
    return Rule(name, icon, format('class:%s | tag:%s', name, name), children)
end
-- @end-build>2@

local CONSUMABLE = C.Item.GetItemClassInfo(Enum.ItemClass.Consumable) -- 消耗品
local QUEST = C.Item.GetItemClassInfo(Enum.ItemClass.Questitem) -- 任务
local MISC = C.Item.GetItemClassInfo(Enum.ItemClass.Miscellaneous) -- 其它
-- local TRADEGOODS = C.Item.GetItemClassInfo(Enum.ItemClass.Tradegoods) -- 商品
-- local MOUNT = C.Item.GetItemSubClassInfo(Enum.ItemClass.Miscellaneous, Enum.ItemMiscellaneousSubclass.Mount)

ns.DEFAULT_SORTING_RULES = {
    --[=[@build<2@
    HEARTHSTONE_ITEM_ID, -- 炉石
    --@end-build<2@]=]
    -- @build>2@
    Group(L['Transporter'], 134414, {
        HEARTHSTONE_ITEM_ID, -- 炉石
        44315, -- 召回卷轴 III
        44314, -- 召回卷轴 II
        37118, -- 召回卷轴 I
        37863, -- 烈酒的遥控器
    }), --
    Group(L['Usuable'], 294476, {
        -- @build>3@
        23821, -- 气阀微粒提取器
        49040, -- 基维斯
        40769, -- 废物贩卖机器人制造器
        -- @end-build>3@
        34113, -- 战地修理机器人110G
        18232, -- 修理机器人74A型
    }), --
    -- @end-build>2@
    --[=[@build<2@
    Tag('Mount', 132261), -- 坐骑
    Tag('Pet', 132598), -- 宠物
    --@end-build<2@]=]
    -- @build>2@
    TypeOrTag(Enum.ItemClass.Miscellaneous, Enum.ItemMiscellaneousSubclass.Mount, 132261), -- 坐骑
    TypeOrTag(Enum.ItemClass.Miscellaneous, Enum.ItemMiscellaneousSubclass.CompanionPet, 132598), -- 宠物
    -- @end-build>2@
    Group(L['Tools'], 134065, {
        5060, -- 潜行者工具
        -- @build>3@
        46978, -- 大地之环图腾
        -- @end-build>3@
        5175, -- 大地图腾
        5177, -- 水之图腾
        5176, -- 火焰图腾
        5178, -- 空气图腾
        9149, -- 点金石
        -- @build>3@
        40772, -- 侏儒军刀
        44452, -- 符文泰坦神铁棒
        -- @end-build>3@
        -- @build>2@
        22463, -- 符文恒金棒
        22462, -- 符文精金棒
        22461, -- 符文魔铁棒
        -- @end-build>2@
        16207, -- 符文奥金棒
        11145, -- 符文真银棒
        11130, -- 符文金棒
        6339, -- 符文银棒
        6218, -- 符文铜棒
        7005, -- 剥皮刀
        2901, -- 矿工锄
        5956, -- 铁匠锤
        6219, -- 扳手
        10498, -- 侏儒微调器
        19727, -- 血镰刀
        -- @build>2@
        20815, -- 珠宝制作工具
        -- @end-build>2@
        -- @build>3@
        39505, -- 学者的书写工具
        -- @end-build>3@
        --[==[@build<3@
        4471, -- 燧石和火绒
        --@end-build<3@]==]
        Weapon(Enum.ItemWeaponSubclass.Fishingpole, 132932), -- 鱼竿
    }), --
    Rule(EQUIPSET_EQUIP, 132722, 'equip', {
        Rule('Set', 132722, 'bset'), --
        Group('非套装', 132722, {

            Slot('INVTYPE_2HWEAPON', 135324), -- 双手
            Slot('INVTYPE_WEAPONMAINHAND', 133045), -- 主手
            Slot('INVTYPE_WEAPON', 135641), -- 单手
            Slot('INVTYPE_SHIELD', 134955), -- 副手盾
            Slot('INVTYPE_WEAPONOFFHAND', 134955), -- 副手
            Slot('INVTYPE_HOLDABLE', 134333), -- 副手物品
            Slot('INVTYPE_RANGED', 135498), -- 远程
            Slot('INVTYPE_RANGEDRIGHT', 135468), -- 远程
            Slot('INVTYPE_THROWN', 132394), -- 投掷武器
            -- Weapon(LE_ITEM_WEAPON_GUNS, 135610), -- 枪
            -- Weapon(LE_ITEM_WEAPON_CROSSBOW, 135533), -- 弩
            -- Weapon(LE_ITEM_WEAPON_THROWN, 135427), -- 投掷武器
            -- Weapon(LE_ITEM_WEAPON_WAND, 135473), -- 魔杖
            Slot('INVTYPE_RELIC', 134915), -- 圣物
            Slot('INVTYPE_HEAD', 133136), -- 头部
            Slot('INVTYPE_NECK', 133294), -- 颈部
            Slot('INVTYPE_SHOULDER', 135033), -- 肩部
            Slot('INVTYPE_CLOAK', 133768), -- 背部
            Slot('INVTYPE_CHEST', 132644), -- 胸部
            Slot('INVTYPE_ROBE', 132644), -- 胸部
            Slot('INVTYPE_WRIST', 132608), -- 手腕
            Slot('INVTYPE_HAND', 132948), -- 手
            Slot('INVTYPE_WAIST', 132511), -- 腰部
            Slot('INVTYPE_LEGS', 134588), -- 腿部
            Slot('INVTYPE_FEET', 132541), -- 脚
            Slot('INVTYPE_FINGER', 133345), -- 手指
            Slot('INVTYPE_TRINKET', 134010), -- 饰品
            Slot('INVTYPE_BODY', 135022), -- 衬衣
            Slot('INVTYPE_TABARD', 135026), -- 战袍
        }),
    }), -- 装备
    Type(Enum.ItemClass.Projectile, 132382), -- 弹药
    Type(Enum.ItemClass.Container, 133652), -- 容器
    Type(Enum.ItemClass.Quiver, 134407), -- 箭袋
    Type(Enum.ItemClass.Recipe, 134939), -- 配方
    Rule(CONSUMABLE, 134829, 'class:' .. CONSUMABLE .. ' & tip:!' .. QUEST .. ' & spell', {
        --[=[@build<2@
        TipLocale('CLASS', 132273), -- 职业
        Spell(746, 133685), -- 急救
        Spell(433, 133945), -- 进食
        Spell(430, 132794), -- 喝水
        Spell(439, 134830), -- 治疗药水
        Spell(438, 134851), -- 法力药水
        --@end-build<2@]=]
        -- @build>2@
        Consumable(7, 133692), -- 绷带
        Consumable(3, 134742), -- 合剂
        Consumable(2, 134773), -- 药剂
        Spell(439, 134830), -- 治疗药水
        Spell(438, 134851), -- 法力药水
        Consumable(1, 134729), -- 药水
        Consumable(4, 134937), -- 卷轴
        Consumable(5, 133953, {
            43015, -- 鱼
            34753, -- 猪
            Spell(44166, 134051), -- 恢复体能
            SpellId(33262, 134034, SPELL_STAT2_NAME), -- 敏捷
            SpellId(33255, 134016, SPELL_STAT1_NAME), -- 力量
            SpellId(33260, 134009, ATTACK_POWER_TOOLTIP), -- AP
            SpellId(33264, 134044, STAT_SPELLDAMAGE), -- 法伤
            SpellId(43763, 134040, STAT_HIT_CHANCE), -- 命中
            SpellId(33269, 134904, STAT_SPELLHEALING), -- 治疗
            SpellId(43706, 134019, SPELL_CRIT_CHANCE), -- 法暴
            SpellId(33266, 134035, MANA_REGEN), -- 5回
            SpellId(33258, 133902, SPELL_STAT3_NAME), -- 耐力
            SpellId(35271, 134004, SPELL_STAT3_NAME), -- 耐力
            SpellId(33253, 134030, SPELL_STAT3_NAME), -- 耐力
            SpellId(45618, 133915, STAT_CATEGORY_RESISTANCE), -- 抗性
            Spell(433, 133945), -- 进食
            Spell(430, 132794), -- 喝水
        }), -- 食物和饮料
        Consumable(6, 133604), -- 物品强化
        Group(GetSpellInfo(7620), 136245, {34861, 6533, 6532, 6530, 6529}),
        -- @end-build>2@
    }), -- 消耗品
    Type(Enum.ItemClass.Tradegoods, 132905, {
        TipLocale('CLASS', 132273), -- 职业
        --[=[@build<2@
        Tag('Cloth', 132903), -- 布
        Tag('Leather', 134256), -- 皮
        Tag('Metal & Stone', 133217), -- 金属和矿石
        Tag('Cooking', 134027), -- 烹饪
        Tag('Herb', 134215), -- 草药
        Tag('Elemental', 135819), -- 元素
        Tag('Enchanting', 132864), -- 附魔
        --@end-build<2@]=]
        -- @build>2@
        Trade(2, 133715), -- 爆炸物
        Trade(3, 134441), -- 装置
        Trade(1, 133025), -- 零件
        Trade(5, 132903), -- 布料
        Trade(6, 134256), -- 皮革
        Trade(7, 133217), -- 金属和矿石
        Trade(8, 134027), -- 肉类
        Trade(9, 134215), -- 草药
        Trade(10, 135819), -- 元素
        Trade(12, 132864), -- 附魔
        Trade(4, 134379), -- 珠宝加工
        Trade(13, 132850), -- 原料
        -- @end-build>2@
    }), -- 商品
    -- @build>2@
    Type(Enum.ItemClass.Gem, 133272, {
        SubType(Enum.ItemClass.Gem, 0, 134083), -- 红
        SubType(Enum.ItemClass.Gem, 2, 134114), -- 黄
        SubType(Enum.ItemClass.Gem, 1, 134080), -- 蓝
        SubType(Enum.ItemClass.Gem, 5, 134111), -- 橙
        SubType(Enum.ItemClass.Gem, 4, 134093), -- 绿
        SubType(Enum.ItemClass.Gem, 3, 134103), -- 紫
        SubType(Enum.ItemClass.Gem, 8, 132886), -- 棱彩
        SubType(Enum.ItemClass.Gem, 6, 134098), -- 多彩
        SubType(Enum.ItemClass.Gem, 7, 134087), -- 简易
    }), -- 珠宝
    -- @end-build>2@
    Rule(MISC, 134237, 'class:!' .. QUEST .. ' & tip:!' .. QUEST, {
        -- @build>2@
        Misc(Enum.ItemClass.Reagent, 133587), -- 材料
        -- @end-build>2@
        Type(Enum.ItemClass.Consumable, 134420), -- 消耗品
        Type(Enum.ItemClass.Miscellaneous, 134400), -- 其它
        Type(Enum.ItemClass.Key, 134237), -- 钥匙
    }), --
    Rule(QUEST, 133469, 'class:' .. QUEST .. ' | tip:' .. QUEST, {
        Tip(ITEM_STARTS_QUEST, 132836), -- 接任务
        Rule(nil, 133942, 'spell'), --
    }), -- 任务
}

ns.DEFAULT_SAVING_RULES = { --
    -- @build>2@
    16885, -- 重垃圾箱
    Trade(1, 133025), -- 零件
    Trade(5, 132903), -- 布料
    Trade(6, 134256), -- 皮革
    Trade(7, 133217), -- 金属和矿石
    Trade(8, 134027), -- 肉类
    Trade(9, 134215), -- 草药
    Trade(10, 135819), -- 元素
    Trade(12, 132864), -- 附魔
    Trade(4, 134379), -- 珠宝加工
    Trade(13, 132850), -- 原料
    Type(Enum.ItemClass.Gem, 133272),
    -- @end-build>2@
}
