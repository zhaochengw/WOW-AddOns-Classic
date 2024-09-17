-- Api.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2/9/2020, 1:02:09 PM
--
---@class ns
local ns = select(2, ...)

local tonumber = tonumber
local format = string.format

local UnitFullName = UnitFullName

local function memorize(func)
    local cache = {}

    return function(k, ...)
        if not k then
            return
        end
        if not cache[k] then
            cache[k] = func(k, ...)
        end
        return cache[k]
    end
end

ns.memorize = memorize

function ns.strcolor(str, r, g, b)
    return format('|cff%02x%02x%02x%s|r', r * 255, g * 255, b * 255, str)
end

function ns.ItemLinkToId(link)
    return link and (tonumber(link) or tonumber(link:match('item:(%d+)')))
end

ns.GetClassFileName = memorize(function(classId)
    if not classId then
        return
    end
    local classInfo = C_CreatureInfo.GetClassInfo(classId)
    return classInfo and classInfo.classFile
end)

ns.GetClassLocale = memorize(function(classId)
    if not classId then
        return
    end
    local classInfo = C_CreatureInfo.GetClassInfo(classId)
    return classInfo and classInfo.className
end)

ns.GetRaceFileName = memorize(function(raceId)
    if not raceId then
        return
    end
    local raceInfo = C_CreatureInfo.GetRaceInfo(raceId)
    return raceInfo and raceInfo.clientFileString
end)

ns.GetRaceLocale = memorize(function(raceId)
    if not raceId then
        return
    end
    local raceInfo = C_CreatureInfo.GetRaceInfo(raceId)
    return raceInfo and raceInfo.raceName
end)

function ns.GetFullName(name, realm)
    if not name then
        return
    end
    if name:find('-', nil, true) then
        return name
    end

    if not realm or realm == '' then
        realm = GetNormalizedRealmName()
    end
    return name .. '-' .. realm
end

function ns.UnitName(unit)
    return ns.GetFullName(UnitFullName(unit))
end

function ns.FixInspectItemTooltip(tip, slot, item)
    local id = ns.ItemLinkToId(item)
    if not id then
        return
    end

    tip = LibStub('LibTooltipExtra-1.0'):New(tip)

    ns.FixItemSets(tip, id)
    --[[@build<2@
    ns.FixRune(tip, slot, id)
    --@end-build<2@]]
    -- @build>2@
    ns.FixMetaGem(tip, item)
    -- @end-build>2@

    tip:Show()
end

local function FillGem(out, ...)
    for i = 1, select('#', ...) do
        local itemId = tonumber((select(i, ...)))
        if itemId then
            tinsert(out, itemId)
        end
    end
    return out
end

local cache = {}
function ns.GetItemGems(link, out)
    return FillGem(out or wipe(cache), link:match('item:%d+:?[-%d]*:?(%d*):?(%d*):?(%d*):?(%d*)'))
end

function ns.GetItemGem(link, index)
    return tonumber(select(index, link:match('item:%d+:?[-%d]*:?(%d*):?(%d*):?(%d*):?(%d*)')) or nil)
end

function ns.GetGlyphIdBySpellId(spellId)
    local d = ns.SpellGlyphes[spellId]
    return d and d.glyphId
end

function ns.GetGlyphIcon(glyphId)
    local d = ns.Glyphes[glyphId]
    return d and d.icon
end

function ns.GetGlyphInfo(glyphId)
    local d = ns.Glyphes[glyphId]
    if not d then
        return
    end
    return nil, d.spellId, d.icon
end

function ns.ResolveTalent(class, data)
    local talent = ns.Talent:New(class, data)
    return talent:ToString()
end

local function FlagTest(value, flag)
    return bit.band(value, bit.lshift(1, flag)) > 0
end

