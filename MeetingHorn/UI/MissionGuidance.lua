-- MissionGuidance.lua
-- @Date   : 07/01/2024, 10:01:07 AM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local MissionGuidance = ns.Addon:NewClass('UI.MissionGuidance', 'Frame')

function MissionGuidance:Constructor()
    self.db = ns.Addon.db
    self:SetScript('OnShow', self.OnShow)

end

function MissionGuidance:OnShow()
    ns.LogStatistics:InsertLog({time(), 3})
end
