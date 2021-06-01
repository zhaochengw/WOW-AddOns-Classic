-- PriceScaner.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/21/2020, 1:46:13 PM
--
---@type ns
local ns = select(2, ...)

local pairs = pairs
local format = string.format
local tinsert = table.insert
local sort = table.sort or sort

local UnitIsUnit = UnitIsUnit
local SortAuctionClearSort = SortAuctionClearSort
local SortAuctionSetSort = SortAuctionSetSort

local Scaner = ns.Scaner

---@type PriceScaner
local PriceScaner = ns.Addon:NewClass('PriceScaner', Scaner)

function PriceScaner:Query(params)
    self.link = params.text
    self.itemKey = ns.ParseItemKey(self.link)
    Scaner.Query(self, params)
end

function PriceScaner:Next()
    return not self.db[self.itemKey] or ns.profile.sell.scanFull
end

function PriceScaner:OnStart()
    Scaner.OnStart(self)
    self.cache = {}
end

function PriceScaner:PreQuery()
    SortAuctionClearSort('list')
    SortAuctionSetSort('list', 'unitprice', false)
end

local function comp(a, b)
    if a.price == b.price then
        return a.stackSize < b.stackSize
    end
    return a.price < b.price
end

function PriceScaner:OnDone()
    self:SavePrices(self.db)

    self.items = {}

    for _, v in pairs(self.cache) do
        tinsert(self.items, v)
    end

    sort(self.items, comp)
end

function PriceScaner:ProcessAuction(index)
    local _, itemKey, stackSize, price, _, owner = Scaner.ProcessAuction(self, index)
    if itemKey == self.itemKey then
        local key = format('%d.%d', price, stackSize)

        if not self.cache[key] then
            self.cache[key] = {stackSize = stackSize, price = price, count = 0, isMine = false}
        end

        local c = self.cache[key]
        c.count = c.count + 1
        c.isMine = c.isMine or (owner and UnitIsUnit('player', owner))
    end
end

function PriceScaner:GetResponseItems()
    return self.items
end
