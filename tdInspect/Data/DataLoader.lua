-- DataLoader.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/25/2020, 4:43:38 PM
--
---@class ns
local ns = select(2, ...)

ns.Talents = {}
ns.ItemSets = {}
ns.Glyphes = {}
ns.SpellGlyphes = {}
ns.GlyphSlots = {}

local strsplittable = strsplittable or function(delimiter, str, pieces)
    return {strsplit(delimiter, str, pieces)}
end

local T = ns.memorize(function(val)
    local t = strsplittable('/', val)
    for i, v in ipairs(t) do
        t[i] = tonumber(v) or v
    end
    return t
end)

function ns.TalentMake()
    ns.TalentMake = nil

    local CURRENT
    local LOCAL_INDEX = {}

    local function DefineLocalIndexs(val)
        for i, locale in ipairs(strsplittable('/', val)) do
            LOCAL_INDEX[locale] = i
        end
    end

    local function CreateClass(classFileName)
        CURRENT = {}
        ns.Talents[classFileName] = CURRENT
    end

    local function CreateTab(tabId, numTalents, bg, icon)
        tinsert(CURRENT, {tabId = tabId, numTalents = numTalents, bg = bg, icon = icon, talents = {}})
    end

    local function CreateTalentInfo(index, row, column, maxRank, id)
        local tab = CURRENT[#CURRENT]
        tinsert(tab.talents, {row = row, column = column, maxRank = maxRank, id = id, index = index})
    end

    local function FillTalentRanks(ranks)
        local tab = CURRENT[#CURRENT]
        local talent = tab.talents[#tab.talents]
        local _
        talent.ranks = ranks
        talent.name, _, talent.icon = GetSpellInfo(ranks[1])
    end

    local function FillTalentPrereq(row, column, reqIndex)
        local tab = CURRENT[#CURRENT]
        local talent = tab.talents[#tab.talents]
        talent.prereqs = talent.prereqs or {}
        tinsert(talent.prereqs, {row = row, column = column, reqIndex = reqIndex})
    end

    local function SetTabName(names)
        local tab = CURRENT[#CURRENT]
        local locale = GetLocale()
        local index = LOCAL_INDEX[locale] or LOCAL_INDEX.enUS
        tab.name = strsplittable('/', names)[index]
    end

    setfenv(2, {
        D = DefineLocalIndexs,
        C = CreateClass,
        T = CreateTab,
        I = CreateTalentInfo,
        R = FillTalentRanks,
        P = FillTalentPrereq,
        N = SetTabName,
    })
end

function ns.ItemSetMake()
    ns.ItemSetMake = nil

    local SLOTS = {
        [0] = 'INVTYPE_NON_EQUIP',
        [1] = 'INVTYPE_HEAD',
        [2] = 'INVTYPE_NECK',
        [3] = 'INVTYPE_SHOULDER',
        [4] = 'INVTYPE_BODY',
        [5] = 'INVTYPE_CHEST',
        [6] = 'INVTYPE_WAIST',
        [7] = 'INVTYPE_LEGS',
        [8] = 'INVTYPE_FEET',
        [9] = 'INVTYPE_WRIST',
        [10] = 'INVTYPE_HAND',
        [11] = 'INVTYPE_FINGER',
        [12] = 'INVTYPE_TRINKET',
        [13] = 'INVTYPE_WEAPON',
        [14] = 'INVTYPE_SHIELD',
        [15] = 'INVTYPE_RANGED',
        [16] = 'INVTYPE_CLOAK',
        [17] = 'INVTYPE_2HWEAPON',
        [18] = 'INVTYPE_BAG',
        [19] = 'INVTYPE_TABARD',
        [20] = 'INVTYPE_ROBE',
        [21] = 'INVTYPE_WEAPONMAINHAND',
        [22] = 'INVTYPE_WEAPONOFFHAND',
        [23] = 'INVTYPE_HOLDABLE',
        [24] = 'INVTYPE_AMMO',
        [25] = 'INVTYPE_THROWN',
        [26] = 'INVTYPE_RANGEDRIGHT',
        [27] = 'INVTYPE_QUIVER',
        [28] = 'INVTYPE_RELIC',
    }

    local CURRENT

    local function CreateItemSet(setId)
        local db = {slots = {}}
        ns.ItemSets[setId] = db
        CURRENT = db
    end

    local function SetItemSetBouns(bouns)
        CURRENT.bouns = T(bouns)
    end

    local function SetItemSetSlotItem(slot, itemId)
        slot = SLOTS[slot]
        CURRENT.slots[slot] = CURRENT.slots[slot] or {}
        CURRENT.slots[slot][itemId] = true
    end

    setfenv(2, { --
        S = CreateItemSet,
        B = SetItemSetBouns,
        I = SetItemSetSlotItem,
    })
end

function ns.GlyphMake()
    ns.GlyphMake = nil

    local Data = function(glyphId, spellId, icon)
        local d = {glyphId = glyphId, spellId = spellId, icon = icon}
        if glyphId ~= 0 then
            ns.Glyphes[glyphId] = d
        end
        if spellId ~= 0 then
            ns.SpellGlyphes[spellId] = d
        end
    end

    local function Slot(slot, id, level)
        ns.GlyphSlots[slot] = {id = id, level = level}
    end

    setfenv(2, {D = Data, S = Slot})
end
