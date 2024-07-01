-- Events.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/18/2019, 12:58:19 PM
--
---- LUA
local ipairs = ipairs
local select = select
local unpack = table.unpack or unpack

---@type ns
local ns = select(2, ...)

local C = ns.C

---- WOW
local GetContainerNumSlots = C.Container.GetContainerNumSlots

---- UI
local BankFrame = BankFrame

---- G
local BANK_CONTAINER = BANK_CONTAINER
local NUM_BAG_SLOTS = NUM_BAG_SLOTS
local NUM_BANKGENERIC_SLOTS = NUM_BANKGENERIC_SLOTS

local Addon = ns.Addon
local BAG_ID = ns.BAG_ID

local METHODS = {'RegisterEvent', 'UnregisterEvent', 'UnregisterAllEvents', 'RegisterFrameEvent'}

---@class Events: AceAddon-3.0, AceEvent-3.0
local Events = ns.Addon:NewModule('Events', 'AceEvent-3.0', 'AceHook-3.0')
Events.handler = {}
Events.events = LibStub('CallbackHandler-1.0'):New(Events.handler, unpack(METHODS, 1, 3))

Events.handler.RegisterFrameEvent = function(self, event, callback)
    if callback == nil then
        callback = event
    end
    return self:RegisterEvent(event .. self.meta.bagId, callback)
end

function Events:OnInitialize()
    self.bagSizes = {}
end

function Events:OnEnable()
    self:RegisterEvent('BAG_UPDATE')
    self:RegisterEvent('BAG_CLOSED')
    self:RegisterEvent('PLAYERBANKSLOTS_CHANGED')
    self:RegisterEvent('ITEM_LOCK_CHANGED')

    self:RegisterMessage('BANK_OPENED')
    self:RegisterMessage('BANK_CLOSED')

    self:RegisterMessage('MAIL_OPENED', 'Fire')
    self:RegisterMessage('MAIL_CLOSED', 'Fire')

    self:RegisterEvent('BAG_NEW_ITEMS_UPDATED', 'Fire')
    self:RegisterEvent('BAG_UPDATE_COOLDOWN', 'Fire')
    self:RegisterEvent('BAG_UPDATE_DELAYED', 'Fire')
    self:RegisterEvent('CURSOR_CHANGED', 'Fire')
    -- @build>3@
    self:RegisterEvent('QUEST_LOG_UPDATE', 'Fire')
    self:SecureHook('BackpackTokenFrame_Update')
    -- @end-build>3@
    self:RegisterEvent('GET_ITEM_INFO_RECEIVED', 'Fire')
    self:RegisterEvent('PLAYER_MONEY', 'Fire')
    self:RegisterEvent('PLAYER_TRADE_MONEY', 'Fire')
    self:RegisterEvent('SEND_MAIL_COD_CHANGED', 'Fire')
    self:RegisterEvent('SEND_MAIL_MONEY_CHANGED', 'Fire')
    self:RegisterEvent('PLAYERBANKBAGSLOTS_CHANGED', 'Fire')
    self:RegisterEvent('UNIT_PORTRAIT_UPDATE', 'Fire')
end

function Events:Embed(target)
    for _, v in ipairs(METHODS) do
        target[v] = self.handler[v]
    end
end

function Events:Fire(event, ...)
    return self.events:Fire(event, ...)
end

function Events:FireFrame(event, bagId, ...)
    return self.events:Fire(event .. bagId, ...)
end

function Events:UpdateBagSize(bag)
    local old = self.bagSizes[bag]
    local new = GetContainerNumSlots(bag) or 0

    if old ~= new then
        self.bagSizes[bag] = new
        self:Fire('BAG_SIZE_CHANGED', bag)
    end
end

function Events:UpdateBag(bag)
    self:Fire('BAG_UPDATE', bag)
end

function Events:BAG_UPDATE(_, bag)
    self:UpdateBagSize(bag)
    self:UpdateBag(bag)
end

function Events:BAG_CLOSED(_, bag)
    self:Fire('BAG_CLOSED', bag)
    self:BAG_UPDATE(nil, bag)
end
Events.BAG_CLOSED = ns.Spawned(Events.BAG_CLOSED)

function Events:PLAYERBANKSLOTS_CHANGED(_, slot)
    if slot <= NUM_BANKGENERIC_SLOTS then
        self:BAG_UPDATE(nil, BANK_CONTAINER)
    end
end

function Events:BANK_OPENED()
    BankFrame:Show()
    self:Fire('BANK_OPENED')
    Addon:ShowFrame(BAG_ID.BANK)
    Addon:SetFrameOwner(BAG_ID.BANK)
end

function Events:BANK_CLOSED()
    BankFrame:Hide()
    self:Fire('BANK_CLOSED')
    Addon:HideFrame(BAG_ID.BANK)
end

function Events:ITEM_LOCK_CHANGED(_, bag, slot)
    if slot then
        if ns.IsBank(bag) and slot > NUM_BANKGENERIC_SLOTS then
            self:Fire('BAG_LOCK_CHANGED', slot - NUM_BANKGENERIC_SLOTS + NUM_BAG_SLOTS)
        else
            self:Fire('ITEM_LOCK_CHANGED', bag, slot)
        end
    else
        local bag = ns.SlotToBag(bag)
        if bag then
            self:Fire('BAG_LOCK_CHANGED', bag)
        end
    end
end

function Events:BackpackTokenFrame_Update()
    self.events:Fire('WATCHED_CURRENCY_CHANGED')
end
