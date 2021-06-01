-- Querier.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/18/2020, 2:40:46 PM
--
---@type ns
local ns = select(2, ...)

local floor, max = math.floor, math.max

local QueryAuctionItems = QueryAuctionItems
local GetNumAuctionItems = GetNumAuctionItems
local CanSendAuctionQuery = CanSendAuctionQuery
local GetItemInfo = GetItemInfo

local STATUS_PENDING = 1
local STATUS_WAITRESP = 2
local STATUS_RUNNING = 3

---@type Querier
local Querier = ns.Addon:NewModule('Querier', 'AceEvent-3.0')

function Querier:OnInitialize()
    self.updater = CreateFrame('Frame')
    self.updater:Hide()
    self.updater:SetScript('OnUpdate', function()
        return self:OnIdle()
    end)

    self.statusProcess = { --
        [STATUS_PENDING] = self.Pending,
        [STATUS_RUNNING] = self.Running,
    }

    hooksecurefunc('QueryAuctionItems', function()
        if not self.ourQuery then
            self:Cancel()
        end
    end)

    self:RegisterEvent('AUCTION_HOUSE_CLOSED')
end

function Querier:AUCTION_HOUSE_CLOSED()
    self.queryAllDisabled = nil
    self:Cancel()
end

function Querier:GET_ITEM_INFO_RECEIVED(_, itemId)
    if self.scaner then
        self.scaner.pending:Ready(itemId)
    end
end

function Querier:OnIdle()
    if not self.scaner or self.scaner.canceled then
        self:Cancel()
        return
    end
    local method = self.statusProcess[self.status]
    if method then
        method(self)
    end
end

function Querier:OnResponse()
    local count, total = GetNumAuctionItems('list')
    if total == 0 then
        self.pageMax = 0
    else
        self.pageMax = floor(total / max(count, NUM_AUCTION_ITEMS_PER_PAGE))
    end

    self.scaner:OnResponse()
    self.status = STATUS_RUNNING
    self:UnregisterEvent('AUCTION_ITEM_LIST_UPDATE')
end

function Querier:Query(params, scaner)
    self.params = params
    self.scaner = scaner
    self.status = STATUS_PENDING
    self.page = params.page or 0

    self.scaner:OnStart()
    self.updater:Show()
end

function Querier:CanQuery()
    local canQuery, canQueryAll = CanSendAuctionQuery('list')
    if not canQuery then
        return false
    end

    if self.params.queryAll and (not canQueryAll or self.queryAllDisabled) then
        return false
    end
    return true
end

function Querier:ParseSearchText(link)
    local exact = false
    local text = link
    local itemId, _, suffixId = ns.ParseItemLink(link)
    if itemId then
        local name = GetItemInfo(link)
        if name then
            exact = true
            text = name

            if suffixId ~= 0 then
                local origName = GetItemInfo(itemId)
                if origName then
                    local suffix = name:gsub(origName, ''):trim()
                    text = origName .. ' ' .. suffix
                end
            end
        end
    end
    return text, exact
end

function Querier:Pending()
    if not self:CanQuery() then
        return
    end

    local params = self.params
    local text, exact = self:ParseSearchText(params.text)

    self.status = STATUS_WAITRESP
    self:RegisterEvent('AUCTION_ITEM_LIST_UPDATE', 'OnResponse')
    self:RegisterEvent('GET_ITEM_INFO_RECEIVED')

    self.scaner:PreQuery()

    self.ourQuery = true
    QueryAuctionItems(text, params.minLevel, params.maxLevel, self.page, params.usable, params.quality, params.queryAll,
                      exact, params.filters)
    self.ourQuery = nil

    if params.queryAll then
        self.queryAllDisabled = true
    end
end

function Querier:Running()
    if not self.scaner:Continue() then
        return
    end

    if self.scaner:Next() and self.page < self.pageMax then
        self.page = self.page + 1
        self.status = STATUS_PENDING
        return
    end

    self:UnregisterEvent('GET_ITEM_INFO_RECEIVED')
    self.scaner:Done()
    self.updater:Hide()
end

function Querier:Cancel()
    self.scaner = nil
    self.updater:Hide()
end
