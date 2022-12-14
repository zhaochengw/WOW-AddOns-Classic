-- Config.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/31/2019, 7:22:32 PM
local ipairs = ipairs
local tinsert = table.insert

---@type ns
local ns = select(2, ...)
---@type L
local L = ns.L

---- WOW
local GetSpellInfo = GetSpellInfo
local GetItemClassInfo = GetItemClassInfo
local GetItemSubClassInfo = GetItemSubClassInfo

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
    local name = GetItemClassInfo(type)
    return Rule(name, icon, 'type:' .. name, children)
end

local function SubType(type, subType, icon, children)
    local name = GetItemSubClassInfo(type, subType)
    return Rule(name, icon, 'type:' .. name, children)
end

local function Weapon(subType, icon, children)
    return SubType(LE_ITEM_CLASS_WEAPON, subType, icon, children)
end

local function Misc(subType, icon, children)
    return SubType(LE_ITEM_CLASS_MISCELLANEOUS, subType, icon, children)
end

local function Trade(subType, icon, children)
    return SubType(LE_ITEM_CLASS_TRADEGOODS, subType, icon, children)
end

local function Consumable(subType, icon, children)
    return SubType(LE_ITEM_CLASS_CONSUMABLE, subType, icon, children)
end

local function Slot(name, icon, children)
    name = _G[name] or name
    return Rule(name, icon, 'inv:' .. name, children)
end

local function TipLocale(key, icon, children)
    return Rule(L['COMMENT_' .. key], icon, 'tip:' .. L['KEYWORD_' .. key], children)
end

local function Tip(tip, icon, children)
    return Rule(tip, icon, 'tip:' .. tip, children)
end

local function Tag(key, icon, children)
    local l = L['ITEM_TAG: ' .. key]
    return Rule(l, icon, 'tag:' .. l, children)
end

local function Spell(id, icon, children)
    local spellName = GetSpellInfo(id)
    return Rule(spellName, icon, 'spell:' .. spellName, children)
end

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
    local name = GetItemSubClassInfo(type, subType)
    return Rule(name, icon, format('type:%s | tag:%s', name, name), children)
end

local CONSUMABLE = GetItemClassInfo(LE_ITEM_CLASS_CONSUMABLE) -- ?????????
local QUEST = GetItemClassInfo(LE_ITEM_CLASS_QUESTITEM) -- ??????
local MISC = GetItemClassInfo(LE_ITEM_CLASS_MISCELLANEOUS) -- ??????
local TRADEGOODS = GetItemClassInfo(LE_ITEM_CLASS_TRADEGOODS) -- ??????
local MOUNT = GetItemSubClassInfo(LE_ITEM_CLASS_MISCELLANEOUS, LE_ITEM_MISCELLANEOUS_MOUNT)

