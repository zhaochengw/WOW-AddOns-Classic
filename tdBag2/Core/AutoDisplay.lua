-- AutoDisplay.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/24/2019, 10:24:55 AM
--
local LibClass = LibStub('LibClass-2.0')

---@type ns
local ns = select(2, ...)

local Addon = ns.Addon
local BAG_ID = ns.BAG_ID

---@class AutoDisplay: AceModule, AceHook-3.0, AceEvent-3.0
local AutoDisplay = Addon:NewModule('AutoDisplay', 'AceHook-3.0', 'AceEvent-3.0')

function AutoDisplay:OnInitialize()
    self.frameKeys = {}
    self.showKeys = {}
    self.hideKeys = {}

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

    self:RegisterFrame('Trade', 1)
    self:RegisterFrame('Bank', 8)
    self:RegisterFrame('Auction', 21)

    self:RegisterFrame('Mail', MailFrame)
    self:RegisterFrame('Merchant', MerchantFrame)
    self:RegisterFrame('Character', CharacterFrame)

    self:RegisterDisplayEvent('Craft', 'TRADE_SKILL_SHOW', 'TRADE_SKILL_CLOSE')
    -- @non-retail@
    self:RegisterDisplayEvent('Craft', 'CRAFT_SHOW', 'CRAFT_CLOSE')
    -- @end-non-retail@

    self:RegisterEvent('PLAYER_INTERACTION_MANAGER_FRAME_SHOW')
    self:RegisterEvent('PLAYER_INTERACTION_MANAGER_FRAME_HIDE')

    self:RegisterEvent('PLAYER_REGEN_DISABLED')
end

function AutoDisplay:PLAYER_INTERACTION_MANAGER_FRAME_SHOW(_, id)
    return self:OptShow(self.showKeys[id])
end

function AutoDisplay:PLAYER_INTERACTION_MANAGER_FRAME_HIDE(_, id)
    return self:OptHide(self.hideKeys[id])
end

function AutoDisplay:PLAYER_REGEN_DISABLED()
    if Addon.db.profile.closeCombat then
        Addon:HideFrame(BAG_ID.BAG, true)
    end
end

function AutoDisplay:OptShow(key)
    if key and Addon.db.profile[key] then
        self:ShowBag()
    end
end

function AutoDisplay:OptHide(key)
    if key and Addon.db.profile[key] then
        self:HideBag()
    end
end

function AutoDisplay:RegisterFrame(key, id)
    self.showKeys[id] = 'display' .. key
    self.hideKeys[id] = 'close' .. key

    if LibClass:IsWidget(id) then
        self:HookScript(id, 'OnShow', 'ShowEvent')
        self:HookScript(id, 'OnHide', 'HideEvent')
    end
end

function AutoDisplay:RegisterDisplayEvent(key, showEvent, hideEvent)
    if showEvent then
        self:RegisterEvent(showEvent, 'ShowEvent')
        self.showKeys[showEvent] = 'display' .. key
    end
    if hideEvent then
        self:RegisterEvent(hideEvent, 'HideEvent')
        self.hideKeys[hideEvent] = 'close' .. key
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
    return self:OptShow(self.showKeys[event])
end

function AutoDisplay:HideEvent(event)
    return self:OptHide(self.hideKeys[event])
end

function AutoDisplay:OpenAllBags(frame)
    if not frame or self.showKeys[frame] then
        return
    end
    self:ShowBag()
end

function AutoDisplay:CloseAllBags(frame)
    if not frame or self.hideKeys[frame] then
        return
    end
    self:HideBag()
end
