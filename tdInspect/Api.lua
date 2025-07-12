-- Api.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2/9/2020, 1:02:09 PM
--
---@class ns
local ns = select(2, ...)

ns.BUILD = tonumber(GetBuildInfo():match('^(%d+)%.'))

ns.LEFT_MOUSE_BUTTON = [[|TInterface\TutorialFrame\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:228:283|t]]
ns.RIGHT_MOUSE_BUTTON = [[|TInterface\TutorialFrame\UI-Tutorial-Frame:12:12:0:0:512:512:10:65:330:385|t]]

ns.MAX_LEVEL = MAX_PLAYER_LEVEL_TABLE[LE_EXPANSION_LEVEL_CURRENT]

ns.DROPDOWN_SEPARATOR = {
    text = '',
    hasArrow = false,
    dist = 0,
    isTitle = true,
    isUninteractable = true,
    notCheckable = true,
    iconOnly = true,
    icon = [[Interface\Common\UI-TooltipDivider-Transparent]],
    tCoordLeft = 0,
    tCoordRight = 1,
    tCoordTop = 0,
    tCoordBottom = 1,
    tSizeX = 0,
    tSizeY = 8,
    tFitDropDownSizeX = true,
    iconInfo = {
        tCoordLeft = 0,
        tCoordRight = 1,
        tCoordTop = 0,
        tCoordBottom = 1,
        tSizeX = 0,
        tSizeY = 8,
        tFitDropDownSizeX = true,
    },
}

local tonumber = tonumber
local format = string.format

local UnitFullName = UnitFullName

local function memorize(func)
    return setmetatable({}, {
        __index = function(t, k)
            if not k then
                return
            end
            local v = func(k)
            t[k] = v
            return v
        end,
        __call = function(t, key)
            return t[key]
        end,
    })
end

ns.memorize = memorize

function ns.strcolor(str, r, g, b)
    return format('|cff%02x%02x%02x%s|r', r * 255, g * 255, b * 255, str)
end

function ns.ItemLinkToId(link)
    return link and (tonumber(link) or tonumber(link:match('item:(%d+)')))
end

ns.GetClassFileName = memorize(function(classId)
    if not classId then
        return
    end
    local classInfo = C_CreatureInfo.GetClassInfo(classId)
    return classInfo and classInfo.classFile
end)

ns.GetClassLocale = memorize(function(classId)
    if not classId then
        return
    end
    local classInfo = C_CreatureInfo.GetClassInfo(classId)
    return classInfo and classInfo.className
end)

ns.GetRaceFileName = memorize(function(raceId)
    if not raceId then
        return
    end
    local raceInfo = C_CreatureInfo.GetRaceInfo(raceId)
    return raceInfo and raceInfo.clientFileString
end)

ns.GetRaceLocale = memorize(function(raceId)
    if not raceId then
        return
    end
    local raceInfo = C_CreatureInfo.GetRaceInfo(raceId)
    return raceInfo and raceInfo.raceName
end)

function ns.GetFullName(name, realm)
    if not name then
        return
    end
    if name:find('-', nil, true) then
        return name
    end

    if not realm or realm == '' then
        realm = GetNormalizedRealmName()
    end
    if not realm or realm == '' then
        realm = GetRealmName():gsub(' +', '')
    end
    return name .. '-' .. realm
end

---@return string
function ns.UnitName(unit)
    return ns.GetFullName(UnitFullName(unit))
end

local IsOurRealm = ns.memorize(function(realm)
    local realms = GetAutoCompleteRealms()
    for _, v in ipairs(realms) do
        if v == realm then
            return true
        end
    end
    return realm == realm == GetNormalizedRealmName() or realm == GetRealmName():gsub(' +', '')
end)

function ns.IsPlayerInOurRealm(name)
    return IsOurRealm(select(2, strsplit('-', name)))
end

function ns.FixInspectItemTooltip(tip, slot, item)
    local id = ns.ItemLinkToId(item)
    if not id then
        return
    end

    tip = LibStub('LibTooltipExtra-1.0'):New(tip)

    ns.FixItemSets(tip, id)

    if ns.BUILD == 1 then
        ns.FixRune(tip, slot, id)
    end
    if ns.BUILD >= 2 then
        ns.FixMetaGem(tip, item)
    end

    tip:Show()
