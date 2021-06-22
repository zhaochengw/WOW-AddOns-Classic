-- Option.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/22/2020, 10:47:50 AM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local Addon = ns.Addon

local AceConfigRegistry = LibStub('AceConfigRegistry-3.0')
local AceConfigDialog = LibStub('AceConfigDialog-3.0')

function Addon:SetupOptionFrame()
    local order = 0
    local function orderGen()
        order = order + 1
        return order
    end

    local function getConfig(paths)
        local d = ns.profile
        for i, v in ipairs(paths) do
            d = d[v]
        end
        return d
    end

    local function setConfig(paths, value)
        local d = ns.profile
        local n = #paths
        for i, v in ipairs(paths) do
            if i < n then
                d = d[v]
            else
                d[v] = value
            end
        end
    end

    local function inline(name)
        return function(args)
            return {type = 'group', name = name, inline = true, order = orderGen(), args = args}
        end
    end

    local function treeTitle(name)
        return {type = 'group', name = '|cffffd100' .. name .. '|r', order = orderGen(), args = {}, disabled = true}
    end

    local function treeItem(name)
        return function(args)
            return {type = 'group', name = '  |cffffffff' .. name .. '|r', order = orderGen(), args = args}
        end
    end

    local function drop(name)
        return function(values)
            local opts = { --
                type = 'select',
                name = name,
                width = 'double',
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
    end

    local function toggle(name)
        return {type = 'toggle', name = name, width = 'double', order = orderGen()}
    end

    local function range(name, min, max, step)
        return {type = 'range', order = orderGen(), name = name, width = 'double', min = min, max = max, step = step}
    end

    local function execute(name, confirm, func)
        return {
            type = 'execute',
            order = orderGen(),
            name = name,
            confirm = not not confirm,
            confirmText = confirm,
            func = func,
        }
    end

    local options = {
        type = 'group',
        name = 'tdAuction ' .. GetAddOnMetadata('tdAuction', 'Version'),
        get = function(paths)
            return getConfig(paths)
        end,
        set = function(paths, value)
            return setConfig(paths, value)
        end,
        args = {
            sellTitle = treeTitle(AUCTIONS),
            buy = treeItem(BROWSE) { --
                quickBuy = toggle(L['Enable ALT-CTRL click to buyout']),
            },
            sell = treeItem(AUCTIONS) {
                altSell = toggle(L['Enable ALT to sell']),
                autoOpenPriceList = toggle(L['Auto open price list']),
                scanFull = drop(L['Scan price mode']) {
                    {name = L['Scan all'], value = true},
                    {name = L['Scan one page'], value = false},
                },
                stackSize = drop(L['Default stack size']) { --
                    {name = L['Full'], value = 0},
                    {name = '1', value = 1},
                    {name = '5', value = 5},
                    {name = '10', value = 10},
                    {name = '20', value = 20},
                },
                duration = drop(L['Default auction duration']) {
                    {name = L['Ignore'], value = false},
                    {name = AUCTION_DURATION_ONE, value = 1},
                    {name = AUCTION_DURATION_TWO, value = 2},
                    {name = AUCTION_DURATION_THREE, value = 3},
                },
                durationNoDeposit = drop(L['Duration no deposit']) {
                    {name = L['Ignore'], value = false},
                    {name = AUCTION_DURATION_ONE, value = 1},
                    {name = AUCTION_DURATION_TWO, value = 2},
                    {name = AUCTION_DURATION_THREE, value = 3},
                },
                merchantRatio = range(L['When no price, use merchant price multiply by'], 1, 100, 0.1),
                bidRatio = range(L['Start price discount'], 0, 1, 0.01),
            },
            db = treeItem(L['Database']) {
                clear = execute(L['Clear database'], L['You are sure to clear the database'], function()
                    return wipe(ns.prices)
                end),
            },
            tooltipTitle = treeTitle(L['Tooltip']),
            tooltip = treeItem(L['Tooltip']) {
                price = toggle(L['Merchant price']),
                auctionPrice = toggle(L['Auction price']),
                disenchantPrice = toggle(L['Disenchant price']),
                showDisenchant = drop(L['Show disenchant info']) {
                    {name = L['Nerver'], value = false},
                    {name = L['Pressed SHIFT'], value = 1},
                    {name = L['Always'], value = 2},
                },
                shiftSingle = drop(L['When pressed SHIFT, to dislay ...']) {
                    {name = L['Total price'], value = false},
                    {name = L['Single price'], value = true},
                },
            },
        },
    }

    AceConfigRegistry:RegisterOptionsTable('tdAuction', options)
    AceConfigDialog:AddToBlizOptions('tdAuction', 'tdAuction')
end

function Addon:OpenOptionFrame()
    AceConfigDialog:Open('tdAuction')
end
