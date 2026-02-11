local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local clientVer, clientBuild, clientDate, clientToc = GetBuildInfo()

-- load only on classic wotlk
if (clientToc == 30400) then
  local LibInspect = LibStub("LibClassicInspector")
  local LibDetours = LibStub("LibDetours-1.0")
  local TinyTooltipGS = TTR_GS
end

local addon = TinyTooltipReforged

local function FindLine(tooltip, keyword)
    local line, text
    for i = 2, tooltip:NumLines() do
        line = _G[tooltip:GetName() .. "TextLeft" .. i]
        text = line:GetText() or ""
        if (string.find(text, keyword)) then
            return line, i, _G[tooltip:GetName() .. "TextRight" .. i]
        end
    end
end

local function ColorBorder(tip, r, g, b)
    if (addon.db.item.coloredItemBorder) then
        LibEvent:trigger("tooltip.style.border.color", tip, r, g, b)
    else
        LibEvent:trigger("tooltip.style.border.color", tip, unpack(addon.db.general.borderColor))
    end
end

local function ItemIcon(tip, link)
    if (addon.db.item.showItemIcon) then
        local texture = select(10, C_Item.GetItemInfo(link))
        local text = addon:GetLine(tip,1):GetText()
        if (texture and not strfind(text, "^|T")) then
            addon:GetLine(tip,1):SetFormattedText("|T%s:16:16:0:0:32:32:2:30:2:30|t %s", texture, text)
        end
    end
end

local stacks = setmetatable({}, {
    __index = function(t,i)
        local _, _, _, _, _, _, _, stack = C_Item.GetItemInfo(i)
        t[i] = stack
        return stack
    end
})

local function ItemStackCount(tip, link)
    if (addon.db.item.showStackCount) then
        local stackCount = select(8, C_Item.GetItemInfo(link))
        if (stackCount and stackCount > 1) then        
            local text = addon:GetLine(tip,1):GetText() .. format(" |cff00eeee/%s|r", stackCount)
            addon:GetLine(tip,1):SetText(text)
        end
    end
    if (addon.db.item.showStackCountAlt) then
        local stack = stacks[link]
        if (stack and stack > 1) then
            tip:Show()
            tip:AddLine(format(addon.L["Stack Size: |cff00eeee%d|r"],stack))
            tip:Show()
        end 
    end
end

LibEvent:attachTrigger("tooltip:item", function(self, tip, link)
    local quality = select(3, C_Item.GetItemInfo(link)) or 0
    local name = select(1, C_Item.GetItemInfo(link)) or 0
    local r, g, b = C_Item.GetItemQualityColor(quality)
    ColorBorder(tip, r, g, b)
    ItemStackCount(tip, link)
    ItemIcon(tip, link)
end)

local function EmbeddedItemTooltip_OnTooltipSetItem(self, data)
    local tip = self:GetParent()
    if (not tip or tip:GetObjectType() ~= "GameTooltip") then return end
    local r, g, b = self.IconBorder:GetVertexColor()
    ColorBorder(self, r, g, b)
end

