-- AutoDisplay.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/24/2019, 10:24:55 AM

---@type ns
local ns = select(2, ...)
local Addon = ns.Addon
local BAG_ID = ns.BAG_ID

---@class AutoDisplay: AceAddon-3.0, AceHook-3.0, AceEvent-3.0
local AutoDisplay = Addon:NewModule('AutoDisplay', 'AceHook-3.0', 'AceEvent-3.0')

function AutoDisplay:OnInitialize()
    self.frameKeys = {}
    self.eventKeys = {}

    self:RawHook('OpenBackpack', 'ShowBag', true)
    self:RawHook('CloseBackpack', 'HideBag', true)
    self:RawHook('ToggleBackpack', 'ToggleBag', true)
    self:RawHook('ToggleAllBags', 'ToggleBag', true)

    self:RawHook('OpenBag', function(bag)
        return Addon:ShowFrame(ns.GetBagId(bag), true)
    end, true)
    self:RawHook('ToggleBag', function(bag)
        return Addon:ToggleFrame(ns.GetBagId(bag), true)
    end, true)

    self:RawHook('OpenAllBags', true)
    self:RawHook('CloseAllBags', true)

    self:RegisterDisplayFrame('Mail', MailFrame)
    self:RegisterDisplayFrame('Merchant', MerchantFrame)
    self:RegisterDisplayFrame('Character', CharacterFrame)
    self:RegisterDisplayEvent('Auction', 'AUCTION_HOUSE_SHOW', 'AUCTION_HOUSE_CLOSED')
    self:RegisterDisplayEvent('Craft', 'TRADE_SKILL_SHOW', 'TRADE_SKILL_CLOSE')
    self:RegisterDisplayEvent('Craft', 'CRAFT_SHOW', 'CRAFT_CLOSE')
    self:RegisterDisplayEvent('Trade', 'TRADE_SHOW', 'TRADE_CLOSED')
    self:RegisterDisplayEvent('Bank', 'BANKFRAME_OPENED', 'BANKFRAME_CLOSED')

    self:RegisterEvent('PLAYER_REGEN_DISABLED')
end

function AutoDisplay:PLAYER_REGEN_DISABLED()
    if Addon.db.profile.closeCombat then
        Addon:HideFrame(BAG_ID.BAG, true)
    end
end

function AutoDisplay:RegisterDisplayFrame(key, frame)
    self:HookScript(frame, 'OnShow', 'FrameOnShow')
    self:HookScript(frame, 'OnHide', 'FrameOnHide')
    self.frameKeys[frame] = key
end

function AutoDisplay:RegisterDisplayEvent(key, showEvent, hideEvent)
    if showEvent then
        self:RegisterEvent(showEvent, 'ShowEvent')
        self.eventKeys[showEvent] = 'display' .. key
    end
    if hideEvent then
        self:RegisterEvent(hideEvent, 'HideEvent')
        self.eventKeys[hideEvent] = 'close' .. key
    end
end

function AutoDisplay:ShowBag()
    return Addon:ShowFrame(BAG_ID.BAG)
end

function AutoDisplay:HideBag()
    return Addon:HideFrame(BAG_ID.BAG)
end

function AutoDisplay:ToggleBag()
    return Addon:ToggleFrame(BAG_ID.BAG, true)
end

function AutoDisplay:ShowEvent(event)
    local key = event and self.eventKeys[event]
    if key and Addon.db.profile[key] then
        self:ShowBag()
    end
end

function AutoDisplay:HideEvent(event)
    local key = event and self.eventKeys[event]
    if key and Addon.db.profile[key] then
        self:HideBag()
    end
end

function AutoDisplay:FrameOnShow(frame)
    local key = frame and self.frameKeys[frame]
    if key and Addon.db.profile['display' .. key] then
        self:ShowBag()
    end
end

function AutoDisplay:FrameOnHide(frame)
    local key = frame and self.frameKeys[frame]
    if key and Addon.db.profile['close' .. key] then
        self:HideBag()
    end
end

function AutoDisplay:OpenAllBags(frame)
    if frame and self.frameKeys[frame] then
        return
    end
    self:ShowBag()
end

function AutoDisplay:CloseAllBags(frame)
    if frame and self.frameKeys[frame] then
        return
    end
    self:HideBag()
end
