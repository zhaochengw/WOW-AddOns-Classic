-- SellOutput.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/18/2020, 2:17:14 PM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local SendSystemMessage = SendSystemMessage
local GetMoneyString = GetMoneyString

local ERR_AUCTION_STARTED = ERR_AUCTION_STARTED

---@type SellOutput
local SellOutput = ns.Addon:NewModule('SellOutput', 'AceEvent-3.0', 'AceHook-3.0')

function SellOutput:OnInitialize()
    ChatFrame_AddMessageEventFilter('CHAT_MSG_SYSTEM', function(_, _, msg)
        if msg == ERR_AUCTION_STARTED then
            return true
        end
    end)

    self:SecureHook('PostAuction', 'OnPostAuction')
    self:RegisterEvent('CHAT_MSG_SYSTEM')
    self:RegisterEvent('AUCTION_MULTISELL_FAILURE')
    self:RegisterEvent('NEW_AUCTION_UPDATE')
end

function SellOutput:OnPostAuction(_, price, _, stackSize, numStacks)
    self.item = ns.GetAuctionSellItemLink() or self.item
    self.sellStacks = 0
    self.stackSize = stackSize
    self.numStacks = numStacks
    self.price = price
end

function SellOutput:CHAT_MSG_SYSTEM(_, msg)
    if msg == ERR_AUCTION_STARTED and self.item then
        self.sellStacks = self.sellStacks + 1

        if self.failure or self.sellStacks == self.numStacks then
            self:Done()
        end
    end
end

function SellOutput:NEW_AUCTION_UPDATE()
    self.item = ns.GetAuctionSellItemLink() or self.item
end

function SellOutput:AUCTION_MULTISELL_FAILURE()
    self.failure = true
end

function SellOutput:Done()
    SendSystemMessage(L['Start auction:'] ..
                          format(' %sx%d (%s)', self.item, self.sellStacks * self.stackSize,
                                 GetMoneyString(self.price * self.sellStacks)))

    self.item = nil
    self.sellStacks = nil
    self.stackSize = nil
    self.numStacks = nil
    self.price = nil
end
