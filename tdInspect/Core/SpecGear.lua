-- SpecGear.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 3/12/2025, 12:08:16 PM
--
---@type ns
local ns = select(2, ...)

---@class SpecGear: AceModule, EventHandler
local SpecGear = ns.Addon:NewModule('SpecGear')
ns.Events:Embed(SpecGear)

function SpecGear:OnInitialize()
    self.gears = ns.char.gears
    self:Event('ACTIVE_TALENT_GROUP_CHANGED')
end

function SpecGear:ACTIVE_TALENT_GROUP_CHANGED()
    local group = GetActiveTalentGroup()
    local equipmentSetId = self.gears[group]
    if equipmentSetId then
        local name = C_EquipmentSet.GetEquipmentSetInfo(equipmentSetId)
        if name then
            C_EquipmentSet.UseEquipmentSet(equipmentSetId)
        end
    end
end

function SpecGear:SetSpecGear(group, equipmentSetId)
    self.gears[group] = equipmentSetId
end

function SpecGear:GetSpecGear(group)
    return self.gears[group]
end
