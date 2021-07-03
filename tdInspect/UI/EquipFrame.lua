-- EquipFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 5/18/2020, 1:28:20 AM

---@type ns
local ns = select(2, ...)

local pairs, ipairs = pairs, ipairs

local Inspect = ns.Inspect

local EQUIP_SLOTS = {
    {id = 1, name = HEADSLOT}, --
    {id = 2, name = NECKSLOT}, --
    {id = 3, name = SHOULDERSLOT}, --
    {id = 15, name = BACKSLOT}, --
    {id = 5, name = CHESTSLOT}, --
    {id = 9, name = WRISTSLOT}, --
    {id = 10, name = HANDSSLOT}, --
    {id = 6, name = WAISTSLOT}, --
    {id = 7, name = LEGSSLOT}, --
    {id = 8, name = FEETSLOT}, --
    {id = 11, name = FINGER0SLOT}, --
    {id = 12, name = FINGER1SLOT}, --
    {id = 13, name = TRINKET0SLOT}, --
    {id = 14, name = TRINKET1SLOT}, --
    {id = 16, name = MAINHANDSLOT}, --
    {id = 17, name = SECONDARYHANDSLOT}, --
    {id = 18, name = RANGEDSLOT}, --
}

---@type tdInspectEquipFrame
local EquipFrame = ns.Addon:NewClass('UI.EquipFrame', 'Frame')

function EquipFrame:Constructor()
    self.buttons = {}

    for i, v in ipairs(EQUIP_SLOTS) do
        local button = ns.UI.EquipItem:New(self, v.id, v.name, i % 2 == 1)
        local y = -(i - 1) * 17 - 9
        button:SetPoint('TOPLEFT', 10, y)
        button:SetPoint('TOPRIGHT', -10, y)
        self.buttons[v.id] = button
    end

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.UnregisterAllMessages)
end

function EquipFrame:OnShow()
    self:RegisterMessage('INSPECT_READY', 'Update')
    self:Update()
end

function EquipFrame:Update()
    for _, item in pairs(self.buttons) do
        item:Update()
    end
end
