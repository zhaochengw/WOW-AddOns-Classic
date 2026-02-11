
local LibEvent = LibStub:GetLibrary("LibEvent.7000")

local addon = TinyTooltipReforged

local function ColorBorder(tip, r, g, b)
    if (addon.db.quest.coloredQuestBorder) then
        LibEvent:trigger("tooltip.style.border.color", tip, r, g, b)
    end
end

hooksecurefunc(ItemRefTooltip, "SetHyperlink", function(self, link)
    local schema, id = string.match(link, "|?H?(%a+):(%d+):([%-%d]+)")
    if (schema and schema == "quest") then
        local level = C_QuestLog.GetQuestDifficultyLevel(id)
        local color = GetQuestDifficultyColor(level < 0 and UnitLevel("player") or level)
        ColorBorder(self, color.r, color.g, color.b)
    end
end)


