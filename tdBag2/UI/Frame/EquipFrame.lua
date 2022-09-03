-- EquipFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 1/13/2022, 1:45:58 PM
--
---@type ns
local ns = select(2, ...)

local SimpleFrame = ns.UI.SimpleFrame

---@class UI.EquipFrame: UI.SimpleFrame
local EquipFrame = ns.Addon:NewClass('UI.EquipFrame', SimpleFrame)
EquipFrame.CENTER_TEMPLATE = 'tdBag2EquipContainerCenterFrameBaseTemplate'
EquipFrame.TOGGLES = {ns.BAG_ID.BAG, ns.BAG_ID.BANK, ns.BAG_ID.MAIL, ns.BAG_ID.SEARCH}
EquipFrame.FACTION_LOGO_ICONS = {
    Alliance = [[Interface\Timer\Alliance-Logo]],
    Horde = [[Interface\Timer\Horde-Logo]],
    Neutral = [[Interface\Timer\Panda-Logo]],
}

function EquipFrame:Constructor()
    ---@type tdBag2EquipContainerCenterFrameTemplate
    self.CenterFrame = CreateFrame('Frame', nil, self, self.CENTER_TEMPLATE)

    for i, bagId in ipairs(self.TOGGLES) do
        ns.UI.EquipBagToggle:Bind(assert(self.CenterFrame.toggles[i]), self.meta, bagId)
    end
end

function EquipFrame:OnShow()
    SimpleFrame.OnShow(self)
    self:UpdateCenter()
    self:RegisterFrameEvent('OWNER_CHANGED', 'UpdateCenter')
end

function EquipFrame:UpdateCenter()
    self:UpdateInfo()
    self:UpdateBackground()
end

function EquipFrame:UpdateInfo()
    if self.meta:IsSelf() then
        self.CenterFrame.Model:SetUnit('player')
        self.CenterFrame.Model:Show()
        self.CenterFrame.NoModel:Hide()
    else
        local ownerInfo = ns.Cache:GetOwnerInfo(self.meta.owner)
        self.CenterFrame.NoModel.Faction:SetTexture(self.FACTION_LOGO_ICONS[ownerInfo.faction])
        self.CenterFrame.NoModel:Show()
        self.CenterFrame.Model:Hide()
    end
end

function EquipFrame:UpdateBackground()
end
