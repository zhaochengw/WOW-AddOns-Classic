-- Scaner.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/18/2020, 2:50:36 PM
--
---@type ns
local ns = select(2, ...)

local pairs = pairs
local min, floor = math.min, math.floor
local tinsert, tremove = table.insert, table.remove

local GetNumAuctionItems = GetNumAuctionItems
local GetAuctionItemLink = GetAuctionItemLink
local GetAuctionItemInfo = GetAuctionItemInfo

local ITEM_QUALITY_POOR = Enum.ItemQuality.Poor

local profilereset = (function()
    local debugprofilestop = debugprofilestop

    local tick = 0
    return function()
        local t = debugprofilestop()
        local diff = t - tick
        tick = t
        return diff
    end
end)()

---@type Scaner
local Scaner = ns.Addon:NewClass('Scaner')

function Scaner:Query(params)
    self.canceled = nil
    self.params = params
    ns.Querier:Query(params, self)
end

function Scaner:Cancel()
    self.canceled = true
end

function Scaner:Threshold()
    if profilereset() > 16 then
        return true
    end
end

function Scaner:Continue()
    profilereset()
    return self:OnContinue()
end

function Scaner:Done()
    self:OnDone()
    self:Fire('OnDone')
end

function Scaner:GetDB()
    return self.db
end

function Scaner:Next()
end

function Scaner:PreQuery()
end

function Scaner:OnStart()
    self.pendings = {}
    self.db = {}
end

function Scaner:OnContinue()
    while true do
        local index = tremove(self.pendings)
        if not index then
            break
        end

        self:ProcessAuction(index)

        if self:Threshold() then
            return
        end
    end

    while true do
        if self.index == 0 then
            break
        end

        self:ProcessAuction(self.index)
        self.index = self.index - 1

        if self:Threshold() then
            return
        end
    end
    return #self.pendings == 0
end

function Scaner:OnResponse()
    self.index = GetNumAuctionItems('list')
end

function Scaner:OnDone()
end

function Scaner:SavePrices(db)
    if not ns.IsValidNpc() then
        return
    end

    for itemKey, price in pairs(db) do
        ns.prices[itemKey] = price
    end
end

function Scaner:ProcessAuction(index)
    local link = GetAuctionItemLink('list', index)
    local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount,
          highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo =
        GetAuctionItemInfo('list', index)

    if not link then
        if itemId then
            tinsert(self.pendings, index)
        end
        return
    end

    local db = self:GetDB()

    if buyoutPrice and buyoutPrice > 0 then
        local unitPrice = floor(buyoutPrice / count)
        local itemKey = ns.ParseItemKey(link)

        if quality > ITEM_QUALITY_POOR then
            if not db[itemKey] then
                db[itemKey] = unitPrice
            else
                db[itemKey] = min(db[itemKey], unitPrice)
            end
        end
        return itemKey, count, unitPrice, quality, owner
    end
end
