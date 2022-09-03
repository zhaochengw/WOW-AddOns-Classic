-- Api.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2/9/2020, 1:02:09 PM
--
---@class ns
local ns = select(2, ...)

local ipairs = ipairs
local tonumber = tonumber
local format = string.format

local GetItemInfo = GetItemInfo
local GetRealmName = GetRealmName
local UnitFullName = UnitFullName

local SPELL_PASSIVE = SPELL_PASSIVE

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

function ns.FixInspectItemTooltip(tip)
    local link = select(2, tip:GetItem())
    local id = ns.ItemLinkToId(link)
    if not id then
        return
    end

    tip = LibStub('LibTooltipExtra-1.0'):New(tip)

    ns.FixItemSets(tip, id)
    -- @non-classic@
    ns.FixMetaGem(tip, link)
    -- @end-non-classic@

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
    return FillGem(out or wipe(cache), link:match('item:%d+:[-%d]*:(%d*):(%d*):(%d*):(%d*):'))
end
