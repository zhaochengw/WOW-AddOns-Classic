-- Api.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/30/2019, 11:46:11 PM
--
local tinsert = table.insert

---@class ns
---@field UI UI
---@field Addon Addon
---@field Base Addon.Base
---@field Item Addon.Item
---@field Bag Addon.Bag
---@field Slot Addon.Slot
---@field Group Addon.Group
---@field Pack Addon.Pack
---@field Rule Addon.Rule
---@field Order Addon.Order
---@field Task Addon.Task
---@field CachableOrder Addon.CachableOrder
---@field CustomOrder Addon.CustomOrder
---@field ItemInfoCache Addon.ItemInfoCache
---@field Saving Addon.Saving
---@field Stacking Addon.Stacking
---@field Sorting Addon.Sorting
---@field Search Addon.Search
---@field ItemInfo Addon.ItemInfo
---@field JunkOrder Addon.JunkOrder
local ns = select(2, ...)

local C = LibStub('C_Everywhere')
ns.C = C

---- LUA
local select, type, ipairs = select, type, ipairs
local format = string.format
local tonumber = tonumber

---- WOW
local GetCursorPosition = GetCursorPosition

local KEYRING_CONTAINER = Enum.BagIndex.Keyring

---- UI
local UIParent = UIParent

ns.VERSION = tonumber((C.AddOns.GetAddOnMetadata('tdPack2', 'Version'):gsub('(%d+)%.?', function(x)
    return format('%02d', tonumber(x))
end))) or 0

---- ENUM
ns.BAG_TYPE = {
    BAG = 'bag', --
    BANK = 'bank', --
}

ns.BAG_TYPES = {
    ns.BAG_TYPE.BAG, --
    ns.BAG_TYPE.BANK, --
}

ns.COMMAND = {
    ALL = 'all', --
    BAG = 'bag', --
    BANK = 'bank', --
}

ns.EXTRA_COMMAND = {
    SAVE = 'save', --
}

ns.ORDER = {
    ASC = 'asc', --
    DESC = 'desc', --
}

ns.SORT_TYPE = {
    SORTING = 1, --
    SAVING = 2, --
}

function ns.memorize(func)
    local cache = {}
    return function(arg1, ...)
        local value = cache[arg1]
        if value == nil then
            value = func(arg1, ...)
            cache[arg1] = value
        end
        return value
    end
end

local BAGS = { --
    [ns.BAG_TYPE.BAG] = {Enum.BagIndex.Backpack}, --
    [ns.BAG_TYPE.BANK] = {Enum.BagIndex.Bank}, --
}
local BAG_SETS = {}

do
    local NUM_BAG_SLOTS = Constants.InventoryConstants.NumBagSlots
    local NUM_BANKBAGSLOTS = Constants.InventoryConstants.NumBankBagSlots

    for i = 1, NUM_BAG_SLOTS do
        tinsert(BAGS[ns.BAG_TYPE.BAG], i)
    end

    for i = 1, NUM_BANKBAGSLOTS do
        tinsert(BAGS[ns.BAG_TYPE.BANK], i + NUM_BAG_SLOTS)
    end

    tinsert(BAGS[ns.BAG_TYPE.BAG], KEYRING_CONTAINER)

    for bagType, v in pairs(BAGS) do
        for _, bagId in pairs(v) do
            BAG_SETS[bagId] = bagType
        end
    end
end

function ns.IsBag(id)
    return BAG_SETS[id] == ns.BAG_TYPE.BAG
end

function ns.IsBank(id)
    return BAG_SETS[id] == ns.BAG_TYPE.BANK
end

function ns.GetBags(bagType)
    return BAGS[bagType]
end

function ns.GetItemFamily(itemId)
    if not itemId then
        return 0
    end
    if type(itemId) == 'string' then
        return 0
    end
    if select(4, C.Item.GetItemInfoInstant(itemId)) == 'INVTYPE_BAG' then
        return 0
    end
    local itemFamily = C.Item.GetItemFamily(itemId)
    return itemFamily
end

function ns.GetBagFamily(bag)
    --[[@build<2@
    if bag == KEYRING_CONTAINER then
        return 9
    end
    --@end-build<2@]]
    -- @build>2@
    if bag == KEYRING_CONTAINER then
        return 256
    end
    -- @end-build>2@

    -- 3.4 GetContainerNumFreeSlots 接口有bug，专业包可能取到0
    if bag > 0 then
        local invId = C.Container.ContainerIDToInventoryID(bag)
        local itemId = GetInventoryItemID('player', invId)
        if itemId then
            local itemFamily = C.Item.GetItemFamily(itemId)
            if itemFamily then
                return itemFamily
            end
            return nil
        else
            return 0
        end
    end

    return select(2, C.Container.GetContainerNumFreeSlots(bag))
end

function ns.GetBagNumSlots(bag)
    return C.Container.GetContainerNumSlots(bag)