function ns.GetItemEnchantInfo(link)
    if not link then
        return
    end
    local enchantId = tonumber(link:match('item:%d+:(%d*)'))
    if enchantId then
        local itemId, _, _, _, _, classId, subClassId = GetItemInfoInstant(link)
        local invType = C_Item.GetItemInventoryTypeByID(itemId)

        for _, v in ipairs(ns.ItemEnchants) do
            if v.enchantId == enchantId and v.classId == classId and
                (not v.subClassMask or FlagTest(v.subClassMask, subClassId)) and
                (not v.invTypeMask or FlagTest(v.invTypeMask, invType)) then
                return v
            end
        end
    end
end

local GLYPH_SLOTS = {
    [1] = {id = 21, level = 15},
    [2] = {id = 22, level = 15},
    [3] = {id = 23, level = 50},
    [4] = {id = 24, level = 30},
    [5] = {id = 25, level = 70},
    [6] = {id = 26, level = 80},
}

function ns.GetGlyphSlotRequireLevel(slot)
    local d = GLYPH_SLOTS[slot]
    return d and d.level
end

function ns.GetGlyphSlotId(slot)
    local d = GLYPH_SLOTS[slot]
    return d and d.id
end

local CAN_ENCHANT_EQUIP_LOCS = {
    INVTYPE_HEAD = true,
    INVTYPE_SHOULDER = true,
    INVTYPE_BODY = true,
    INVTYPE_CHEST = true,
    INVTYPE_LEGS = true,
    INVTYPE_FEET = true,
    INVTYPE_WRIST = true,
    INVTYPE_HAND = true,
    INVTYPE_WEAPON = true,
    INVTYPE_SHIELD = true,
    INVTYPE_RANGED = true,
    INVTYPE_CLOAK = true,
    INVTYPE_2HWEAPON = true,
    INVTYPE_ROBE = true,
    INVTYPE_WEAPONMAINHAND = true,
    INVTYPE_WEAPONOFFHAND = true,
}

function ns.IsSpellKnown(spellId)
    return IsSpellKnown(spellId) or IsSpellKnownOrOverridesKnown(spellId) or IsPlayerSpell(spellId) or
               DoesSpellExist(GetSpellInfo(spellId))
end

function ns.IsCanEnchant(item, inspect)
    local itemEquipLoc, _, classId, subClassId = select(4, GetItemInfoInstant(item))
    if itemEquipLoc == 'INVTYPE_RANGEDRIGHT' or itemEquipLoc == 'INVTYPE_RANGED' then
        return classId == Enum.ItemClass.Weapon and
                   (subClassId == Enum.ItemWeaponSubclass.Bows or subClassId == Enum.ItemWeaponSubclass.Guns or
                       subClassId == Enum.ItemWeaponSubclass.Crossbow)
    elseif itemEquipLoc == 'INVTYPE_FINGER' then
        return not inspect and ns.IsSpellKnown(7411) -- 附魔
    end
    return CAN_ENCHANT_EQUIP_LOCS[itemEquipLoc]
end

function ns.IsCanSocket(item, inspect)
    local itemEquipLoc = select(4, GetItemInfoInstant(item))
    if itemEquipLoc == 'INVTYPE_WAIST' then

    elseif itemEquipLoc == 'INVTYPE_WRIST' or itemEquipLoc == 'INVTYPE_HAND' then
        if inspect or not ns.IsSpellKnown(2018) then -- 锻造
            return false
        end
    else
        return false
    end
    local numSockets = ns.GetNumItemSockets(item)
    return not ns.GetItemGem(item, numSockets + 1)
end

function ns.GetNumItemSockets(item)
    local itemId = ns.ItemLinkToId(item)
    local data = ns.ItemGemOrder[itemId]
    return data and #data or 0
end

function ns.GetItemSocket(item, index)
    local itemId = ns.ItemLinkToId(item)
    local data = ns.ItemGemOrder[itemId]
    if data then
        return data[index]
    end
end

function ns.GetSocketColor(socketType)
    if socketType == 2 then
        return 1, 0.2, 0.2
    elseif socketType == 4 then
        return 0.2, 0.8, 0.8
    elseif socketType == 3 then
        return 0.8, 0.8, 0
    elseif socketType == 1 then
        return 1, 1, 1
    else
        return 0.7, 0.7, 0.7
    end
end
