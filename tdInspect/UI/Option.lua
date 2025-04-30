-- Option.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/5/2024, 1:39:10 PM
--
---@type string, ns
local ADDON, ns = ...

local L = ns.L
local tdOptions = LibStub('tdOptions')

---@class Addon
local Addon = ns.Addon

function Addon:SetupOptionFrame()
    local order = 0
    local function orderGen()
        order = order + 1
        return order
    end

    local function treeTitle(name)
        return {type = 'group', name = '|cffffd100' .. name .. '|r', order = orderGen(), args = {}, disabled = true}
    end

    local function treeItem(name)
        return function(args)
            return {type = 'group', name = '  |cffffffff' .. name .. '|r', order = orderGen(), args = args}
        end
    end

    local function inline(name)
        return function(args)
            return {type = 'group', name = name, inline = true, order = orderGen(), args = args}
        end
    end

    local function fullToggle(name)
        return {type = 'toggle', name = name, width = 'full', order = orderGen()}
    end

    local function keybinding(name)
        return {
            type = 'keybinding',
            name = name,
            order = orderGen(),
            width = 'double',
            get = function(item)
                return GetBindingKey(item[#item])
            end,
            set = function(item, value)
                local action = item[#item]
                for _, key in ipairs({GetBindingKey(action)}) do
                    SetBinding(key, nil)
                end
                SetBinding(value, action)
            end,
            confirm = function(item, value)
                local action = GetBindingAction(value)
                if action ~= '' and action ~= item[#item] then
                    return L['The key is bound to |cffffd100%s|r, are you sure you want to overwrite it?']:format(
                               _G['BINDING_NAME_' .. action] or action)
                end
            end,
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

    local options = {
        type = 'group',
        name = format('%s - |cff00ff00%s|r', C_AddOns.GetAddOnMetadata(ADDON, 'Title'),
                      C_AddOns.GetAddOnMetadata(ADDON, 'Version')),
        get = function(item)
            return ns.db.profile[item[#item]]
        end,
        set = function(item, value)
            local key = item[#item]
            ns.db.profile[key] = value
            ns.Events:Fire('TDINSPECT_OPTION_CHANGED', key, value)
        end,
        args = {
            gearListTitle = treeTitle(L['Gear List']),
            gearList = treeItem(L['Gear List']) {
                general = inline(GENERAL) {
                    showTalentBackground = fullToggle(L['Show talent background']),
                    showGem = fullToggle(L['Show gem']),
                    showEnchant = fullToggle(L['Show enchant']),
                    showLost = fullToggle(L['Show enchant/gem lost']),
                    showGemsFront = fullToggle(L['Show gems in front']),
                },
                characterGear = inline(L['Character Gear']) {
                    characterGear = fullToggle(L['Show character gear list']),
                    showOptionButtonInCharacter = fullToggle(L['Show option button in character gear list']),
                },
                inspectGear = inline(L['Inspect Gear']) {
                    inspectGear = fullToggle(L['Show inspect gear list']),
                    inspectCompare = fullToggle(L['Show inspect compare']),
                    closeCharacterFrameWhenInspect = fullToggle(L['Close character frame when inspect']),
                    showOptionButtonInInspect = fullToggle(L['Show option button in inspect gear list']),
                    itemLevelColor = drop(L['Item level color style'], {
                        {value = 'Hidden', name = L['Hidden']}, --
                        {value = 'White', name = L['White']}, --
                        {value = 'Blizzard', name = L['Quality by blizzard']}, --
                        {value = 'Light', name = L['Light']}, --
                    }),
                },
                characterList = inline(L['Character List']) {
                    showLowLevelCharacters = fullToggle(L['Show low level characters']),
                },
            },
            keybindingsTitle = treeTitle(SETTINGS_KEYBINDINGS_LABEL),
            keybindings = treeItem(SETTINGS_KEYBINDINGS_LABEL) {
                TDINSPECT_VIEW_TARGET = keybinding(L['View target hotkey']),
                TDINSPECT_VIEW_MOUSEOVER = keybinding(L['View mouseover hotkey']),
            },
            helpTitle = treeTitle(L['Help']),
            help = treeItem(L['Help']) {help = {type = 'description', name = L.HELP_SUMMARY, order = orderGen()}},
        },
    }

    tdOptions:Register(ADDON, options)
end

function Addon:OpenOptionFrame()
    return tdOptions:Open(ADDON)
end
