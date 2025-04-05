-- Option.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/2/2019, 12:35:41 PM
--
---@type string, ns
local ADDON, ns = ...

---@class Addon
local Addon = ns.Addon

local C = ns.C
local L = ns.L
local UI = ns.UI

local format = string.format

local tdOptions = LibStub('tdOptions')

function Addon:InitOptionFrame()
    local index = 0
    local function orderGen()
        index = index + 1
        return index
    end

    local function inline(name, args)
        return {type = 'group', name = name, inline = true, order = orderGen(), args = args}
    end

    local function toggle(text, disabled)
        return {type = 'toggle', name = text, width = 'full', order = orderGen(), disabled = disabled}
    end

    local function execute_(text, width, ...)
        local confirm, func
        local t = type(...)
        if t == 'function' then
            func = ...
        else
            confirm, func = ...
        end

        return {
            type = 'execute',
            name = text,
            order = orderGen(),
            confirm = not not confirm,
            confirmText = confirm,
            func = func,
            width = width,
        }
    end

    local function execute(text, ...)
        return execute_(text, nil, ...)
    end

    local function halfExecute(text, ...)
        return execute_(text, 'half', ...)
    end

    local function treeTitle(name)
        return {type = 'group', name = '|cffffd100' .. name .. '|r', order = orderGen(), args = {}, disabled = true}
    end

    local function treeItem(name, args)
        return {type = 'group', name = '  |cffffffff' .. name .. '|r', order = orderGen(), args = args}
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
            desc = name,
        }
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

    local function generateButton(bagType, name)
        local args = {}
        local node = treeItem(name, args)
        node.get = function(item)
            return Addon:GetBagClickOption(bagType, tonumber(item[#item]))
        end
        node.set = function(item, value)
            Addon:SetBagClickOption(bagType, tonumber(item[#item]), value)
        end

        for _, v in ipairs(ns.CLICK_LIST) do
            args[tostring(v.token)] = drop(v.name, {
                {name = L['None'], value = false}, --
                {name = L.SORT, value = 'SORT'}, --
                {name = L.SORT_ASC, value = 'SORT_ASC'}, --
                {name = L.SORT_DESC, value = 'SORT_DESC'}, --
                {name = L.SORT_BAG, value = 'SORT_BAG'}, --
                {name = L.SORT_BAG_ASC, value = 'SORT_BAG_ASC'}, --
                {name = L.SORT_BAG_DESC, value = 'SORT_BAG_DESC'}, --
                {name = L.SORT_BANK, value = 'SORT_BANK'}, --
                {name = L.SORT_BANK_ASC, value = 'SORT_BANK_ASC'}, --
                {name = L.SORT_BANK_DESC, value = 'SORT_BANK_DESC'}, --
                {name = L.SAVE, value = 'SAVE'}, --
                {name = L.OPEN_RULE_OPTIONS, value = 'OPEN_RULE_OPTIONS'}, --
                {name = L.OPEN_OPTIONS, value = 'OPEN_OPTIONS'}, --
            })
        end

        return node
    end

    --[=[@maybe@
    maybe {L['SORTING_NAME'], L['SORTING_DESC'], L['SAVING_NAME'], L['SAVING_DESC']}
    --@end-maybe@]=]

    local function ruleView(key)
        local ruleType = ns.SORT_TYPE[key]
        assert(ruleType)
        return treeItem(L[key .. '_NAME'], {
            title = desc(L[key .. '_DESC']),

            add = execute(L['Add advance rule'], function()
                UI.RuleEditor:Open(nil, Addon:GetRules(ruleType), function()
                    self:SendMessage('TDPACK_RULES_UPDATE', ruleType)
                end)
            end),

            reset = halfExecute(L['Reset rule'], L['Are you sure to |cffff1919RESET|r rules?'], function()
                Addon:ResetRules(ruleType)
            end),

            help = {
                type = 'execute',
                name = L['Help'],
                width = 'half',
                order = orderGen(),
                image = [[Interface\HelpFrame\HelpIcon-KnowledgeBase]],
                imageCoords = {0.2, 0.8, 0.2, 0.8},
                imageWidth = 24,
                imageHeight = 24,
                desc = table.concat({
                    L['Drag to modify the sorting order'], --
                    L['Put in an item to add simple rule'], --
                    L['Advancee rules use ItemSearch-1.3'], --
                    L['Enjoy!'], --
                }, '\n'),
            },

            view = {
                type = 'group',
                name = L['Rules'],
                inline = true,
                order = orderGen(),
                args = { --
                    view = { --
                        type = 'execute',
                        name = key,
                        order = orderGen(),
                        dialogControl = ADDON .. 'RuleView',
                    },
                },
            },
        })
    end

    local charProfileKey = format('%s - %s', UnitName('player'), GetRealmName())

    local options = {
        type = 'group',
        name = format('%s - |cff00ff00%s|r', ADDON, C.AddOns.GetAddOnMetadata(ADDON, 'Version')),

        get = function(item)
            return self:GetOption(item[#item])
        end,
        set = function(item, value)
            self:SetOption(item[#item], value)
        end,

        args = {
            titleGeneral = treeTitle(GENERAL),
            general = treeItem(GENERAL, {
                default = inline(L.SORT, {
                    reverse = toggle(L['Reverse pack']),
                    saving = toggle(L['Save to bank when default packing']),
                    stackTogether = toggle(L['Bank and bag stacking together']),
                    stackBankFull = toggle(L['Keep bank items stack full'], function()
                        return not self:GetOption('stackTogether')
                    end),
                }),
                help = inline(L['Help'], {
                    console = toggle(L['Enable chat message']),
                    applyLibItemSearch = toggle(L['Add extension filter to ItemSearch-1.3']),
                }),
            }),
            titleButtons = treeTitle(L['Buttons']),
            [ns.BAG_TYPE.BAG] = generateButton(ns.BAG_TYPE.BAG, L['Bag']),
            [ns.BAG_TYPE.BANK] = generateButton(ns.BAG_TYPE.BANK, L['Bank']),
            titleRules = treeTitle(L['Rules']),
            sorting = ruleView('SORTING'),
            saving = ruleView('SAVING'),
            titleProfiles = treeTitle(L['Profile']),
            profile = treeItem(L['Profile'], {
                profile = {
                    type = 'toggle',
                    name = L['Character Specific Settings'],
                    width = 'double',
                    order = orderGen(),
                    set = function(_, checked)
                        self.db:SetProfile(checked and charProfileKey or 'Default')
                    end,
                    get = function()
                        return self.db:GetCurrentProfile() == charProfileKey
                    end,
                },
                reset = execute(L['Restore default Settings'],
                                L['Are you sure you want to restore the current Settings?'], function()
                    self.db:ResetProfile()
                end),
            }),
        },
    }

    tdOptions:Register(ADDON, options)
end

function Addon:OpenOption(toRule)
    if toRule then
        tdOptions:Open(ADDON, 'sorting')
    else
        tdOptions:Open(ADDON, 'general')
    end
end
