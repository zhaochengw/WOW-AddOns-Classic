-- BrowseScaner.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/21/2020, 1:33:21 PM
--
---@type ns
local ns = select(2, ...)

local pairs = pairs
local min = math.min

local L = ns.L
local Scaner = ns.Scaner

---@type BrowseScaner
local BrowseScaner = ns.Addon:NewClass('BrowseScaner', ns.Scaner)

function BrowseScaner:Query(params)
    if not ns.ParamsEqual(params, self.params) then
        self.db = {}
    end
    Scaner.Query(self, params)
end

function BrowseScaner:GetDB()
    return self.db[self.params.page]
end

function BrowseScaner:OnResponse()
    Scaner.OnResponse(self)
    self.db[self.params.page] = {}
end

function BrowseScaner:OnStart()
    self.pendings = {}
end

function BrowseScaner:OnDone()
    local sortType, sortRev = GetAuctionSort('list', 1)
    if sortType == 'unitprice' and not sortRev then
        local db = {}
        local page = 0

        while true do
            local prices = self.db[page]
            if not prices then
                break
            end

            for itemKey, price in pairs(prices) do
                if not db[itemKey] then
                    db[itemKey] = price
                else
                    db[itemKey] = min(db[itemKey], price)
                end
            end
            page = page + 1
        end

        self:SavePrices(db)
    end
end
