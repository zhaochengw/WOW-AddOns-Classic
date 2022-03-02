-- FrameMeta.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 11/8/2019, 2:20:54 PM
--
---@type ns
local ns = select(2, ...)

local Addon = ns.Addon
local Cache = ns.Cache
local BAG_ID = ns.BAG_ID

---@class FrameMeta: Object
local FrameMeta = Addon:NewClass('FrameMeta')

function FrameMeta:Constructor(bagId)
    self.bagId = bagId
    self.bags = ns.GetBags(bagId)
    self.title = ns.BAG_TITLES[bagId]
    self.icon = ns.BAG_ICONS[bagId]
    self.class = {}
    for k, v in pairs(ns.BAG_CLASSES[bagId]) do
        self.class[k] = ns.UI[v]
    end

    self:Update()
    self.frame = self.class.Frame:Create(self)
end

function FrameMeta:Update()
    self.sets = Addon.db.profile
    self.profile = Addon:GetFrameProfile(self.bagId)
    self.character = Addon:GetCharacterProfile(self.owner)
end

function FrameMeta:HasBag(bag)
    return self.bagId == ns.GetBagId(bag)
end

function FrameMeta:IsBank()
    return self.bagId == BAG_ID.BANK
end

function FrameMeta:IsBag()
    return self.bagId == BAG_ID.BAG
end

function FrameMeta:IsMail()
    return self.bagId == BAG_ID.MAIL
end

function FrameMeta:IsEquip()
    return self.bagId == BAG_ID.EQUIP
end

function FrameMeta:IsGlobalSearch()
    return self.bagId == BAG_ID.SEARCH
end

function FrameMeta:IsCached()
    return Cache:IsOwnerBagCached(self.owner, self.bags[1])
end

function FrameMeta:IsSelf()
    return ns.IsSelf(self.owner)
end

function FrameMeta:SetOwner(owner)
    owner = not ns.IsSelf(owner) and owner or nil

    if owner ~= self.owner then
        self.owner = owner
        self.character = Addon:GetCharacterProfile(owner)
        ns.Events:FireFrame('OWNER_CHANGED', self.bagId)
    end
end

function FrameMeta:ToggleBagHidden(bag)
    self.character.hiddenBags[bag] = not self.character.hiddenBags[bag]
    Addon:UpdateAll()
end

function FrameMeta:SetOption(key, value)
    self.profile[key] = value

    local event = ns.FRAME_OPTION_EVENTS[key]
    if event then
        ns.Events:FireFrame(event, self.bagId)
    else
        Addon:UpdateAll()
    end
end

function FrameMeta:ToggleOption(key)
    self:SetOption(key, not self.profile[key])
end

function FrameMeta:IsBagHidden(bag)
    return self.character.hiddenBags[bag]
end
