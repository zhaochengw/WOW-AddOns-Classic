-- FullScaner.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/18/2020, 3:57:33 PM
--
---@type ns
local ns = select(2, ...)

local L = ns.L
local Scaner = ns.Scaner

local REPORT_LINE_F = '%s: %d'
local ITEM_QUALITY_POOR = Enum.ItemQuality.Poor
local ITEM_QUALITY_HEIRLOOM = Enum.ItemQuality.Heirloom

local _G = _G

local pairs = pairs
local format = string.format
local tinsert, tconcat = table.insert, table.concat

local GetItemQualityColor = GetItemQualityColor

---@type FullScaner
local FullScaner = ns.Addon:NewClass('FullScaner', Scaner)

function FullScaner:Constructor()
    self.params = {text = '', queryAll = true}
end

function FullScaner:Query()
    return ns.Querier:Query(self.params, self)
end

function FullScaner:OnStart()
    Scaner.OnStart(self)

    self.cache = {}
    self.report = nil
end

function FullScaner:OnDone()
    local qualities = {}
    local new = 0
    local update = 0

    for itemKey, quality in pairs(self.cache) do
        qualities[quality] = (qualities[quality] or 0) + 1

        if not ns.prices[itemKey] then
            new = new + 1
        else
            update = update + 1
        end
    end

    local sb = {}
    if new > 0 then
        tinsert(sb, format(REPORT_LINE_F, L['New'], new))
    end
    if update > 0 then
        tinsert(sb, format(REPORT_LINE_F, L['Update'], update))
    end

    for quality = ITEM_QUALITY_POOR, ITEM_QUALITY_HEIRLOOM do
        local count = qualities[quality]
        if count then
            tinsert(sb, format(REPORT_LINE_F, ns.ITEM_QUALITY_DESCS[quality], count))
        end
    end

    self.report = tconcat(sb, '\n')
    self:SavePrices(self.db)
end

function FullScaner:ProcessAuction(index)
    local itemKey, count, price, quality = Scaner.ProcessAuction(self, index)
    if itemKey and quality > ITEM_QUALITY_POOR then
        self.cache[itemKey] = quality
    end
end
