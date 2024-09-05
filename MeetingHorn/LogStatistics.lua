-- LogStatistics.lua
-- @Date   : 07/09/2024, 3:43:12 PM
--
-- @Description :

---@type ns
local ns = select(2, ...)

local LogStatistics = ns.Addon:NewModule('LogStatistics', 'AceEvent-3.0', 'AceTimer-3.0', 'AceComm-3.0', 'LibCommSocket-3.0')
ns.LogStatistics = LogStatistics

function LogStatistics:OnInitialize()
    self.isSendExposure = false
    self.logs = {}
    C_Timer.NewTicker(60 * 5, function() self:SendLogs() end)
end

function LogStatistics:OnEnable()
    self:RegisterEvent('PLAYER_LOGOUT')
    self:RegisterEvent('PLAYER_LEAVING_WORLD')
end

function LogStatistics:SendServerExposure()
    if not ns.GoodLeader:IsServerLogon() or self.isSendExposure then
        return
    end
    local version = '199701010000' -- 这里更新写默认版本号
    if ns.LFG:IsStarRegimentVersion(version) then
        version =  ns.LFG:GetStarRegimentVersion()
    end

    ns.LFG:SendServer('EXPOSURE', version, ns.ADDON_VERSION)
    self.isSendExposure = true
end

function LogStatistics:InsertLog(log)
    if not log then
        return
    end
    table.insert(self.logs, log)
end

function LogStatistics:SendLogs()
    if not ns.GoodLeader:IsServerLogon() then
        return
    end
    if #self.logs > 0 then
        ns.LFG:SendServer('STATISTICS', self.logs)
    end
    self.logs = {}
end

function LogStatistics:PLAYER_LEAVING_WORLD()
    self:SendLogs()
end

function LogStatistics:PLAYER_LOGOUT()
    self:SendLogs()
end
