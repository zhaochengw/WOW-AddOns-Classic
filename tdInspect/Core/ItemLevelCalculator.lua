-- ItemLevel.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/4/2024, 11:42:34 AM
--
---@class ns
local ns = select(2, ...)

local ipairs = ipairs
local select = select
local max, min = math.max, math.min

---@class ItemLevelCalculator
local ItemLevelCalculator = ns.Addon:NewClass('ItemLevelCalculator')

local SLOTS = {
    INVSLOT_HEAD, INVSLOT_NECK, INVSLOT_SHOULDER, INVSLOT_CHEST, INVSLOT_WAIST, INVSLOT_LEGS, INVSLOT_FEET,
    INVSLOT_WRIST, INVSLOT_HAND, INVSLOT_FINGER1, INVSLOT_FINGER2, INVSLOT_TRINKET1, INVSLOT_TRINKET2, INVSLOT_BACK,
}
local DOUBLE_ITEM_LEVEL_RANGED = {
    [Enum.ItemWeaponSubclass.Guns] = true,
    [Enum.ItemWeaponSubclass.Bows] = true,
    [Enum.ItemWeaponSubclass.Crossbow] = true,
}

function ItemLevelCalculator:Constructor(fn)
    self.fn = fn
end

function ItemLevelCalculator:GetItemLevel()
    local level = 0
    for _, slot in ipairs(SLOTS) do
        local itemLevel = self:GetSlotInfo(slot)
        if not itemLevel then
            return
        end
        level = level + itemLevel
    end

    do
        local itemLevel = self:GetWeaponItemLevel()
        if not itemLevel then
            return
        end
        level = level + itemLevel
    end

    return level / 16
end

function ItemLevelCalculator:GetSlotInfo(slot)
    local item = self.fn(slot)
    if not item then
        return 0
    end

    local itemLevel, _, _, _, _, itemEquipLoc, _, _, _, subClassId = select(4, GetItemInfo(item))
    if itemLevel then
        return itemLevel, itemEquipLoc, subClassId
    end
end

local function IsSingle(itemEquipLoc)
    return not itemEquipLoc or itemEquipLoc == 'INVTYPE_WEAPON' or itemEquipLoc == 'INVTYPE_HOLDABLE' or itemEquipLoc ==
               'INVTYPE_WEAPONOFFHAND'
end

function ItemLevelCalculator:GetWeaponItemLevel()
    do
        local itemLevelMain, itemEquipLocMain, subClassIdMain = self:GetSlotInfo(INVSLOT_MAINHAND)
        local itemLevelOff, itemEquipLocOff, subClassIdOff = self:GetSlotInfo(INVSLOT_OFFHAND)
        local itemLevelRanged, itemEquipLocRanged, subClassIdRanged = self:GetSlotInfo(INVSLOT_RANGED)
        if not itemLevelMain or not itemLevelOff or not itemLevelRanged then
            return
        end

        if itemEquipLocOff == 'INVTYPE_HOLDABLE' and subClassIdRanged == Enum.ItemWeaponSubclass.Wand then
            return itemLevelOff + max(itemLevelMain, itemLevelRanged)
        end

        if subClassIdRanged == Enum.ItemWeaponSubclass.Thrown and IsSingle(itemEquipLocMain) and
            IsSingle(itemEquipLocOff) then
            return itemLevelMain + itemLevelOff + itemLevelRanged - min(itemLevelMain, itemLevelOff, itemLevelRanged)
        end
    end

    do
        local itemLevelMainOff = self:GetMainOffItemLevel()
        local itemLevelRanged = self:GetRangedItemLevel()
        if not itemLevelMainOff or not itemLevelRanged then
            return
        end
        return max(itemLevelMainOff, itemLevelRanged)
    end
end

function ItemLevelCalculator:GetMainOffItemLevel()
    local itemLevel, itemEquipLoc = self:GetSlotInfo(INVSLOT_MAINHAND)
    local itemLevelOff, itemEquipLocOff = self:GetSlotInfo(INVSLOT_OFFHAND)
    if not itemLevel or not itemLevelOff then
        return
    end

    if itemEquipLoc == 'INVTYPE_2HWEAPON' or itemEquipLocOff == 'INVTYPE_2HWEAPON' then
        if itemEquipLoc == itemEquipLocOff then
            return max(itemLevel, itemLevelOff) * 2
        elseif itemEquipLoc == 'INVTYPE_2HWEAPON' then
            if itemLevel > itemLevelOff then
                return itemLevel * 2
            else
                return itemLevel + itemLevelOff
            end
        elseif itemEquipLocOff == 'INVTYPE_2HWEAPON' then
            if itemLevelOff > itemLevel then
                return itemLevelOff * 2
            else
                return itemLevel + itemLevelOff
            end
        end
    else
        return itemLevel + itemLevelOff
    end
end

function ItemLevelCalculator:GetRangedItemLevel()
    local itemLevel, itemEquipLoc, subClassId = self:GetSlotInfo(INVSLOT_RANGED)
    if not itemLevel then
        return
    end
    if itemEquipLoc == 'INVTYPE_THROWN' then
        return itemLevel
    elseif itemEquipLoc == 'INVTYPE_RANGED' or itemEquipLoc == 'INVTYPE_RANGEDRIGHT' then
        if DOUBLE_ITEM_LEVEL_RANGED[subClassId] then
            return itemLevel * 2
        else
            return itemLevel
        end
    else
        return 0
    end
end
