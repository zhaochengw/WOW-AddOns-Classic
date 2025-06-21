-- FixRune.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 3/19/2024, 11:55:34 AM
--
---@class ns
local ns = select(2, ...)

local function ToPattern(p)
    p = p:gsub('%%d', '%%d+')
    p = p:gsub('%%s', '.+')
    p = p:gsub('%%c', '[+-]')
    p = '^' .. p .. '$'

    local function match(text)
        if not text then
            return
        end
        local text2 = text:match('|c%x%x%x%x%x%x%x%x(.+)|r')
        if text2 then
            return match(text2)
        end
        return text:find(p)
    end
    return match
end

local ToPattern2 = function(p)
    p = '^' .. p
    return function(text)
        return text:find(p)
    end
end

local FRONTS = {
    ToPattern(ITEM_MIN_LEVEL), ToPattern(ITEM_CLASSES_ALLOWED), ToPattern2(ITEM_SPELL_TRIGGER_ONEQUIP),
    ToPattern2(ITEM_SPELL_TRIGGER_ONPROC), ToPattern2(ITEM_SPELL_TRIGGER_ONUSE),
}

local MODS = {
    ToPattern(ITEM_MOD_AGILITY), ToPattern(ITEM_MOD_HEALTH), ToPattern(ITEM_MOD_INTELLECT), ToPattern(ITEM_MOD_MANA),
    ToPattern(ITEM_MOD_SPIRIT), ToPattern(ITEM_MOD_STAMINA), ToPattern(ITEM_MOD_STRENGTH), ToPattern(ITEM_RESIST_ALL),
    ToPattern(ITEM_RESIST_SINGLE),
}

local function IsAddFrontThisLine(text)
    for i, v in ipairs(FRONTS) do
        if v(text) then
            return true
        end
    end
end

local function IsInMod(text)
    for i, v in ipairs(MODS) do
        if v(text) then
            return true
        end
    end
end

local function ResolveLine(tip)
    local lastModeLine
    for i = 1, tip:NumLines() do
        local text = tip:GetFontStringLeft(i):GetText()
        if text then
            if IsAddFrontThisLine(text) then
                return i
            end
            if IsInMod(text) then
                lastModeLine = i
            end
        end
    end

    if lastModeLine then
        local left = tip:GetFontStringLeft(lastModeLine + 1)
        local r, g, b = left:GetTextColor()
        if r == 0 and g == 1 and b == 0 then
            return lastModeLine + 2
        end
        return lastModeLine + 1
    end
end

function ns.FixRune(tip, slot, id)
    local rune = ns.Inspect:GetItemRune(slot)
    if rune then
        local name = GetSpellInfo(rune.spellId)
        if name then
            local line = ResolveLine(tip)
            if line then
                tip:AppendLineFront(line, ns.strcolor(name, 0, 1, 0))
            end
        end
    end
end
