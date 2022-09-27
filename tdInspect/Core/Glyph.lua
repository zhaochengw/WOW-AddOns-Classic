-- Glyph.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2022/9/23 10:43:41
--
---@class ns
local ns = select(2, ...)

---@class Glyph: Object
local Glyph = ns.Addon:NewClass('Glyph')

function Glyph:Constructor(data, level)
    self.level = level
    self.data = data
end

function Glyph:GetGlyphSocketInfo(slot)
    local enabled = self.level >= ns.GetGlyphSlotRequireLevel(slot)
    return enabled, ns.GetGlyphInfo(self.data[slot])
end

function Glyph:GetGlyphLink(slot)
    local glyphId = self.data[slot]
    if not glyphId then
        return
    end
    local _, spellId = ns.GetGlyphInfo(glyphId)
    return format('|cff66bbff|Hglyph:%d:%d|h[%s]|h|r', ns.GetGlyphSlotId(slot), glyphId, GetSpellInfo(spellId))
end

function Glyph:GetGlyphId(slot)
    return self.data[slot]
end
