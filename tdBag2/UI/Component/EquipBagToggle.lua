-- EquipBagToggle.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 1/14/2022, 4:35:35 PM
--
local CreateFrame = CreateFrame

local GameTooltip = GameTooltip

---@type ns
local ns = select(2, ...)

---@class UI.EquipBagToggle: Object, Button, tdBag2EquipBagToggleFrameTemplate
local EquipBagToggle = ns.Addon:NewClass('UI.EquipBagToggle', 'Button')
EquipBagToggle.TEMPLATE = 'tdBag2EquipBagToggleFrameTemplate'

function EquipBagToggle:Constructor(_, meta, bagId)
    ---@type FrameMeta
    self.meta = meta
    self.bagId = bagId
    self.tooltip = ns.BAG_TOOLTIPS[bagId]
    self.icon:SetTexture(ns.BAG_ICONS[bagId])

    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', GameTooltip_Hide)
end

function EquipBagToggle:Create(parent, meta, bagId)
    return self:Bind(CreateFrame('Button', nil, parent, self.TEMPLATE), meta, bagId)
end

function EquipBagToggle:OnClick()
    if self.bagId == ns.BAG_ID.SEARCH then
        ns.Addon:ToggleFrame(self.bagId, true)
    else
        ns.Addon:ToggleOwnerFrame(self.bagId, self.meta.owner)
    end
end

function EquipBagToggle:OnEnter()
    GameTooltip:SetOwner(self, 'ANCHOR_TOP')
    GameTooltip:SetText(self.tooltip)
    GameTooltip:Show()
end
