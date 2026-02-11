
local LibEvent = LibStub:GetLibrary("LibEvent.7000")

local addon = TinyTooltipReforged

local function ColorBorder(tip)
    if (addon.db.spell.borderColor) then
        LibEvent:trigger("tooltip.style.border.color", tip, unpack(addon.db.spell.borderColor))
    end
end

local function ColorBackground(tip)
    if (addon.db.spell.background) then
        LibEvent:trigger("tooltip.style.background", tip, unpack(addon.db.spell.background))
    end
end

local function SpellIcon(tip)
    if (addon.db.spell.showIcon) then
        if not pcall(function() select(2, tip:GetSpell()) end) then return end
        local id = select(2, tip:GetSpell())
        local texture = C_Spell.GetSpellTexture(id or 0)
        local text = addon:GetLine(tip,1):GetText()
        if (texture and not strfind(text, "^|T")) then
            addon:GetLine(tip,1):SetFormattedText("|T%s:16:16:0:0:32:32:2:30:2:30|t %s", texture, text)
        end
    end
end

LibEvent:attachTrigger("tooltip:spell", function(self, tip)
    if (tip ~= GameTooltip) then return end
    SpellIcon(tip)
    ColorBorder(tip)
    ColorBackground(tip)
end)
