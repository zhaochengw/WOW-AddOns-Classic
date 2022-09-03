-- TitleFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/18/2019, 10:14:01 AM
--
local format = string.format

local IsAltKeyDown = IsAltKeyDown
local Ambiguate = Ambiguate

---@type ns
local ns = select(2, ...)
local L = ns.L
local Cache = ns.Cache

---@class UI.TitleFrame: EventsMixin, Object, Button
local TitleFrame = ns.Addon:NewClass('UI.TitleFrame', 'Button')

function TitleFrame:Constructor(_, meta)
    ---@type FrameMeta
    self.meta = meta
    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)
    self:SetScript('OnMouseDown', self.OnMouseDown)
    self:SetScript('OnMouseUp', self.OnMouseUp)
    self:SetScript('OnClick', self.OnClick)
    self:RegisterForClicks('RightButtonUp')
end

function TitleFrame:OnShow()
    self:Update()
    self:RegisterFrameEvent('OWNER_CHANGED', 'Update')
    self:RegisterEvent('TEXT_OFFLINE_TOGGLED', 'Update')
    self:RegisterEvent('UPDATE_ALL', 'Update')

    if self.meta:IsBank() then
        self:RegisterEvent('BANK_OPENED', 'Update')
        self:RegisterEvent('BANK_CLOSED', 'Update')
    end
end

function TitleFrame:OnHide()
    self:UnregisterAllEvents()
    if self.moving then
        self:OnMouseUp()
    end
end

function TitleFrame:OnMouseDown(button)
    if button == 'LeftButton' and not self.meta.profile.managed and (not self.meta.sets.lockFrame or IsAltKeyDown()) then
        self.meta.frame:StartMoving()
        self.moving = true
    end
end

function TitleFrame:OnMouseUp(button)
    if button == 'LeftButton' then
        local parent = self.meta.frame
        parent:StopMovingOrSizing()
        parent:SavePosition()
        self.moving = nil
    end
end

function TitleFrame:OnClick(button)
    if button == 'RightButton' then
        ns.Addon:OpenFrameOption(self.meta.bagId)
    end
end

function TitleFrame:Update()
    local name = Cache:GetOwnerInfo(self.meta.owner).name
    local title = name and format(self.meta.title, Ambiguate(name, 'none')) or self.meta.title
    if self.meta.sets.textOffline and self.meta:IsCached() and not self.meta:IsGlobalSearch() then
        title = title .. ' ' .. L['|cffff2020(Offline)|r']
    end
    self:SetText(title)
end