end

function ns.GetItemId(itemLink)
    if not itemLink then
        return
    end

    if itemLink:find('battlepet') then
        local id, level, quality = itemLink:match('battlepet:(%d+):(%d+):(%d+)')

        return (('battlepet:%d:%d:%d'):format(id, level, quality))
    else
        return (tonumber(itemLink:match('item:(%d+)')))
    end
end

function ns.GetBagSlotLink(bag, slot)
    return C.Container.GetContainerItemLink(bag, slot)
end

function ns.GetBagSlotId(bag, slot)
    local itemLink = C.Container.GetContainerItemLink(bag, slot)
    if not itemLink then
        return
    end
    return ns.GetItemId(itemLink)
end

function ns.IsBagSlotEmpty(bag, slot)
    return not C.Container.GetContainerItemID(bag, slot)
end

function ns.IsBagSlotFull(bag, slot)
    local itemId = C.Container.GetContainerItemID(bag, slot)
    if not itemId then
        return false
    end

    local info = ns.ItemInfoCache:Get(itemId)
    local stackCount = info.itemStackCount or 1
    return stackCount == 1 or stackCount == ns.GetBagSlotCount(bag, slot)
end

function ns.GetBagSlotCount(bag, slot)
    local info = C.Container.GetContainerItemInfo(bag, slot)
    return info and info.stackCount
end

function ns.GetBagSlotFamily(bag, slot)
    return ns.GetItemFamily(ns.GetBagSlotId(bag, slot))
end

function ns.IsBagSlotLocked(bag, slot)
    local info = C.Container.GetContainerItemInfo(bag, slot)
    return info and info.isLocked
end

function ns.PickupBagSlot(bag, slot)
    return C.Container.PickupContainerItem(bag, slot)
end

--[[@build<2@
function ns.IsFamilyContains(bagFamily, itemFamily)
    return bagFamily == itemFamily
end
--@end-build<2@]]

-- @build>2@
local band = bit.band
function ns.IsFamilyContains(bagFamily, itemFamily)
    return band(bagFamily, itemFamily) > 0
end
-- @end-build>2@

function ns.GetClickToken(button, control, shift, alt)
    local key
    if button == 'LeftButton' then
        key = 1
    elseif button == 'RightButton' then
        key = 2
    end

    return key + (control and 0x10000 or 0) + (shift and 0x20000 or 0) + (alt and 0x40000 or 0)
end

function ns.GetCursorPosition()
    local x, y = GetCursorPosition()
    local scale = UIParent:GetScale()
    return x / scale, y / scale
end

function ns.CopyFrom(dest, src)
    dest = dest or {}
    for k, v in pairs(src) do
        if type(v) == 'table' then
            dest[k] = ns.CopyFrom({}, v)
        else
            dest[k] = v
        end
    end
    return dest
end

function ns.GetRuleInfo(item)
    local t = type(item)
    if t == 'number' then
        local name, color
        local icon = C.Item.GetItemIconByID(item)
        local info = ns.ItemInfoCache:Get(item)
        if info:IsReady() then
            name = info.itemName
            color = select(4, C.Item.GetItemQualityColor(info.itemQuality))
        else
            name = RETRIEVING_ITEM_INFO
            color = RED_FONT_COLOR:GenerateHexColor()
        end
        return format('|c%s%s|r', color, name), icon
    elseif t == 'table' then
        local name, rule
        if item.comment then
            name = item.comment
            rule = item.rule
        else
            name = item.rule
            rule = item.rule
        end
        return name, item.icon or ns.UNKNOWN_ICON, rule, item.children and #item.children > 0
    end
end

function ns.IsAdvanceRule(item)
    return type(item) == 'table'
end

local function Initialize(_, level, menuList)
    for i, v in ipairs(menuList) do
        if v.isSeparator then
            UIDropDownMenu_AddSeparator(level)
        elseif v.text then
            v.index = i;
            UIDropDownMenu_AddButton(v, level);
        end
    end
end

local menuFrame
local function CreateGlobalMenuFrame()
    menuFrame = CreateFrame('Frame', 'tdGlobalMenuFrame', UIParent, 'UIDropDownMenuTemplate')
    menuFrame.initialize = Initialize
    menuFrame.displayMode = 'MENU'
    return menuFrame
end

function ns.ToggleMenu(owner, menuList)
    local frame = menuFrame or CreateGlobalMenuFrame()

    if DropDownList1:IsShown() and UIDROPDOWNMENU_OPEN_MENU == frame and frame.LastOwner == owner then
        CloseDropDownMenus()
    else
        frame.LastOwner = owner
        CloseDropDownMenus()
        ToggleDropDownMenu(1, nil, frame, owner, 0, 0, menuList)
    end
end

function ns.override(o, m, f)
    local orig = assert(o[m])
    o[m] = function(...)
        return f(orig, ...)
    end
end
