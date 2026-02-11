
local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local clientVer, clientBuild, clientDate, clientToc = GetBuildInfo()

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
        local texture = select(10, GetItemInfo(link))
        local text = addon:GetLine(tip,1):GetText()
        if (texture and not strfind(text, "^|T")) then
            addon:GetLine(tip,1):SetFormattedText("|T%s:16:16:0:0:32:32:2:30:2:30|t %s", texture, text)
        end
    end
end

local stacks = setmetatable({}, {
    __index = function(t,i)
        local _, _, _, _, _, _, _, stack = GetItemInfo(i)
        t[i] = stack
        return stack
    end
})

local function ItemStackCount(tip, link)
    if (addon.db.item.showStackCount) then
        local stackCount = select(8, GetItemInfo(link))
        if (stackCount and stackCount > 1) then
            local text = addon:GetLine(tip,1):GetText() .. format(" |cff00eeee/%s|r", stackCount)
            addon:GetLine(tip,1):SetText(text)
        end
    end
    if (addon.db.item.showStackCountAlt) then
        local stack = stacks[link]
        if (stack and stack > 1) then
            tip:AddLine(format(addon.L["Stack Size: |cff00eeee%d|r"],stack))
        end 
    end
end

LibEvent:attachTrigger("tooltip:item", function(self, tip, link)
    local quality = select(3, GetItemInfo(link)) or 0
    if (clientToc <= 70100) then
      if (not self) then return end
      if (addon.db.general.showItemLevel) then
          local iName, iLink, iRare, ilvl = GetItemInfo(link)
          local ilvlLine, _, lineRight = FindLine(tip, addon.L["Item Level"])
          local ilvlText = format("%s |cffffffff%d|r", addon.L["Item Level"], tonumber(ilvl))
          if (ilvl and tonumber(ilvl)>1) then 
              if (not ilvlLine) then
                  tip:AddDoubleLine(ilvlText, "")
              else
                  ilvlLine:SetText(ilvlText)
              end 
          end
       end
    else
      local effectiveILvl, isPreview, baseILvl = GetDetailedItemLevelInfo(link)
      if (effectiveILvl and tonumber(effectiveILvl)>1) then
          --tip:AddLine(format("Item Level %d", tonumber(effectiveILvl)))
      end
    end
    local r, g, b = GetItemQualityColor(quality)
    ColorBorder(tip, r, g, b)
    ItemStackCount(tip, link)
    ItemIcon(tip, link)
end)

hooksecurefunc("EmbeddedItemTooltip_OnTooltipSetItem", function(self)
    local tip = self:GetParent()
    if (not tip or tip:GetObjectType() ~= "GameTooltip") then return end
    local r, g, b = self.IconBorder:GetVertexColor()
    ColorBorder(tip, r, g, b)
end)
