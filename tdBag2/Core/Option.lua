-- Option.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/23/2019, 3:14:52 PM
---- LUA
local ipairs, pairs = ipairs, pairs
local format = string.format
local wipe = table.wipe or wipe
local type = type

---@type ns
local ns = select(2, ...)
local Addon = ns.Addon
local L = ns.L

local AceConfigRegistry = LibStub('AceConfigRegistry-3.0')
local AceConfigDialog = LibStub('AceConfigDialog-3.0')

local BAG_ARGS = { --
    [ns.BAG_ID.BAG] = {},
    [ns.BAG_ID.BANK] = {},
}
local STYLES = {}

function Addon:SetupOptionFrame()
    local order = 0
    local function orderGen()
        order = order + 1
        return order
    end

    local function toggle(name)
        return {type = 'toggle', name = name, order = orderGen()}
    end

    local function fullToggle(name)
        return {type = 'toggle', name = name, width = 'full', order = orderGen()}
    end

    local function color(name)
        return {type = 'color', name = name, order = orderGen()}
    end

    local function range(name, min, max, step)
        return {type = 'range', order = orderGen(), name = name, min = min, max = max, step = step}
    end

    local function fullRange(name, min, max, step)
        return {type = 'range', width = 'full', order = orderGen(), name = name, min = min, max = max, step = step}
    end

    local function header(name)
        return {type = 'header', order = orderGen(), name = name}
    end

    local function line()
        return header('')
    end

    local function desc(name)
        return {
            type = 'description',
            order = orderGen(),
            name = name,
            fontSize = 'medium',
            image = [[Interface\Common\help-i]],
            imageWidth = 32,
            imageHeight = 32,
            imageCoords = {.2, .8, .2, .8},
        }
    end

    local function warning(name)
        return {
            type = 'description',
            order = orderGen(),
            name = '|cffff0000' .. name .. '|r',
            fontSize = 'medium',
            image = [[Interface\DialogFrame\UI-Dialog-Icon-AlertNew]],
            imageWidth = 32,
            imageHeight = 32,
            -- imageCoords = {.2, .8, .2, .8},
        }
    end

    local function separator()
        return {type = 'description', order = orderGen(), name = '\n', fontSize = 'medium'}
    end

    local function drop(name, values)
        local opts = { --
            type = 'select',
            name = name,
            order = orderGen(),
        }

        if type(values) == 'function' then
            opts.values = values
        else
            opts.values = {}
            opts.sorting = {}

            for i, v in ipairs(values) do
                opts.values[v.value] = v.name
                opts.sorting[i] = v.value
            end
        end
        return opts
    end

    local function group(name, args)
        return {type = 'group', name = name, order = orderGen(), args = args}
    end

    local function inline(name, args)
        return {type = 'group', name = name, inline = true, order = orderGen(), args = args}
    end

    local function tab(name, args)
        return {type = 'group', name = name, childGroups = 'tab', order = orderGen(), args = args}
    end

    local function treeTitle(name)
        return {type = 'group', name = '|cffffd100' .. name .. '|r', order = orderGen(), args = {}, disabled = true}
    end

    local function treeItem(name, args)
        return {type = 'group', name = '  |cffffffff' .. name .. '|r', order = orderGen(), args = args}
    end

    local function baseFrame(bagId, name, args)
        return {
            type = 'group',
            name = '  |cffffffff' .. name .. '|r',
            order = orderGen(),
            set = function(item, value)
                local key = item[#item]
                local meta = self:GetFrameMeta(bagId)
                if meta then
                    meta:SetOption(key, value)
                else
                    self.db.profile.frames[bagId][key] = value
                end
            end,
            get = function(item)
                return self.db.profile.frames[bagId][item[#item]]
            end,
            args = args,
        }
    end

    local function frame(bagId, name)
        return baseFrame(bagId, name, {
            desc = desc(format(L.DESC_FRAMES, name)),
            appearance = inline(L['Appearance'], { --
                managed = toggle(L['Blizzard Panel']),
                iconCharacter = toggle(L['Show Character Portrait']),
                reverseBag = toggle(L['Reverse Bag Order']),
                reverseSlot = toggle(L['Reverse Slot Order']),
                column = range(L['Columns'], 6, 36, 1),
                scale = range(L['Item Scale'], 0.5, 2),
                tradeBagOrder = drop(L['Trade Containers Location'], {
                    {name = L['Default'], value = ns.TRADE_BAG_ORDER.NONE},
                    {name = L['Top'], value = ns.TRADE_BAG_ORDER.TOP},
                    {name = L['Bottom'], value = ns.TRADE_BAG_ORDER.BOTTOM},
                }),
            }),
            features = inline(L['Features'], { --
                tokenFrame = toggle(L['Watch Frame']),
                bagFrame = toggle(L['Bag Frame']),
                pluginButtons = toggle(L['Plugin Buttons']),
            }),
            buttons = {
                type = 'group',
                inline = true,
                name = L['Plugin Buttons'],
                order = orderGen(),
                hidden = function()
                    return not self.db.profile.frames[bagId].pluginButtons
                end,
                set = function(item, value)
                    self.db.profile.frames[bagId].disableButtons[item[#item]] = not value
                    ns.Events:FireFrame('PLUGIN_BUTTON_UPDATE', bagId)
                end,
                get = function(item)
                    return not self.db.profile.frames[bagId].disableButtons[item[#item]]
                end,
                args = BAG_ARGS[bagId],
            },
        })
    end

    local function fireGlobalKey(key)
        local event = ns.OPTION_EVENTS[key]
        local t = type(event)
        if t == 'string' then
            ns.Events:Fire(event)
        elseif t == 'function' then
            event()
        end
    end

    local function daysValue(days)
        return {name = L['Less than %s days']:format(days), value = days}
    end

    local playerProfileKey = ns.GetCharacterProfileKey(ns.PLAYER, ns.REALM)

    local options = {
        type = 'group',
        get = function(item)
            return self.db.profile[item[#item]]
        end,
        set = function(item, value)
            local key = item[#item]
            self.db.profile[item[#item]] = value
            fireGlobalKey(key)
        end,
        args = {
            profile = {
                type = 'toggle',
                name = L['Character Specific Settings'],
                width = 'double',
                order = orderGen(),
                set = function(_, checked)
                    self.db:SetProfile(checked and playerProfileKey or 'Default')
                end,
                get = function()
                    return self.db:GetCurrentProfile() == playerProfileKey
                end,
            },
            reset = {
                type = 'execute',
                name = L['Restore default Settings'],
                order = orderGen(),
                confirm = true,
                confirmText = L['Are you sure you want to restore the current Settings?'],
                func = function()
                    self.db:ResetProfile()
                end,
            },
            header1 = line(),
            reload = {
                type = 'group',
                name = RELOADUI,
                inline = true,
                order = orderGen(),
                hidden = function()
                    return not (self.styleName ~= self.db.profile.style and self.db.profile.style ~=
                               self.styleInProfileLosed)
                end,
                args = {
                    reloadtext = warning(L['Need to reload UI to make some settings take effect']),
                    reload = {
                        type = 'execute',
                        name = RELOADUI,
                        order = orderGen(),
                        func = function()
                            C_UI.Reload()
                        end,
                    },
                },
            },
            globalTitle = treeTitle(L['Global Settings']),
            general = treeItem(GENERAL, {
                desc = desc(L.DESC_GENERAL),
                generalHeader = header(GENERAL),
                lockFrame = fullToggle(L['Lock Frames']),
                tipCount = fullToggle(L['Show Item Count in Tooltip']),
                appearanceHeader = header(L['Appearance']),
                style = drop(L['Bag Style'], function()
                    local values = {}
                    for styleName in pairs(self.styles) do
                        values[styleName] = styleName
                    end
                    for styleName in pairs(self.demandStyles) do
                        values[styleName] = styleName
                    end
                    return values
                end),
                iconJunk = fullToggle(L['Show Junk Icon']),
                iconQuestStarter = fullToggle(L['Show Quest Starter Icon']),
                textOffline = fullToggle(L['Show Offline Text in Bag\'s Title']),
                remainLimit = drop(L['Time Remaining'], {
                    {name = L['Always show'], value = 0}, --
                    {name = L['Never show'], value = -1}, --
                    {name = L['Less than one day'], value = 1}, --
                    daysValue(3), daysValue(5), daysValue(10), daysValue(15), daysValue(20),
                }),
            }),
            colors = treeItem(L['Color Settings'], {
                desc = desc(L.DESC_COLORS),
                glowHeader = header(L['Highlight Border']),
                glowQuality = toggle(L['Highlight Items by Quality']),
                glowQuest = toggle(L['Highlight Quest Items']),
                glowUnusable = toggle(L['Highlight Unusable Items']),
                glowEquipSet = toggle(L['Highlight Equipment Set Items']),
                glowNew = toggle(L['Highlight New Items']),
                glowAlpha = fullRange(L['Highlight Brightness'], 0, 1),
                separator1 = separator(),
                colorHeader = header(L['Slot Colors']),
                colorSlots = fullToggle(L['Color Empty Slots by Bag Type']),
                colors = {
                    type = 'group',
                    inline = true,
                    name = L['Container Colors'],
                    order = orderGen(),
                    hidden = function()
                        return not self.db.profile.colorSlots
                    end,
                    get = function(item)
                        local color = self.db.profile[item[#item]]
                        return color.r, color.g, color.b
                    end,
                    set = function(item, ...)
                        local key = item[#item]
                        local color = self.db.profile[key]
                        color.r, color.g, color.b = ...
                        fireGlobalKey(key)
                    end,
                    args = {
                        colorNormal = color(L['Normal Color']),
                        colorQuiver = color(L['Quiver Color']),
                        colorSoul = color(L['Soul Color']),
                        colorEnchant = color(L['Enchanting Color']),
                        colorHerb = color(L['Herbalism Color']),
                        colorKeyring = color(L['Keyring Color']),
                    },
                },
                emptyAlpha = fullRange(L['Empty Slot Brightness'], 0, 1),
            }),
            display = treeItem(L['Auto Display'], {
                desc = desc(L.DESC_DISPLAY),
                displayHeader = header(L['Auto Display']),
                displayMail = toggle(L['Visiting the Mail Box']),
                displayAuction = toggle(L['Visiting the Auction House']),
                displayBank = toggle(L['Visiting the Bank']),
                displayMerchant = toggle(L['Visiting a Vendor']),
                displayCharacter = toggle(L['Opening the Character Info']),
                displayCraft = toggle(L['Opening Trade Skills']),
                displayTrade = toggle(L['Trading Items']),
                closeHeader = header(L['Auto Close']),
                closeMail = toggle(L['Leaving the Mail Box']),
                closeAuction = toggle(L['Leaving the Auction House']),
                closeBank = toggle(L['Leaving the Bank']),
                closeMerchant = toggle(L['Leaving a Vendor']),
                closeCharacter = toggle(L['Closing the Character Info']),
                closeCraft = toggle(L['Closing Trade Skills']),
                closeTrade = toggle(L['Completed Trade']),
                closeCombat = toggle(L['Entering Combat']),
            }),
            framesTitle = treeTitle(L['Frame Settings']),
            [ns.BAG_ID.BAG] = frame(ns.BAG_ID.BAG, L['Inventory']),
            [ns.BAG_ID.BANK] = frame(ns.BAG_ID.BANK, L['Bank']),
            [ns.BAG_ID.MAIL] = baseFrame(ns.BAG_ID.MAIL, L['Mail'], {
                desc = desc(format(L.DESC_FRAMES, L['Mail'])),
                appearance = inline(L['Appearance'], { --
                    managed = toggle(L['Blizzard Panel']),
                    iconCharacter = toggle(L['Show Character Portrait']),
                    reverseBag = toggle(L['Reverse Bag Order']),
                    reverseSlot = toggle(L['Reverse Slot Order']),
                    column = range(L['Columns'], 6, 36, 1),
                    scale = range(L['Item Scale'], 0.5, 2),
                }),
            }),
            [ns.BAG_ID.EQUIP] = baseFrame(ns.BAG_ID.EQUIP, L['Equip'], {
                desc = desc(format(L.DESC_FRAMES, L['Equip'])),
                appearance = inline(L['Appearance'], { --
                    managed = toggle(L['Blizzard Panel']),
                    iconCharacter = toggle(L['Show Character Portrait']),
                    column = range(L['Columns'], 6, 36, 1),
                    scale = range(L['Item Scale'], 0.5, 2),
                }),
            }),
            [ns.BAG_ID.SEARCH] = baseFrame(ns.BAG_ID.SEARCH, L['Global search'], {
                desc = desc(format(L.DESC_FRAMES, L['Global search'])),
                appearance = inline(L['Appearance'], { --
                    managed = fullToggle(L['Blizzard Panel']),
                    column = range(L['Columns'], 6, 36, 1),
                    scale = range(L['Item Scale'], 0.5, 2),
                }),
            }),
        },
    }

    AceConfigRegistry:RegisterOptionsTable('tdBag2', options)
    self.options = AceConfigDialog:AddToBlizOptions('tdBag2', 'tdBag2')

    self:RefreshPluginOptions()
end

local function OpenToCategory(options)
    InterfaceOptionsFrame_OpenToCategory(options)
    InterfaceOptionsFrame_OpenToCategory(options)
    OpenToCategory = InterfaceOptionsFrame_OpenToCategory
end

function Addon:OpenFrameOption(bagId)
    if bagId then
        OpenToCategory(self.options)
        AceConfigDialog:SelectGroup('tdBag2', bagId)
    else
        OpenToCategory(self.options)
    end
end

function Addon:RefreshPluginOptions()
    for bagId, args in pairs(BAG_ARGS) do
        wipe(args)

        for i, plugin in Addon:IteratePluginButtons() do
            args[plugin.key] = {type = 'toggle', name = plugin.text, order = i}
        end
    end
    AceConfigRegistry:NotifyChange('tdBag2')
end
