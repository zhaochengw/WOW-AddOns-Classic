local AddonName, ADDONSELF = ...

local L = ADDONSELF.L

local pt = print

local RealmId = GetRealmID()
local player = UnitName("player")
local _, class = UnitClass("player")

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addonName)
    if addonName ~= AddonName then return end

    local MaxFilter = {
        ["DEATHKNIGHT"] = 2,
        ["PALADIN"] = 3,
        ["WARRIOR"] = 2,
        ["SHAMAN"] = 3,
        ["HUNTER"] = 1,
        ["DRUID"] = 4,
        ["ROGUE"] = 1,
        ["MAGE"] = 1,
        ["WARLOCK"] = 1,
        ["PRIEST"] = 2,
    }
    BG.MaxFilter = MaxFilter

    if not BiaoGe.FilterClassItemDB then
        BiaoGe.FilterClassItemDB = {}
    end
    if not BiaoGe.FilterClassItemDB[RealmId] then
        BiaoGe.FilterClassItemDB[RealmId] = {}
    end
    if not BiaoGe.FilterClassItemDB[RealmId][player] then
        BiaoGe.FilterClassItemDB[RealmId][player] = {}
    elseif BG.IsVanilla() then -- 赛季服重置数据
        if not BiaoGe.options.SearchHistory.dt231208 then
            BiaoGe.FilterClassItemDB[RealmId][player] = {}
            BiaoGe.options.SearchHistory.dt231208 = true
        end
    end
    for i = 1, MaxFilter[class] do
        if not BiaoGe.FilterClassItemDB[RealmId][player][i] then
            BiaoGe.FilterClassItemDB[RealmId][player][i] = {}
        end
    end

    BG.FilterClassItemDB = {}
    BG.FilterClassItem_Default = {}

    ------------------按钮图标------------------
    BG.FilterClassItemDB.Icon = {
        ["DEATHKNIGHT" .. "1"] = { icon = "Interface/Icons/spell_deathknight_bloodpresence", name = L["死亡骑士-鲜血"] }, -- 血脸T
        ["DEATHKNIGHT" .. "2"] = { icon = "Interface/Icons/inv_sword_122", name = L["死亡骑士-冰霜/邪恶"] }, -- 杀戮机器DPS

        ["WARRIOR" .. "1"] = { icon = "Interface/Icons/ability_warrior_defensivestance", name = L["战士-防御"] }, -- 防御姿势T
        ["WARRIOR" .. "2"] = { icon = "Interface/Icons/INV_Sword_48", name = L["战士-武器/狂怒"] }, -- 斩杀DPS

        ["PALADIN" .. "1"] = { icon = "Interface/Icons/spell_holy_holybolt", name = L["圣骑士-神圣"] }, -- 圣光N
        ["PALADIN" .. "2"] = { icon = "Interface/Icons/spell_holy_devotionaura", name = L["圣骑士-防御"] }, -- 虔诚T
        ["PALADIN" .. "3"] = { icon = "Interface/Icons/spell_holy_auraoflight", name = L["圣骑士-惩戒"] }, -- 惩戒DPS

        ["HUNTER" .. "1"] = { icon = "Interface/Icons/classicon_hunter", name = L["猎人"] }, -- LR

        ["SHAMAN" .. "1"] = { icon = "Interface/Icons/spell_nature_lightning", name = L["萨满-元素"] }, -- 闪电箭FXDPS
        ["SHAMAN" .. "2"] = { icon = "Interface/Icons/spell_nature_lightningshield", name = L["萨满-增强"] }, -- 闪电之盾DPS
        ["SHAMAN" .. "3"] = { icon = "Interface/Icons/spell_nature_magicimmunity", name = L["萨满-恢复"] }, -- 治疗波N

        ["DRUID" .. "1"] = { icon = "Interface/Icons/spell_nature_starfall", name = L["德鲁伊-平衡"] }, -- 月火FXDPS
        ["DRUID" .. "2"] = { icon = "Interface/Icons/ability_racial_bearform", name = L["德鲁伊-巨熊"] }, -- 熊T
        ["DRUID" .. "3"] = { icon = "Interface/Icons/ability_druid_catform", name = L["德鲁伊-猎豹"] }, -- 猎豹形态DPS
        ["DRUID" .. "4"] = { icon = "Interface/Icons/spell_nature_healingtouch", name = L["德鲁伊-恢复"] }, -- 治疗之触N

        ["ROGUE" .. "1"] = { icon = "Interface/Icons/classicon_rogue", name = L["盗贼"] }, -- DZ

        ["WARLOCK" .. "1"] = { icon = "Interface/Icons/classicon_warlock", name = L["术士"] }, -- SS

        ["MAGE" .. "1"] = { icon = "Interface/Icons/classicon_mage", name = L["法师"] }, -- FS

        ["PRIEST" .. "1"] = { icon = "Interface/Icons/spell_holy_wordfortitude", name = L["牧师-戒律/神圣"] }, -- 真言术：韧N
        ["PRIEST" .. "2"] = { icon = "Interface/Icons/spell_shadow_shadowwordpain", name = L["牧师-暗影"] }, -- 暗言术：痛AM
    }

    for i = 1, MaxFilter[class] do
        if not BiaoGe.FilterClassItemDB[RealmId][player][i].Icon then
            BiaoGe.FilterClassItemDB[RealmId][player][i].Icon = BG.FilterClassItemDB.Icon[class .. i].icon
            BiaoGe.FilterClassItemDB[RealmId][player][i].Name = BG.FilterClassItemDB.Icon[class .. i].name
        end
    end

    BG.FilterClassItemDB.NewIcon = {
        "Interface/Icons/spell_deathknight_bloodpresence",  -- 血DT
        "Interface/Icons/spell_deathknight_frostpresence",  -- 冰DK
        "Interface/Icons/spell_deathknight_unholypresence", -- 邪DK

        "Interface/Icons/ability_rogue_eviscerate",         -- 武器
        "Interface/Icons/ability_warrior_defensivestance",  -- 防御姿势T
        "Interface/Icons/INV_Sword_48",                     -- 斩杀

        "Interface/Icons/spell_holy_holybolt",              -- 圣光N
        "Interface/Icons/spell_holy_devotionaura",          -- 虔诚T
        "Interface/Icons/spell_holy_auraoflight",           -- 惩戒DPS

        "Interface/Icons/ability_hunter_beasttaming",       -- 野兽
        "Interface/Icons/ability_marksmanship",             -- 射击
        "Interface/Icons/ability_hunter_swiftstrike",       -- 生存

        "Interface/Icons/spell_nature_lightning",           -- 闪电箭FXDPS
        "Interface/Icons/spell_nature_lightningshield",     -- 闪电之盾DPS
        "Interface/Icons/spell_nature_magicimmunity",       -- 治疗波N

        "Interface/Icons/spell_nature_starfall",            -- 月火FXDPS
        "Interface/Icons/ability_racial_bearform",          -- 熊T
        "Interface/Icons/ability_druid_catform",            -- 猎豹形态DPS
        "Interface/Icons/spell_nature_healingtouch",        -- 治疗之触N

        "Interface/Icons/ability_rogue_eviscerate",         -- 刺杀
        "Interface/Icons/ability_backstab",                 -- 战斗
        "Interface/Icons/ability_stealth",                  -- 敏锐

        "Interface/Icons/spell_shadow_deathcoil",           -- 痛苦
        "Interface/Icons/spell_shadow_metamorphosis",       -- 恶魔
        "Interface/Icons/spell_shadow_rainoffire",          -- 毁灭

        "Interface/Icons/spell_holy_magicalsentry",         -- 奥术
        "Interface/Icons/spell_fire_flamebolt",             -- 火焰
        "Interface/Icons/spell_frost_frostbolt02",          -- 冰霜

        "Interface/Icons/spell_holy_wordfortitude",         -- 戒律
        "Interface/Icons/spell_holy_guardianspirit",        -- 神圣
        "Interface/Icons/spell_shadow_shadowwordpain",      -- 暗影
    }

    ------------------装备词缀------------------
    if BG.IsVanilla() then
        BG.FilterClassItemDB.ShuXing = {
            -- { name = "力量", value = ITEM_MOD_STRENGTH }, --%c%s 力量
            { name = "力量", value = "%+.*" .. ITEM_MOD_STRENGTH_SHORT, name2 = ITEM_MOD_STRENGTH_SHORT },
            { name = "敏捷", value = "%+.*" .. SPEC_FRAME_PRIMARY_STAT_AGILITY, name2 = SPEC_FRAME_PRIMARY_STAT_AGILITY },
            { name = "智力", value = "%+.*" .. ITEM_MOD_INTELLECT_SHORT, name2 = ITEM_MOD_INTELLECT_SHORT },
            { name = "精神", value = "%+.*" .. ITEM_MOD_SPIRIT_SHORT, name2 = ITEM_MOD_SPIRIT_SHORT },
            { name = "5回法力值", value = ITEM_MOD_MANA_REGENERATION },
            { name = "防御", value = STAT_CATEGORY_DEFENSE },
            { name = "招架", value = STAT_PARRY },
            { name = "躲闪", value = STAT_DODGE },
            { name = "格挡值", value = ITEM_MOD_BLOCK_VALUE_SHORT },
            { name = "攻击强度", value = ITEM_MOD_ATTACK_POWER_SHORT },
            { name = "武器技能", value = COMBAT_RATING_NAME1 },
            { name = "击中时可能", value = ITEM_SPELL_TRIGGER_ONPROC },
            { name = "所有命中", value = L["所有法术和攻击的命中"], nothave = { ITEM_SPELL_TRIGGER_ONPROC }, onenter = L["这个词缀是赛季服新增的，指物理和法系的命中，治疗一般需要过滤此词缀"] },
            { name = "物理命中", value = L["你击中目标"], onenter = L["这个词缀是指物理命中"] },
            { name = "物理暴击", value = L["你造成爆击"], onenter = L["这个词缀是指物理爆击"] },
            { name = "法术命中", value = L["你的法术击中"], nothave = { ITEM_SPELL_TRIGGER_ONPROC }, onenter = L["这个词缀是指法术命中"] },
            { name = "法术暴击", value = L["你的法术造成爆击"], nothave = { ITEM_SPELL_TRIGGER_ONPROC }, onenter = L["这个词缀是指法术爆击"] },
            { name = "法术伤害", value = STAT_SPELLDAMAGE, nothave = { ITEM_SPELL_TRIGGER_ONPROC }, onenter = L["这个词缀是指单纯增加法术伤害，治疗一般需要过滤此词缀"] },
            { name = "法术强度", value = L["所有法术和魔法效果所造成的伤害和治疗效果"], nothave = { ITEM_SPELL_TRIGGER_ONPROC }, onenter = L["这个词缀是指增加法术伤害和治疗，物理职业一般需要过滤此词缀"] },
            { name = "特定法术强度", value = L["法术和效果所造成的伤害"], nothave = { ITEM_SPELL_TRIGGER_ONPROC }, onenter = L["这个词缀是指某种属性的法术伤害，比如增加火焰法术伤害，治疗一般需要过滤此词缀"] },
            { name = "治疗强度", value = L["法术所造成的治疗效果"], nothave = { ITEM_SPELL_TRIGGER_ONPROC }, onenter = L["这个词缀是指单纯增加治疗效果，法系DPS一般需要过滤此词缀"] },
        }

        local t1 = { "5回法力值", "法术强度", "特定法术强度", "治疗强度", "法术命中", "法术暴击", "法术伤害", } -- FZ, FQ
        local t3 = { "5回法力值", "法术强度", "特定法术强度", "治疗强度", "招架", "格挡值", "武器技能", "法术命中", "法术暴击", "法术伤害", } -- 熊T

        local dps1 = { "5回法力值", "法术强度", "特定法术强度", "治疗强度", "招架", "躲闪", "防御", "格挡值", "法术命中", "法术暴击", "法术伤害", } -- KBZ/CJQ
        local dps2 = { "5回法力值", "法术强度", "特定法术强度", "治疗强度", "招架", "躲闪", "防御", "格挡值", "法术命中", "法术暴击", "法术伤害", } -- DZ
        local dps3 = { "5回法力值", "法术强度", "特定法术强度", "治疗强度", } -- ZQS
        local dps4 = { "5回法力值", "法术强度", "特定法术强度", "治疗强度", "招架", "躲闪", "防御", "格挡值", "法术命中", "法术暴击", "法术伤害", } -- LR
        local dps5 = { "5回法力值", "法术强度", "特定法术强度", "治疗强度", "招架", "躲闪", "防御", "格挡值", "武器技能", "法术命中", "法术暴击", "法术伤害", } -- 猫

        local fx1 = { "招架", "躲闪", "防御", "格挡值", "攻击强度", "武器技能", "击中时可能", "治疗强度", "物理命中", "物理暴击", } -- 法系dps

        local n1 = { "招架", "躲闪", "防御", "格挡值", "攻击强度", "武器技能", "击中时可能", "特定法术强度", "物理命中", "物理暴击", "法术命中", "所有命中", } -- 治疗

        BG.FilterClassItem_Default.ShuXing = {
            ["WARRIOR" .. "1"] = t1,   -- FZ
            ["WARRIOR" .. "2"] = dps1, -- KBZ

            ["PALADIN" .. "1"] = n1,   -- NQ
            ["PALADIN" .. "2"] = t1,   -- FQ
            ["PALADIN" .. "3"] = dps1, -- CJQ

            ["HUNTER" .. "1"] = dps4,  -- LR

            ["SHAMAN" .. "1"] = fx1,   -- 元素
            ["SHAMAN" .. "2"] = dps3,  -- ZQS
            ["SHAMAN" .. "3"] = n1,    -- NS

            ["DRUID" .. "1"] = fx1,    -- 咕咕
            ["DRUID" .. "2"] = t3,     -- 熊T
            ["DRUID" .. "3"] = dps5,   -- 猫D
            ["DRUID" .. "4"] = n1,     -- ND

            ["ROGUE" .. "1"] = dps2,   -- DZ

            ["WARLOCK" .. "1"] = fx1,  -- SS

            ["MAGE" .. "1"] = fx1,     -- FS

            ["PRIEST" .. "1"] = n1,    -- MS
            ["PRIEST" .. "2"] = fx1,   -- AM
        }

        for i = 1, MaxFilter[class] do
            if not BiaoGe.FilterClassItemDB[RealmId][player][i].ShuXing then
                BiaoGe.FilterClassItemDB[RealmId][player][i].ShuXing = {}

                for k, v in pairs(BG.FilterClassItem_Default.ShuXing[class .. i]) do
                    BiaoGe.FilterClassItemDB[RealmId][player][i].ShuXing[v] = 1
                end
            end
        end
    else
        if BG.IsWLK() then
            BG.FilterClassItemDB.ShuXing = {
                { name = "力量", value = "%+.*" .. ITEM_MOD_STRENGTH_SHORT, name2 = ITEM_MOD_STRENGTH_SHORT },
                { name = "敏捷", value = "%+.*" .. SPEC_FRAME_PRIMARY_STAT_AGILITY, name2 = SPEC_FRAME_PRIMARY_STAT_AGILITY },
                { name = "智力", value = "%+.*" .. ITEM_MOD_INTELLECT_SHORT, name2 = ITEM_MOD_INTELLECT_SHORT },
                { name = "精神", value = "%+.*" .. ITEM_MOD_SPIRIT_SHORT, name2 = ITEM_MOD_SPIRIT_SHORT },
                { name = "5回法力值", value = ITEM_MOD_MANA_REGENERATION },
                { name = "命中", value = HIT_LCD },
                { name = "急速", value = STAT_HASTE },
                { name = "暴击", value = STAT_CRITICAL_STRIKE },
                { name = "防御", value = STAT_CATEGORY_DEFENSE },
                { name = "招架", value = STAT_PARRY },
                { name = "躲闪", value = STAT_DODGE },
                { name = "格挡", value = ITEM_MOD_BLOCK_RATING_SHORT },
                { name = "攻击强度", value = ITEM_MOD_ATTACK_POWER_SHORT },
                { name = "精准", value = STAT_EXPERTISE },
                { name = "护甲穿透", value = ITEM_MOD_ARMOR_PENETRATION_RATING },
                { name = "近战攻击", value = MELEE_ATTACK },
                { name = "远程攻击", value = RANGED_ATTACK },
                { name = "法术强度", value = ITEM_MOD_SPELL_POWER_SHORT },
                -- { name = "副手物品", value = INVTYPE_HOLDABLE, onenter = L["这里是指法系的副手，不是物理dps的副手武器"] },
            }
        elseif BG.IsCTM() then
            BG.FilterClassItemDB.ShuXing = {
                { name = "力量", value = "%+.*" .. ITEM_MOD_STRENGTH_SHORT, name2 = ITEM_MOD_STRENGTH_SHORT },
                { name = "敏捷", value = "%+.*" .. SPEC_FRAME_PRIMARY_STAT_AGILITY, name2 = SPEC_FRAME_PRIMARY_STAT_AGILITY },
                { name = "智力", value = "%+.*" .. ITEM_MOD_INTELLECT_SHORT, name2 = ITEM_MOD_INTELLECT_SHORT },
                { name = "精神", value = "%+.*" .. ITEM_MOD_SPIRIT_SHORT, name2 = ITEM_MOD_SPIRIT_SHORT },
                { name = "5回法力值", value = ITEM_MOD_MANA_REGENERATION },
                { name = "精通", value = "%+.*" .. ITEM_MOD_MASTERY_RATING_SHORT, name2 = ITEM_MOD_MASTERY_RATING_SHORT },
                { name = "命中", value = HIT_LCD },
                { name = "急速", value = STAT_HASTE },
                { name = "暴击", value = STAT_CRITICAL_STRIKE },
                { name = "韧性", value = RESILIENCE },
                { name = "防御", value = STAT_CATEGORY_DEFENSE },
                { name = "招架", value = STAT_PARRY },
                { name = "躲闪", value = STAT_DODGE },
                { name = "格挡", value = ITEM_MOD_BLOCK_RATING_SHORT },
                { name = "攻击强度", value = ITEM_MOD_ATTACK_POWER_SHORT },
                { name = "精准", value = STAT_EXPERTISE },
                { name = "近战攻击", value = MELEE_ATTACK },
                { name = "远程攻击", value = RANGED_ATTACK },
                { name = "法术强度", value = ITEM_MOD_SPELL_POWER_SHORT },
                -- { name = "副手物品", value = INVTYPE_HOLDABLE, onenter = L["这里是指法系的副手，不是物理dps的副手武器"] },
            }
        end

        local t1 = { "智力", "精神", "5回法力值", "法术强度", "副手物品", } -- FZ, FQ
        local t2 = { "智力", "精神", "5回法力值", "法术强度", "格挡", "副手物品", } -- DKT
        local t3 = { "智力", "精神", "5回法力值", "法术强度", "格挡", "招架", "副手物品", } -- 熊T

        local dps1 = { "精神", "5回法力值", "法术强度", "格挡", "招架", "躲闪", "防御", "副手物品", } -- KBZ/CJQ/DK
        local dps2 = { "智力", "精神", "5回法力值", "法术强度", "格挡", "格挡", "招架", "躲闪", "防御", "副手物品", } -- DZ/猫
        local dps3 = { "精神", "5回法力值", "格挡", "招架", "躲闪", "防御", "副手物品", } -- ZQS
        local dps4 = { "力量", "精神", "5回法力值", "法术强度", "格挡", "招架", "躲闪", "防御", "精准", "副手物品", } -- LR

        local fx1 = { "力量", "敏捷", "5回法力值", "格挡", "招架", "躲闪", "防御", "精准", "攻击强度", "护甲穿透", "近战攻击", "远程攻击", } -- 法系dps
        local fx2 = { "力量", "敏捷", "精神", "5回法力值", "格挡", "招架", "躲闪", "防御", "精准", "攻击强度", "护甲穿透", "近战攻击", "远程攻击", } -- 元素萨

        local n1 = { "力量", "敏捷", "命中", "格挡", "招架", "躲闪", "防御", "精准", "攻击强度", "护甲穿透", "近战攻击", "远程攻击", } -- 治疗
        local n2 = { "力量", "敏捷", "命中", "精神", "格挡", "招架", "躲闪", "防御", "精准", "攻击强度", "护甲穿透", "近战攻击", "远程攻击", "副手物品", } -- NQ/NS

        BG.FilterClassItem_Default.ShuXing = {
            ["DEATHKNIGHT" .. 1] = t2,   -- 血DK
            ["DEATHKNIGHT" .. 2] = dps1, -- DK

            ["WARRIOR" .. "1"] = t1,     -- FZ
            ["WARRIOR" .. "2"] = dps1,   -- KBZ

            ["PALADIN" .. "1"] = n2,     -- NQ
            ["PALADIN" .. "2"] = t1,     -- FQ
            ["PALADIN" .. "3"] = dps1,   -- CJQ

            ["HUNTER" .. "1"] = dps4,    -- LR

            ["SHAMAN" .. "1"] = fx2,     -- 元素
            ["SHAMAN" .. "2"] = dps3,    -- ZQS
            ["SHAMAN" .. "3"] = n2,      -- NS

            ["DRUID" .. "1"] = fx1,      -- 咕咕
            ["DRUID" .. "2"] = t3,       -- 熊T
            ["DRUID" .. "3"] = dps2,     -- 猫D
            ["DRUID" .. "4"] = n1,       -- ND

            ["ROGUE" .. "1"] = dps2,     -- DZ

            ["WARLOCK" .. "1"] = fx1,    -- SS

            ["MAGE" .. "1"] = fx1,       -- FS

            ["PRIEST" .. "1"] = n1,      -- MS
            ["PRIEST" .. "2"] = fx1,     -- AM
        }

        for i = 1, MaxFilter[class] do
            if not BiaoGe.FilterClassItemDB[RealmId][player][i].ShuXing then
                BiaoGe.FilterClassItemDB[RealmId][player][i].ShuXing = {}

                for k, v in pairs(BG.FilterClassItem_Default.ShuXing[class .. i]) do
                    BiaoGe.FilterClassItemDB[RealmId][player][i].ShuXing[v] = 1
                end
            end
        end
    end

    ------------------武器类型------------------

    BG.FilterClassItemDB.Weapon = {
        { name = "7", value = L["单手剑"] },
        { name = "0", value = L["单手斧"] },
        { name = "4", value = L["单手锤"] },
        { name = "15", value = L["匕首"] },
        { name = "13", value = L["拳套"] },
        { name = "8", value = L["双手剑"] },
        { name = "1", value = L["双手斧"] },
        { name = "5", value = L["双手锤"] },
        { name = "6", value = L["长柄武器"] },
        { name = "10", value = L["法杖"] },
        { name = "3", value = L["枪"] },
        { name = "2", value = L["弓"] },
        { name = "18", value = L["弩"] },
        { name = "19", value = L["魔杖"] },
        { name = "16", value = L["投掷武器"] },
    }

    local G = {
        ["单手斧"] = "0",
        ["双手斧"] = "1",
        ["弓"] = "2",
        ["枪"] = "3",
        ["单手锤"] = "4",
        ["双手锤"] = "5",
        ["长柄武器"] = "6",
        ["单手剑"] = "7",
        ["双手剑"] = "8",
        ["法杖"] = "10",
        ["拳套"] = "13",
        ["匕首"] = "15",
        ["投掷武器"] = "16",
        ["弩"] = "18",
        ["魔杖"] = "19",
    }


    if BG.IsVanilla() then
        BG.FilterClassItem_Default.Weapon = {
            ["WARRIOR" .. "1"] = { G["双手斧"], G["双手锤"], G["长柄武器"], G["双手剑"], G["法杖"], G["魔杖"] }, -- FZ
            ["WARRIOR" .. "2"] = { G["魔杖"] }, -- KBZ

            ["PALADIN" .. "1"] = { G["双手斧"], G["弓"], G["枪"], G["双手锤"], G["长柄武器"], G["双手剑"], G["法杖"], G["拳套"], G["匕首"], G["投掷武器"], G["弩"], G["魔杖"] }, -- NQ
            ["PALADIN" .. "2"] = { G["双手斧"], G["弓"], G["枪"], G["双手锤"], G["长柄武器"], G["双手剑"], G["法杖"], G["拳套"], G["匕首"], G["投掷武器"], G["弩"], G["魔杖"] }, -- FQ
            ["PALADIN" .. "3"] = { G["单手斧"], G["弓"], G["枪"], G["单手锤"], G["单手剑"], G["法杖"], G["拳套"], G["匕首"], G["投掷武器"], G["弩"], G["魔杖"] }, -- CJQ

            ["HUNTER" .. "1"]  = { G["单手锤"], G["双手锤"], G["投掷武器"], G["魔杖"] }, -- LR

            ["SHAMAN" .. "1"]  = { G["弓"], G["枪"], G["长柄武器"], G["单手剑"], G["双手剑"], G["投掷武器"], G["弩"], G["魔杖"] }, -- 元素
            ["SHAMAN" .. "2"]  = { G["双手斧"], G["弓"], G["枪"], G["双手锤"], G["长柄武器"], G["单手剑"], G["双手剑"], G["法杖"], G["投掷武器"], G["弩"], G["魔杖"] }, -- ZQS
            ["SHAMAN" .. "3"]  = { G["弓"], G["枪"], G["长柄武器"], G["单手剑"], G["双手剑"], G["投掷武器"], G["弩"], G["魔杖"] }, -- NS

            ["DRUID" .. "1"]   = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["单手剑"], G["双手剑"], G["拳套"], G["双手锤"], G["长柄武器"], G["投掷武器"], G["弩"], G["魔杖"] }, -- 咕咕
            ["DRUID" .. "2"]   = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["单手剑"], G["双手剑"], G["单手锤"], G["拳套"], G["匕首"], G["长柄武器"], G["投掷武器"], G["弩"], G["魔杖"] }, -- 熊T
            ["DRUID" .. "3"]   = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["单手剑"], G["双手剑"], G["单手锤"], G["拳套"], G["匕首"], G["长柄武器"], G["投掷武器"], G["弩"], G["魔杖"] }, -- 猫D
            ["DRUID" .. "4"]   = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["单手剑"], G["双手剑"], G["拳套"], G["双手锤"], G["长柄武器"], G["投掷武器"], G["弩"], G["魔杖"] }, -- ND

            ["ROGUE" .. "1"]   = { G["单手斧"], G["双手斧"], G["双手锤"], G["长柄武器"], G["双手剑"], G["法杖"], G["魔杖"], }, -- DZ

            ["WARLOCK" .. "1"] = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["单手锤"], G["双手锤"], G["长柄武器"], G["双手剑"], G["拳套"], G["投掷武器"], G["弩"] }, -- SS

            ["MAGE" .. "1"]    = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["单手锤"], G["双手锤"], G["长柄武器"], G["双手剑"], G["拳套"], G["投掷武器"], G["弩"] }, -- FS

            ["PRIEST" .. "1"]  = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["双手锤"], G["长柄武器"], G["单手剑"], G["双手剑"], G["拳套"], G["投掷武器"], G["弩"] }, -- MS
            ["PRIEST" .. "2"]  = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["双手锤"], G["长柄武器"], G["单手剑"], G["双手剑"], G["拳套"], G["投掷武器"], G["弩"] }, -- AM
        }
    else
        BG.FilterClassItem_Default.Weapon = {
            ["DEATHKNIGHT" .. "1"] = { G["单手斧"], G["弓"], G["枪"], G["单手锤"], G["单手剑"], G["法杖"], G["拳套"], G["匕首"], G["投掷武器"], G["弩"], G["魔杖"] }, -- 血DK
            ["DEATHKNIGHT" .. "2"] = { G["双手剑"], G["双手锤"], G["双手斧"], G["长柄武器"], G["弓"], G["枪"], G["法杖"], G["拳套"], G["匕首"], G["投掷武器"], G["弩"], G["魔杖"] }, -- DK

            ["WARRIOR" .. "1"]     = { G["双手斧"], G["双手锤"], G["长柄武器"], G["双手剑"], G["法杖"], G["魔杖"] }, -- FZ
            ["WARRIOR" .. "2"]     = { G["单手斧"], G["单手锤"], G["单手剑"], G["拳套"], G["匕首"], G["魔杖"] }, -- KBZ

            ["PALADIN" .. "1"]     = { G["双手斧"], G["弓"], G["枪"], G["双手锤"], G["长柄武器"], G["双手剑"], G["法杖"], G["拳套"], G["匕首"], G["投掷武器"], G["弩"], G["魔杖"] }, -- NQ
            ["PALADIN" .. "2"]     = { G["双手斧"], G["弓"], G["枪"], G["双手锤"], G["长柄武器"], G["双手剑"], G["法杖"], G["拳套"], G["匕首"], G["投掷武器"], G["弩"], G["魔杖"] }, -- FQ
            ["PALADIN" .. "3"]     = { G["单手斧"], G["弓"], G["枪"], G["单手锤"], G["单手剑"], G["法杖"], G["拳套"], G["匕首"], G["投掷武器"], G["弩"], G["魔杖"] }, -- CJQ

            ["HUNTER" .. "1"]      = { G["单手斧"], G["单手剑"], G["单手锤"], G["拳套"], G["匕首"], G["双手锤"], G["投掷武器"], G["魔杖"] }, -- LR

            ["SHAMAN" .. "1"]      = { G["弓"], G["枪"], G["长柄武器"], G["单手剑"], G["双手剑"], G["投掷武器"], G["弩"], G["魔杖"] }, -- 元素
            ["SHAMAN" .. "2"]      = { G["双手斧"], G["弓"], G["枪"], G["双手锤"], G["长柄武器"], G["单手剑"], G["双手剑"], G["法杖"], G["投掷武器"], G["弩"], G["魔杖"] }, -- ZQS
            ["SHAMAN" .. "3"]      = { G["弓"], G["枪"], G["长柄武器"], G["单手剑"], G["双手剑"], G["投掷武器"], G["弩"], G["魔杖"] }, -- NS

            ["DRUID" .. "1"]       = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["单手剑"], G["双手剑"], G["拳套"], G["双手锤"], G["长柄武器"], G["投掷武器"], G["弩"], G["魔杖"] }, -- 咕咕
            ["DRUID" .. "2"]       = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["单手剑"], G["双手剑"], G["单手锤"], G["拳套"], G["匕首"], G["投掷武器"], G["弩"], G["魔杖"] }, -- 熊T
            ["DRUID" .. "3"]       = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["单手剑"], G["双手剑"], G["单手锤"], G["拳套"], G["匕首"], G["投掷武器"], G["弩"], G["魔杖"] }, -- 猫D
            ["DRUID" .. "4"]       = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["单手剑"], G["双手剑"], G["拳套"], G["双手锤"], G["长柄武器"], G["投掷武器"], G["弩"], G["魔杖"] }, -- ND

            ["ROGUE" .. "1"]       = { G["双手斧"], G["双手锤"], G["长柄武器"], G["双手剑"], G["法杖"], G["魔杖"], }, -- DZ

            ["WARLOCK" .. "1"]     = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["单手锤"], G["双手锤"], G["长柄武器"], G["双手剑"], G["拳套"], G["投掷武器"], G["弩"] }, -- SS

            ["MAGE" .. "1"]        = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["单手锤"], G["双手锤"], G["长柄武器"], G["双手剑"], G["拳套"], G["投掷武器"], G["弩"] }, -- FS

            ["PRIEST" .. "1"]      = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["双手锤"], G["长柄武器"], G["单手剑"], G["双手剑"], G["拳套"], G["投掷武器"], G["弩"] }, -- MS
            ["PRIEST" .. "2"]      = { G["单手斧"], G["双手斧"], G["弓"], G["枪"], G["双手锤"], G["长柄武器"], G["单手剑"], G["双手剑"], G["拳套"], G["投掷武器"], G["弩"] }, -- AM

            -- 0 单手斧
            -- 1 双手斧
            -- 2 弓	
            -- 3 枪
            -- 4 单手锤	
            -- 5 双手锤	
            -- 6 长柄武器
            -- 7 单手剑	
            -- 8 双手剑	
            -- 10 法杖	
            -- 13 拳套
            -- 15 匕首
            -- 16 投掷武器
            -- 18 弩
            -- 19 魔杖
            -- 20 钓鱼竿
        }
    end

    for i = 1, MaxFilter[class] do
        if not BiaoGe.FilterClassItemDB[RealmId][player][i].Weapon then
            BiaoGe.FilterClassItemDB[RealmId][player][i].Weapon = {}

            for k, v in pairs(BG.FilterClassItem_Default.Weapon[class .. i]) do
                BiaoGe.FilterClassItemDB[RealmId][player][i].Weapon[v] = 1
            end
        end
    end

    ------------------护甲类型------------------

    BG.FilterClassItemDB.Armor = {
        { name = "1", value = L["布甲"], onenter = L["全部布甲会被过滤（披风除外，否则本来合适你的披风也可能会被过滤）"] },
        { name = "2", value = L["皮甲"] },
        { name = "3", value = L["锁甲"] },
        { name = "4", value = L["板甲"] },
        { name = "6", value = SHIELDSLOT },
        { name = "0", value = INVTYPE_HOLDABLE },
        { name = "7", value = L["圣契"] },
        { name = "8", value = L["神像"] },
        { name = "9", value = L["图腾"] },
    }
    if not BG.IsVanilla() then
        tinsert(BG.FilterClassItemDB.Armor, { name = "10", value = L["魔印"] })
    end


    local G = {
        ["布甲"] = "1",
        ["皮甲"] = "2",
        ["锁甲"] = "3",
        ["板甲"] = "4",
        ["盾牌"] = "6",
        ["副手物品"] = "0",
        ["圣契"] = "7",
        ["神像"] = "8",
        ["图腾"] = "9",
        ["魔印"] = "10",
    }

    if BG.IsVanilla() then
        BG.FilterClassItem_Default.Armor = {
            ["WARRIOR" .. "1"] = { G["布甲"], G["皮甲"], G["圣契"], G["神像"], G["图腾"], G["副手物品"] }, -- FZ
            ["WARRIOR" .. "2"] = { G["布甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"], G["副手物品"] }, -- DPS
            ["PALADIN" .. "1"] = { G["神像"], G["图腾"] }, -- NQ
            ["PALADIN" .. "2"] = { G["布甲"], G["皮甲"], G["神像"], G["图腾"], G["副手物品"] }, -- FQ
            ["PALADIN" .. "3"] = { G["布甲"], G["盾牌"], G["神像"], G["图腾"], G["副手物品"] }, -- CJQ
            ["HUNTER" .. "1"]  = { G["布甲"], G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"], G["副手物品"] }, -- LR
            ["SHAMAN" .. "1"]  = { G["板甲"], G["圣契"], G["神像"] }, -- 元素
            ["SHAMAN" .. "2"]  = { G["布甲"], G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["副手物品"] }, -- ZQS
            ["SHAMAN" .. "3"]  = { G["板甲"], G["圣契"], G["神像"] }, -- NS
            ["DRUID" .. "1"]   = { G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["图腾"] }, -- 咕咕
            ["DRUID" .. "2"]   = { G["布甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["图腾"], G["副手物品"] }, -- 熊T
            ["DRUID" .. "3"]   = { G["布甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["图腾"], G["副手物品"] }, -- 猫D
            ["DRUID" .. "4"]   = { G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["图腾"] }, -- ND
            ["ROGUE" .. "1"]   = { G["布甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"], G["副手物品"] }, -- DZ
            ["WARLOCK" .. "1"] = { G["皮甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"] }, -- SS
            ["MAGE" .. "1"]    = { G["皮甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"] }, -- FS
            ["PRIEST" .. "1"]  = { G["皮甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"] }, -- MS
            ["PRIEST" .. "2"]  = { G["皮甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"] }, -- AM
        }
    else
        BG.FilterClassItem_Default.Armor = {
            ["DEATHKNIGHT" .. "1"] = { G["布甲"], G["皮甲"], G["锁甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"], G["副手物品"] }, -- 血DK
            ["DEATHKNIGHT" .. "2"] = { G["布甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"], G["副手物品"] }, -- DPS
            ["WARRIOR" .. "1"]     = { G["布甲"], G["皮甲"], G["锁甲"], G["圣契"], G["神像"], G["图腾"], G["魔印"], G["副手物品"] }, -- FZ
            ["WARRIOR" .. "2"]     = { G["布甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"], G["魔印"], G["副手物品"] }, -- DPS
            ["PALADIN" .. "1"]     = { G["神像"], G["图腾"], G["魔印"] }, -- NQ
            ["PALADIN" .. "2"]     = { G["布甲"], G["皮甲"], G["锁甲"], G["神像"], G["图腾"], G["魔印"], G["副手物品"] }, -- FQ
            ["PALADIN" .. "3"]     = { G["布甲"], G["盾牌"], G["神像"], G["图腾"], G["魔印"], G["副手物品"] }, -- CJQ
            ["HUNTER" .. "1"]      = { G["布甲"], G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"], G["魔印"], G["副手物品"] }, -- LR
            ["SHAMAN" .. "1"]      = { G["板甲"], G["圣契"], G["神像"], G["魔印"] }, -- 元素
            ["SHAMAN" .. "2"]      = { G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["魔印"], G["副手物品"] }, -- ZQS
            ["SHAMAN" .. "3"]      = { G["板甲"], G["圣契"], G["神像"], G["魔印"] }, -- NS
            ["DRUID" .. "1"]       = { G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["图腾"], G["魔印"] }, -- 咕咕
            ["DRUID" .. "2"]       = { G["布甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["图腾"], G["魔印"], G["副手物品"] }, -- 熊T
            ["DRUID" .. "3"]       = { G["布甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["图腾"], G["魔印"], G["副手物品"] }, -- 猫D
            ["DRUID" .. "4"]       = { G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["图腾"], G["魔印"] }, -- ND
            ["ROGUE" .. "1"]       = { G["布甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"], G["魔印"], G["副手物品"] }, -- DZ
            ["WARLOCK" .. "1"]     = { G["皮甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"], G["魔印"] }, -- SS
            ["MAGE" .. "1"]        = { G["皮甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"], G["魔印"] }, -- FS
            ["PRIEST" .. "1"]      = { G["皮甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"], G["魔印"] }, -- MS
            ["PRIEST" .. "2"]      = { G["皮甲"], G["锁甲"], G["板甲"], G["盾牌"], G["圣契"], G["神像"], G["图腾"], G["魔印"] }, -- AM

            -- 1 布甲	
            -- 2 皮甲
            -- 3 锁甲
            -- 4 板甲	
            -- 6 盾牌
            -- 7 圣契
            -- 8 神像	
            -- 9 图腾	
            -- 10 魔印	
        }
    end

    for i = 1, MaxFilter[class] do
        if not BiaoGe.FilterClassItemDB[RealmId][player][i].Armor then
            BiaoGe.FilterClassItemDB[RealmId][player][i].Armor = {}

            for k, v in pairs(BG.FilterClassItem_Default.Armor[class .. i]) do
                BiaoGe.FilterClassItemDB[RealmId][player][i].Armor[v] = 1
            end
        end
    end

    ------------------职业限定------------------

    BG.FilterClassItemDB.Class = {
        { name = "过滤职业限定", value = L["过滤职业限定的装备"], },
        -- { name = "过滤职业限定", value = L["过滤职业限定的装备"], onenter = L["像套装兑换物这种有职业限定的装备，不适合你的会被过滤"] },
    }

    BG.FilterClassItem_Default.Class = {
        ["DEATHKNIGHT" .. "1"] = { "过滤职业限定" }, -- 血DK
        ["DEATHKNIGHT" .. "2"] = { "过滤职业限定" }, -- DPS
        ["WARRIOR" .. "1"]     = { "过滤职业限定" }, -- FZ
        ["WARRIOR" .. "2"]     = { "过滤职业限定" }, -- DPS
        ["PALADIN" .. "1"]     = { "过滤职业限定" }, -- NQ
        ["PALADIN" .. "2"]     = { "过滤职业限定" }, -- FQ
        ["PALADIN" .. "3"]     = { "过滤职业限定" }, -- CJQ
        ["HUNTER" .. "1"]      = { "过滤职业限定" }, -- LR
        ["SHAMAN" .. "1"]      = { "过滤职业限定" }, -- 元素
        ["SHAMAN" .. "2"]      = { "过滤职业限定" }, -- ZQS
        ["SHAMAN" .. "3"]      = { "过滤职业限定" }, -- NS
        ["DRUID" .. "1"]       = { "过滤职业限定" }, -- 咕咕
        ["DRUID" .. "2"]       = { "过滤职业限定" }, -- 熊T
        ["DRUID" .. "3"]       = { "过滤职业限定" }, -- 猫D
        ["DRUID" .. "4"]       = { "过滤职业限定" }, -- ND
        ["ROGUE" .. "1"]       = { "过滤职业限定" }, -- DZ
        ["WARLOCK" .. "1"]     = { "过滤职业限定" }, -- SS
        ["MAGE" .. "1"]        = { "过滤职业限定" }, -- FS
        ["PRIEST" .. "1"]      = { "过滤职业限定" }, -- MS
        ["PRIEST" .. "2"]      = { "过滤职业限定" }, -- AM
    }

    for i = 1, MaxFilter[class] do
        if not BiaoGe.FilterClassItemDB[RealmId][player][i].Class then
            BiaoGe.FilterClassItemDB[RealmId][player][i].Class = {}

            for k, v in pairs(BG.FilterClassItem_Default.Class[class .. i]) do
                BiaoGe.FilterClassItemDB[RealmId][player][i].Class[v] = 1
            end
        end
    end

    ------------------坦克特殊过滤------------------

    local type = "Tank"
    BG.FilterClassItemDB[type] = {
        { name = "过滤坦克", value = L["过滤没有坦克属性的装备"], },
    }

    BG.FilterClassItem_Default.TankKey = {
        STAT_CATEGORY_DEFENSE,
        STAT_PARRY,
        STAT_DODGE,
        STAT_BLOCK,
    }

    BG.FilterClassItem_Default[type] = {
        ["DEATHKNIGHT" .. "1"] = { "过滤坦克" }, -- 血DK
        ["DEATHKNIGHT" .. "2"] = {}, -- DPS
        ["WARRIOR" .. "1"]     = { "过滤坦克" }, -- FZ
        ["WARRIOR" .. "2"]     = {}, -- DPS
        ["PALADIN" .. "1"]     = {}, -- NQ
        ["PALADIN" .. "2"]     = { "过滤坦克" }, -- FQ
        ["PALADIN" .. "3"]     = {}, -- CJQ
        ["HUNTER" .. "1"]      = {}, -- LR
        ["SHAMAN" .. "1"]      = {}, -- 元素
        ["SHAMAN" .. "2"]      = {}, -- ZQS
        ["SHAMAN" .. "3"]      = {}, -- NS
        ["DRUID" .. "1"]       = {}, -- 咕咕
        ["DRUID" .. "2"]       = {}, -- 熊T
        ["DRUID" .. "3"]       = {}, -- 猫D
        ["DRUID" .. "4"]       = {}, -- ND
        ["ROGUE" .. "1"]       = {}, -- DZ
        ["WARLOCK" .. "1"]     = {}, -- SS
        ["MAGE" .. "1"]        = {}, -- FS
        ["PRIEST" .. "1"]      = {}, -- MS
        ["PRIEST" .. "2"]      = {}, -- AM
    }

    for i = 1, MaxFilter[class] do
        if not BiaoGe.FilterClassItemDB[RealmId][player][i][type] then
            BiaoGe.FilterClassItemDB[RealmId][player][i][type] = {}

            for k, v in pairs(BG.FilterClassItem_Default[type][class .. i]) do
                BiaoGe.FilterClassItemDB[RealmId][player][i][type][v] = 1
            end
        end
    end
end)