end

local function FillGem(out, ...)
    for i = 1, select('#', ...) do
        local itemId = tonumber((select(i, ...)))
        if itemId then
            tinsert(out, itemId)
        end
    end
    return out
end

local cache = {}
function ns.GetItemGems(link, out)
    return FillGem(out or wipe(cache), link:match('item:%d+:?[-%d]*:?(%d*):?(%d*):?(%d*):?(%d*)'))
end

function ns.GetItemGem(link, index)
    return tonumber(select(index, link:match('item:%d+:?[-%d]*:?(%d*):?(%d*):?(%d*):?(%d*)')) or nil)
end

function ns.GetGlyphIdBySpellId(spellId)
    local d = ns.SpellGlyphes[spellId]
    return d and d.glyphId
end

function ns.GetGlyphIcon(glyphId)
    local d = ns.Glyphes[glyphId]
    return d and d.icon
end

function ns.GetGlyphInfo(glyphId)
    local d = ns.Glyphes[glyphId]
    if not d then
        return
    end
    return nil, d.spellId, d.icon
end

function ns.ResolveTalent(class, data)
    local talent = ns.Talent:New(class, data)
    return talent:ToString()
end

local function FlagTest(value, flag)
    return bit.band(value, bit.lshift(1, flag)) > 0
end

function ns.GetItemEnchantInfo(link)
    if not link then
        return
    end
    local enchantId = tonumber(link:match('item:%d+:(%d*)'))
    if enchantId then
        local itemId, _, _, _, _, classId, subClassId = GetItemInfoInstant(link)
        local invType = C_Item.GetItemInventoryTypeByID(itemId)

        for _, v in ipairs(ns.ItemEnchants) do
            if v.enchantId == enchantId and v.classId == classId and
                (not v.subClassMask or FlagTest(v.subClassMask, subClassId)) and
                (not v.invTypeMask or FlagTest(v.invTypeMask, invType)) then
                return v
            end
        end
    end
end

local GLYPH_SLOTS = {
    [1] = {id = 21, level = 15},
    [2] = {id = 22, level = 15},
    [3] = {id = 23, level = 50},
    [4] = {id = 24, level = 30},
    [5] = {id = 25, level = 70},
    [6] = {id = 26, level = 80},
}

function ns.GetGlyphSlotRequireLevel(slot)
    local d = GLYPH_SLOTS[slot]
    return d and d.level
end

function ns.GetGlyphSlotId(slot)
    local d = GLYPH_SLOTS[slot]
    return d and d.id
end

local CAN_ENCHANT_EQUIP_LOCS = {
    INVTYPE_HEAD = true,
    INVTYPE_SHOULDER = true,
    INVTYPE_BODY = true,
    INVTYPE_CHEST = true,
    INVTYPE_LEGS = true,
    INVTYPE_FEET = true,
    INVTYPE_WRIST = true,
    INVTYPE_HAND = true,
    INVTYPE_WEAPON = true,
    INVTYPE_SHIELD = true,
    INVTYPE_RANGED = true,
    INVTYPE_CLOAK = true,
    INVTYPE_2HWEAPON = true,
    INVTYPE_ROBE = true,
    INVTYPE_WEAPONMAINHAND = true,
    INVTYPE_WEAPONOFFHAND = true,
}

local CAN_ENCHANT_RANGED = {
    [Enum.ItemWeaponSubclass.Bows] = true,
    [Enum.ItemWeaponSubclass.Guns] = true,
    [Enum.ItemWeaponSubclass.Crossbow] = true,
}

function ns.IsSpellKnown(spellId)
    return IsSpellKnown(spellId) or IsSpellKnownOrOverridesKnown(spellId) or IsPlayerSpell(spellId) or
               DoesSpellExist(GetSpellInfo(spellId))
end

