-- EquipContainer.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 1/10/2022, 8:29:17 PM
--
local pairs = pairs

---@type ns
local ns = select(2, ...)

local INVSLOT_LAST_EQUIPPED = INVSLOT_LAST_EQUIPPED

local SIZE = ns.ITEM_SIZE + 4

---@class UI.EquipContainer: UI.Container
local EquipContainer = ns.Addon:NewClass('UI.EquipContainer', ns.UI.Container)
EquipContainer.LAYOUT_OFFSETS = { --
    LEFT = {x = 0, y = 0},
    RIGHT = {x = 0, y = 0},
    BOTTOM = {x = 0, y = 0},
}

function EquipContainer:Constructor()
    self:SetSize(313, 343)

    local bag = self.meta.bags[1]

    for slot = 1, INVSLOT_LAST_EQUIPPED do
        local anchors = ns.INV_ANCHORS[slot]
        if anchors then
            local itemButton = self:GetItemButton(bag, slot)
            local pos = self.LAYOUT_OFFSETS[anchors.anchor]
            local point, x, y

            if anchors.anchor == 'LEFT' then
                point = 'TOPLEFT'
                x = pos.x
                y = pos.y - SIZE * anchors.index
            elseif anchors.anchor == 'RIGHT' then
                point = 'TOPRIGHT'
                x = pos.x
                y = pos.y - SIZE * anchors.index
            elseif anchors.anchor == 'BOTTOM' then
                point = 'BOTTOM'
                x = pos.x + SIZE * anchors.index
                y = pos.y
            end

            itemButton:ClearAllPoints()
            itemButton:SetPoint(point, self, point, x, y)
        end
    end
end

function EquipContainer:OnLayout()
    local bag = self.meta.bags[1]
    for slot = 1, self:NumSlots(bag) do
        self:GetItemButton(bag, slot):Show()
    end
end

function EquipContainer:FreeAll()
    local bag = self.meta.bags[1]
    for _, itemButton in pairs(self.itemButtons[bag]) do
        itemButton:Free()
    end
end
