
---------------------------------
-- 經典版物品裝等 Author: M
---------------------------------

local MAJOR, MINOR = "LibItemInfo.1000", 1
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end

local IsMists = select(4, GetBuildInfo()) >= 50000

--物品等級匹配規則
local ItemLevelPattern = gsub(ITEM_LEVEL, "%%d", "(%%d+)")

--Toolip
local tooltip = CreateFrame("GameTooltip", "LibItemLevelScanTooltip", nil, "GameTooltipTemplate")

--物品是否已經本地化
function lib:HasLocalCached(item)
    if (not item or item == "" or item == "0") then return true end
    if (tonumber(item)) then
        return select(10, C_Item.GetItemInfo(tonumber(item)))
    else
        local id, gem1, gem2, gem3 = string.match(item, "item:(%d+):[^:]*:(%d-):(%d-):(%d-):")
        return self:HasLocalCached(id) and self:HasLocalCached(gem1) and self:HasLocalCached(gem2) and self:HasLocalCached(gem3)
    end
end

--獲取物品绿字屬性 (中文用LibItemStats库)
function lib:GetItemStats(link, stats)
    if (type(stats) == "table") then
        local s = GetItemStats(link)
        for k, v in pairs(s) do
            if (stats[k]) then
                if (tonumber(v) and v > 0) then
                    stats[k] = stats[k] + v
                end
            else
                stats[k] = v
            end
        end
    end
    return stats
end

--獲取物品等級
function lib:GetItemLevel(link, stats)
    if (not link or link == "") then
        return -1
    end
    if (not string.match(link, "item:%d+:")) then
        return -1
    end
    self:GetItemStats(link, stats)
    local level = C_Item.GetDetailedItemLevelInfo(link)
    return tonumber(level) or 0
end

if IsMists then
    --獲取容器物品裝等
    function lib:GetContainerItemLevel(pid, id)
        local link = C_Container.GetContainerItemLink(pid, id)
        if (not link or link == "") then
            return -1
        end
        if (pid < 0) then
            return self:GetItemLevel(link), C_Item.GetItemInfo(link)
        end
        local text, level
        if (pid and id) then
            tooltip:SetOwner(UIParent, "ANCHOR_NONE")
            tooltip:SetBagItem(pid, id)
            for i = 2, 5 do
                if (_G[tooltip:GetName() .. "TextLeft" .. i]) then
                    text = _G[tooltip:GetName() .. "TextLeft" .. i]:GetText() or ""
                    level = string.match(text, ItemLevelPattern)
                    if (level) then break end
                end
            end
        end
        return tonumber(level) or 0, C_Item.GetItemInfo(link)
    end

    --獲取UNIT對應部位的物品等級
    function lib:GetUnitItemInfo(unit, index, stats)
        if (not UnitExists(unit)) then return -1 end
        local link = GetInventoryItemLink(unit, index)
        if (not link or link == "") then
            return -1
        end
        tooltip:SetOwner(UIParent, "ANCHOR_NONE")
        tooltip:SetInventoryItem(unit, index)
        local text, level
        for i = 2, 5 do
            if (_G[tooltip:GetName() .. "TextLeft" .. i]) then
                text = _G[tooltip:GetName() .. "TextLeft" .. i]:GetText() or ""
                level = string.match(text, ItemLevelPattern)
                if (level) then break end
            end
        end
        self:GetItemStats(link, stats)
        return tonumber(level) or 0, C_Item.GetItemInfo(link)
    end
else
    --獲取容器物品裝等
    function lib:GetContainerItemLevel(pid, id)
        local link = C_Container.GetContainerItemLink(pid, id)
        return self:GetItemLevel(link), C_Item.GetItemInfo(link)
    end

    --獲取UNIT對應部位的物品等級
    function lib:GetUnitItemInfo(unit, index, stats)
        if (not UnitExists(unit)) then return -1 end
        local link = GetInventoryItemLink(unit, index)
        if (link) then
            return self:GetItemLevel(link, stats), C_Item.GetItemInfo(link)
        else
            return -1
        end
    end
end

--獲取UNIT的裝備等級
--@return 平均装等, 最大武器等级, 最大裝等
function lib:GetUnitItemLevel(unit, stats)
    local total, maxlevel = 0, 0
    local level, mainhand, offhand, ranged
    for i = 1, 15 do
        if (i ~= 4) then
            level = self:GetUnitItemInfo(unit, i, stats)
            if (level > 0) then
                total = total + level
                maxlevel = max(maxlevel, level)
            end
        end
    end
    mainhand = self:GetUnitItemInfo(unit, 16, stats)
    offhand = self:GetUnitItemInfo(unit, 17, stats)
    ranged = self:GetUnitItemInfo(unit, 18, stats)
    if (mainhand <= 0 and ranged <= 0 and ranged <= 0) then
    elseif (mainhand > 0 and offhand > 0) then
        total = total + mainhand + offhand
    --elseif (mainhand > 0 and ranged > 0) then
    --    total = total + mainhand + ranged
    elseif (offhand > 0 and ranged > 0) then
        total = total + offhand + ranged
    else
        total = total + max(mainhand,offhand,ranged) * 2
    end
    return total/16, max(mainhand,offhand), maxlevel
end