function ns.IsCanEnchant(item, inspect)
    local itemEquipLoc, _, classId, subClassId = select(4, GetItemInfoInstant(item))
    if itemEquipLoc == 'INVTYPE_RANGEDRIGHT' or itemEquipLoc == 'INVTYPE_RANGED' then
        if classId ~= Enum.ItemClass.Weapon or not CAN_ENCHANT_RANGED[subClassId] then
            return false
        end
        if ns.db.profile.showRangedEnchantOnlyHunter then
            local class
            if inspect then
                class = ns.Inspect:GetUnitClassFileName()
            else
                class = UnitClassBase('player')
            end
            return class == 'HUNTER'
        end
        return true
    elseif itemEquipLoc == 'INVTYPE_FINGER' then
        return not inspect and ns.IsSpellKnown(7411) -- 附魔
    end
    return CAN_ENCHANT_EQUIP_LOCS[itemEquipLoc]
end

if ns.BUILD >= 2 then
    function ns.IsCanSocket(item, inspect)
        local itemEquipLoc = select(4, GetItemInfoInstant(item))
        if itemEquipLoc == 'INVTYPE_WAIST' then

        elseif itemEquipLoc == 'INVTYPE_WRIST' or itemEquipLoc == 'INVTYPE_HAND' then
            if inspect or not ns.IsSpellKnown(2018) then -- 锻造
                return false
            end
        else
            return false
        end
        local numSockets = ns.GetNumItemSockets(item)
        return not ns.GetItemGem(item, numSockets + 1)
    end
else
    function ns.IsCanSocket()
        return false
    end
end

function ns.GetNumItemSockets(item)
    local itemId = ns.ItemLinkToId(item)
    local data = ns.ItemGemOrder[itemId]
    return data and #data or 0
end

function ns.GetItemSocket(item, index)
    local itemId = ns.ItemLinkToId(item)
    local data = ns.ItemGemOrder[itemId]
    if data then
        return data[index]
    end
end

function ns.GetSocketColor(socketType)
    if socketType == 2 then -- 红孔
        return 1, 0.2, 0.2
    elseif socketType == 4 then -- 蓝孔
        return 0.2, 0.8, 0.8
    elseif socketType == 3 then -- 黄孔
        return 0.8, 0.8, 0
    elseif socketType == 1 then -- 多彩
        return 1, 1, 1
    else
        return 0.7, 0.7, 0.7
    end
end

ns.GetTalentTabInfo = function(...)
    local id, name, description, icon, pointsSpent, background, previewPointsSpent, isUnlocked = GetTalentTabInfo(...)
    return name, icon, pointsSpent, background
end

do
    local menu
    function ns.CallMenu(anchor, menuList)
        if not menu then
            menu = CreateFrame('Frame', 'tdInspectDropdown', UIParent, 'UIDropDownMenuTemplate')
        end

        menu.displayMode = 'MENU'
        menu.initialize = EasyMenu_Initialize
        menu.relativeTo = anchor
        CloseDropDownMenus()
        ToggleDropDownMenu(1, nil, menu, anchor, 0, 0, menuList)
    end

    function ns.CloseMenu(anchor)
        if not menu then
            return
        end
        if not DropDownList1:IsShown() then
            return
        end
        if menu ~= UIDROPDOWNMENU_OPEN_MENU then
            return
        end
        if menu.relativeTo == anchor then
            CloseDropDownMenus()
            return true
        end
    end
end

function ns.CopyDefaults(dest, src)
    dest = dest or {}
    for k, v in pairs(src) do
        if type(v) == 'table' then
            dest[k] = ns.CopyDefaults(dest[k], v)
        elseif dest[k] == nil then
            dest[k] = v
        end
    end
    return dest
end

function ns.ShowBlizzardInventoryItem(unit, id)
    if not unit then
        return
    end
    local link = GetInventoryItemLink(unit, id)
    if not link then
        return
    end
    local ok = GameTooltip:SetInventoryItem(unit, id)
    if not ok then
        return
    end
    ns.FixInspectItemTooltip(GameTooltip, id, link)
    return true
end

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
ns.CUSTOM_ITEM_QUALITY_COLORS = CUSTOM_ITEM_QUALITY_COLORS
