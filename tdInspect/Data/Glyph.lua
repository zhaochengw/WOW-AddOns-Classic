-- Glyph.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2022/9/25 12:56:20
--
---@class ns
local ns = select(2, ...)

local GLYPH_SLOTS = {
    [1] = { id = 21, level = 15 },
    [2] = { id = 22, level = 15 },
    [3] = { id = 23, level = 50 },
    [4] = { id = 24, level = 30 },
    [5] = { id = 25, level = 70 },
    [6] = { id = 26, level = 80 },
}

function ns.GetGlyphSlotRequireLevel(slot)
    local d = GLYPH_SLOTS[slot]
    return d and d.level
end

function ns.GetGlyphSlotId(slot)
    local d = GLYPH_SLOTS[slot]
    return d and d.id
end
