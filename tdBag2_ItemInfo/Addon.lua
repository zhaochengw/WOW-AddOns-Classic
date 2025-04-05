-- tdBag2_ItemLevel.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 12/30/2020, 12:09:19 AM
--
local Addon = tdBag2
if not Addon then
    return
end

if not Addon.RegisterPlugin or not Addon.SetupPluginOptions then
    return print('You must update tdBag2 to use Item level')
end

local L = LibStub('AceLocale-3.0'):GetLocale('tdBag2')

local PLUGIN = 'ItemLevel'

local tonumber = tonumber
local format = format
local strmatch = strmatch

local C = LibStub('C_Everywhere')

local IsEquippableItem = C_Item.IsEquippableItem
local GetItemInfo = C_Item.GetItemInfo
local GetItemInfoInstant = C_Item.GetItemInfoInstant
local GetItemQualityColor = C_Item.GetItemQualityColor

local BIND_TRADE_TIME_REMAINING_P = BIND_TRADE_TIME_REMAINING:gsub('%%s', '(.+)')
local HOURS_P = FORMATED_HOURS:gsub('%%d', '(%%d+)')
local MINUTES_P = COMMUNITIES_INVITE_MANAGER_EXPIRES:gsub('%%d', '(%%d+)')

local EPIC = Enum.ItemQuality.Epic
local MISC = Enum.ItemClass.Miscellaneous
local LE_ITEM_BIND_ON_EQUIP = LE_ITEM_BIND_ON_EQUIP or Enum.ItemBind.OnEquip

local ITEM_LEVEL_IGNORES = { --
    INVTYPE_BAG = true,
    INVTYPE_AMMO = true,
}

local profile = Addon:RegisterProfile(PLUGIN, {
    showExpireTime = true,
    showBOE = true,
    showItemLevelColor = true,
    showItemLevel = true,
    itemLevelColor = 'Light',
})

local CUSTOM_ITEM_QUALITY_COLORS = {}
CUSTOM_ITEM_QUALITY_COLORS[0] = {r = 0.72, g = 0.72, b = 0.72}
CUSTOM_ITEM_QUALITY_COLORS[1] = {r = 1.0, g = 1.0, b = 1.0}
CUSTOM_ITEM_QUALITY_COLORS[2] = {r = 0.3, g = 1.0, b = 0.38}
CUSTOM_ITEM_QUALITY_COLORS[3] = {r = 0.4, g = 0.71, b = 1.0}
CUSTOM_ITEM_QUALITY_COLORS[4] = {r = 0.97, g = 0.63, b = 0.83}
CUSTOM_ITEM_QUALITY_COLORS[5] = {r = 1, g = 0.602, b = 0.2}
CUSTOM_ITEM_QUALITY_COLORS[6] = {r = 0.94, g = 0.87, b = 0.67}
CUSTOM_ITEM_QUALITY_COLORS[7] = {r = 0.2, g = 0.84, b = 1.0}
CUSTOM_ITEM_QUALITY_COLORS[8] = {r = 0.2, g = 0.84, b = 1.0}

local function Constructor(button)
    local Expire = button.Timeout or _G[button:GetName() .. 'Stock']
    if Expire then
        button.Expire = Expire
    else
        local text = button:CreateFontString(nil, 'OVERLAY', 'NumberFontNormalYellow')
        text:SetPoint('TOPLEFT', 3, -3)

        button.Expire = text
    end
end

local function CanShowItemLevel(item)
    if not profile.showItemLevel then
        return false
    end
    if not item.hasItem then
        return false
    end
    if not IsEquippableItem(item.info.id) then
        return false
    end
    local invType = select(4, GetItemInfoInstant(item.info.id))
    return invType and not ITEM_LEVEL_IGNORES[invType]
end

local function CanShowInfo(item)
    if not item.hasItem then
        return false
    end
    if not item.meta:IsBag() then
        return false
    end
    if item.meta:IsCached() then
        return false
    end
    if IsEquippableItem(item.info.id) then
        return true
    end

    local _, _, quality, _, _, _, _, _, _, _, _, classId = GetItemInfo(item.info.id)
    if quality >= EPIC and classId == MISC then
        return true
    end
    return false
end

local function GetExpireTime(bag, slot)
    local info = C.TooltipInfo.GetBagItem(bag, slot)
    if not info then
        return
    end

    for _, v in ipairs(info.lines) do
        if v.leftText then
            local s = v.leftText:match(BIND_TRADE_TIME_REMAINING_P)
            if s then
                local h = tonumber(strmatch(s, HOURS_P)) or 0
                local m = tonumber(strmatch(s, MINUTES_P)) or 0
                return h * 60 + m
            end
        end
    end
end

local function UpdateItemLevel(item)
    if not CanShowItemLevel(item) then
        return
    end

    local _, _, quality, itemLevel = GetItemInfo(item.info.id)
    if not itemLevel then
        return
    end

    item.Count:Show()
    item.Count:SetText(itemLevel)

    if profile.itemLevelColor == 'White' then
        item.Count:SetTextColor(1, 1, 1)
    elseif profile.itemLevelColor == 'Blizzard' then
        local r, g, b = GetItemQualityColor(quality)
        item.Count:SetTextColor(r, g, b)
    elseif profile.itemLevelColor == 'Light' then
        local color = CUSTOM_ITEM_QUALITY_COLORS[quality]
        item.Count:SetTextColor(color.r, color.g, color.b)
    end
end

local function GetPrecColor(value)
    local r, g, b
    if value > 0.5 then
        r = (1.0 - value) * 2
        g = 1.0
    else
        r = 1.0
        g = value * 2
    end
    b = 0.0
    return r, g, b
end

local function UpdateItemInfo(item)
    item.Expire:Hide()

    if not CanShowInfo(item) then
        return
    end

    if profile.showBOE then
        local bindType = select(14, C.Item.GetItemInfo(item.info.id))
        if bindType == LE_ITEM_BIND_ON_EQUIP then
            local info = C.Container.GetContainerItemInfo(item.bag, item.slot)
            if info and not info.isBound then
                item.Expire:SetText('BoE')
                item.Expire:SetTextColor(0, 1, 1)
                item.Expire:Show()
                return
            end
        end
    end

    if profile.showExpireTime then
        local expire = GetExpireTime(item.bag, item.slot)
        if not expire then
            return
        end

        item.Expire:SetText(format('%dm', expire))
        item.Expire:SetTextColor(GetPrecColor(expire / 120))
        item.Expire:Show()
    end
end

local function UpdateAll(item)
    UpdateItemLevel(item)
    UpdateItemInfo(item)
end

local options = {
    type = 'group',
    name = 'ItemLevel',
    get = function(item)
        return profile[item[#item]]
    end,
    set = function(item, value)
        profile[item[#item]] = value
    end,
    args = {
        showExpireTime = {type = 'toggle', width = 'full', name = L['Show Expire Time'], order = 1},
        showBOE = {type = 'toggle', width = 'full', name = L['Show BoE'], order = 2},
        showItemLevel = {type = 'toggle', width = 'full', name = L['Show Item Level'], order = 3},
        itemLevelColor = {
            type = 'select',
            name = L['Item level color'],
            order = 4,
            values = {White = L['White'], Blizzard = L['Quality by blizzard'], Light = L['Light']},
            sorting = {'White', 'Blizzard', 'Light'},
        },
    },
}

Addon:RegisterPlugin{
    key = PLUGIN,
    text = L['Item info'],
    type = 'Item',
    options = options,
    init = Constructor,
    update = UpdateAll,
}