ns.DEFAULT_SORTING_RULES = {
    --[=[@build<2@
    HEARTHSTONE_ITEM_ID, -- ??????
    --@end-build<2@]=]
    -- @build>2@
    Group(L['Transporter'], 134414, {
        HEARTHSTONE_ITEM_ID, -- ??????
        184871, -- ????????????
        44315, -- ???????????? III
        44314, -- ???????????? II
        37118, -- ???????????? I
        -- @build>3@
        48933, -- ???????????????????????????
        -- @end-build>3@
        30544, -- ??????????????????????????????????????????
        30542, -- ??????????????? - 52???
        18986, -- ???????????????????????????
        18984, -- ??????????????? - ?????????
        37863, -- ??????????????????
    }), --
    Group(L['Usuable'], 294476, {
        -- @build>3@
        23821, -- ?????????????????????
        40768, -- ????????????
        49040, -- ?????????
        40769, -- ??????????????????????????????
        -- @end-build>3@
        34113, -- ?????????????????????110G
        18232, -- ???????????????74A???
    }), --
    -- @end-build>2@
    --[=[@build<2@
    Tag('Mount', 132261), -- ??????
    Tag('Pet', 132598), -- ??????
    --@end-build<2@]=]
    -- @build>2@
    TypeOrTag(LE_ITEM_CLASS_MISCELLANEOUS, LE_ITEM_MISCELLANEOUS_MOUNT, 132261), -- ??????
    TypeOrTag(LE_ITEM_CLASS_MISCELLANEOUS, LE_ITEM_MISCELLANEOUS_COMPANION_PET, 132598), -- ??????
    -- @end-build>2@
    Group(L['Tools'], 134065, {
        5060, -- ???????????????
        -- @build>3@
        46978, -- ??????????????????
        -- @end-build>3@
        5175, -- ????????????
        5177, -- ????????????
        5176, -- ????????????
        5178, -- ????????????
        9149, -- ?????????
        -- @build>3@
        40772, -- ????????????
        44452, -- ?????????????????????
        -- @end-build>3@
        -- @build>2@
        22463, -- ???????????????
        22462, -- ???????????????
        22461, -- ???????????????
        -- @end-build>2@
        16207, -- ???????????????
        11145, -- ???????????????
        11130, -- ????????????
        6339, -- ????????????
        6218, -- ????????????
        7005, -- ?????????
        2901, -- ?????????
        5956, -- ?????????
        6219, -- ??????
        10498, -- ???????????????
        19727, -- ?????????
        -- @build>2@
        20815, -- ??????????????????
        -- @end-build>2@
        -- @build>3@
        39505, -- ?????????????????????
        -- @end-build>3@
        --[=[@build<3@
        4471, -- ???????????????
        --@end-build<3@]=]
        Weapon(LE_ITEM_WEAPON_FISHINGPOLE, 132932), -- ??????
    }), --
    Rule(EQUIPSET_EQUIP, 132722, 'equip', {
        Slot('INVTYPE_2HWEAPON', 135324), -- ??????
        Slot('INVTYPE_WEAPONMAINHAND', 133045), -- ??????
        Slot('INVTYPE_WEAPON', 135641), -- ??????
        Slot('INVTYPE_SHIELD', 134955), -- ?????????
        Slot('INVTYPE_WEAPONOFFHAND', 134955), -- ??????
        Slot('INVTYPE_HOLDABLE', 134333), -- ????????????
        Slot('INVTYPE_RANGED', 135498), -- ??????
        Slot('INVTYPE_RANGEDRIGHT', 135468), -- ??????
        Slot('INVTYPE_THROWN', 132394), -- ????????????
        -- Weapon(LE_ITEM_WEAPON_GUNS, 135610), -- ???
        -- Weapon(LE_ITEM_WEAPON_CROSSBOW, 135533), -- ???
        -- Weapon(LE_ITEM_WEAPON_THROWN, 135427), -- ????????????
        -- Weapon(LE_ITEM_WEAPON_WAND, 135473), -- ??????
        Slot('INVTYPE_RELIC', 134915), -- ??????
        Slot('INVTYPE_HEAD', 133136), -- ??????
        Slot('INVTYPE_NECK', 133294), -- ??????
        Slot('INVTYPE_SHOULDER', 135033), -- ??????
        Slot('INVTYPE_CLOAK', 133768), -- ??????
        Slot('INVTYPE_CHEST', 132644), -- ??????
        Slot('INVTYPE_ROBE', 132644), -- ??????
        Slot('INVTYPE_WRIST', 132608), -- ??????
        Slot('INVTYPE_HAND', 132948), -- ???
        Slot('INVTYPE_WAIST', 132511), -- ??????
        Slot('INVTYPE_LEGS', 134588), -- ??????
        Slot('INVTYPE_FEET', 132541), -- ???
        Slot('INVTYPE_FINGER', 133345), -- ??????
        Slot('INVTYPE_TRINKET', 134010), -- ??????
        Slot('INVTYPE_BODY', 135022), -- ??????
        Slot('INVTYPE_TABARD', 135026), -- ??????
    }), -- ??????
    Type(LE_ITEM_CLASS_PROJECTILE, 132382), -- ??????
    Type(LE_ITEM_CLASS_CONTAINER, 133652), -- ??????
    Type(LE_ITEM_CLASS_QUIVER, 134407), -- ??????
    Type(LE_ITEM_CLASS_RECIPE, 134939), -- ??????
    Rule(CONSUMABLE, 134829, 'type:' .. CONSUMABLE .. ' & tip:!' .. QUEST .. ' & spell', {
        --[=[@build<2@
        TipLocale('CLASS', 132273), -- ??????
        Spell(746, 133685), -- ??????
        Spell(433, 133945), -- ??????
        Spell(430, 132794), -- ??????
        Spell(439, 134830), -- ????????????
        Spell(438, 134851), -- ????????????
        --@end-build<2@]=]
        -- @build>2@
        Consumable(7, 133692), -- ??????
        Consumable(3, 134742), -- ??????
        Consumable(2, 134773), -- ??????
        Spell(439, 134830), -- ????????????
        Spell(438, 134851), -- ????????????
        Consumable(1, 134729), -- ??????
        Consumable(4, 134937), -- ??????
        Consumable(5, 133953, {
            43015, -- ???
            34753, -- ???
            Spell(44166, 134051), -- ????????????
            SpellId(33262, 134034, SPELL_STAT2_NAME), -- ??????
            SpellId(33255, 134016, SPELL_STAT1_NAME), -- ??????
            SpellId(33260, 134009, ATTACK_POWER_TOOLTIP), -- AP
            SpellId(33264, 134044, STAT_SPELLDAMAGE), -- ??????
            SpellId(43763, 134040, STAT_HIT_CHANCE), -- ??????
            SpellId(33269, 134904, STAT_SPELLHEALING), -- ??????
            SpellId(43706, 134019, SPELL_CRIT_CHANCE), -- ??????
            SpellId(33266, 134035, MANA_REGEN), -- 5???
            SpellId(33258, 133902, SPELL_STAT3_NAME), -- ??????
            SpellId(35271, 134004, SPELL_STAT3_NAME), -- ??????
            SpellId(33253, 134030, SPELL_STAT3_NAME), -- ??????
            SpellId(45618, 133915, STAT_CATEGORY_RESISTANCE), -- ??????
            Spell(433, 133945), -- ??????
            Spell(430, 132794), -- ??????
        }), -- ???????????????
        Consumable(6, 133604), -- ????????????
        Group(GetSpellInfo(7620), 136245, {34861, 6533, 6532, 6530, 6529}),
        -- @end-build>2@
    }), -- ?????????
    Type(LE_ITEM_CLASS_TRADEGOODS, 132905, {
        TipLocale('CLASS', 132273), -- ??????
        --[=[@build<2@
        Tag('Cloth', 132903), -- ???
        Tag('Leather', 134256), -- ???
        Tag('Metal & Stone', 133217), -- ???????????????
        Tag('Cooking', 134027), -- ??????
        Tag('Herb', 134215), -- ??????
        Tag('Elemental', 135819), -- ??????
        Tag('Enchanting', 132864), -- ??????
        --@end-build<2@]=]
        -- @build>2@
        Trade(2, 133715), -- ?????????
        Trade(3, 134441), -- ??????
        Trade(1, 133025), -- ??????
        Trade(5, 132903), -- ??????
        Trade(6, 134256), -- ??????
        Trade(7, 133217), -- ???????????????
        Trade(8, 134027), -- ??????
        Trade(9, 134215), -- ??????
        Trade(10, 135819), -- ??????
        Trade(12, 132864), -- ??????
        Trade(4, 134379), -- ????????????
        Trade(13, 132850), -- ??????
        -- @end-build>2@
    }), -- ??????
    -- @build>2@
    Type(LE_ITEM_CLASS_GEM, 133272, {
        SubType(LE_ITEM_CLASS_GEM, 0, 134083), -- ???
        SubType(LE_ITEM_CLASS_GEM, 2, 134114), -- ???
        SubType(LE_ITEM_CLASS_GEM, 1, 134080), -- ???
        SubType(LE_ITEM_CLASS_GEM, 5, 134111), -- ???
        SubType(LE_ITEM_CLASS_GEM, 4, 134093), -- ???
        SubType(LE_ITEM_CLASS_GEM, 3, 134103), -- ???
        SubType(LE_ITEM_CLASS_GEM, 8, 132886), -- ??????
        SubType(LE_ITEM_CLASS_GEM, 6, 134098), -- ??????
        SubType(LE_ITEM_CLASS_GEM, 7, 134087), -- ??????
    }), -- ??????
    -- @end-build>2@
    Rule(MISC, 134237, 'type:!' .. QUEST .. ' & tip:!' .. QUEST, {
        -- @build>2@
        Misc(LE_ITEM_MISCELLANEOUS_REAGENT, 133587), -- ??????
        -- @end-build>2@
        Type(LE_ITEM_CLASS_CONSUMABLE, 134420), -- ?????????
        Type(LE_ITEM_CLASS_MISCELLANEOUS, 134400), -- ??????
        Type(LE_ITEM_CLASS_KEY, 134237), -- ??????
    }), --
    Rule(QUEST, 133469, 'type:' .. QUEST .. ' | tip:' .. QUEST, {
        Tip(ITEM_STARTS_QUEST, 132836), -- ?????????
        Rule(nil, 133942, 'spell'), --
    }), -- ??????
}

ns.DEFAULT_SAVING_RULES = { --
    -- @build>2@
    16885, -- ????????????
    Trade(1, 133025), -- ??????
    Trade(5, 132903), -- ??????
    Trade(6, 134256), -- ??????
    Trade(7, 133217), -- ???????????????
    Trade(8, 134027), -- ??????
    Trade(9, 134215), -- ??????
    Trade(10, 135819), -- ??????
    Trade(12, 132864), -- ??????
    Trade(4, 134379), -- ????????????
    Trade(13, 132850), -- ??????
    Type(LE_ITEM_CLASS_GEM, 133272),
    -- @end-build>2@
}
