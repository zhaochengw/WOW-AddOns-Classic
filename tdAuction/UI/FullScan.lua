-- FullScan.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 9/18/2020, 3:30:19 PM
--
---@type ns
local ns = select(2, ...)

local L = ns.L

local STATUS_IDLE = 1
local STATUS_QUERY = 2
local STATUS_SCAN = 3
local STATUS_DONE = 4

---@type FullScan
local FullScan = ns.Addon:NewClass('UI.FullScan', 'Frame')

function FullScan:Constructor()
    self.scaner = ns.FullScaner:New()
    self.scaner:SetCallback('OnDone', function()
        return self:OnDone()
    end)
    self.scaner:SetCallback('OnResponse', function()
        self.status = STATUS_SCAN
        self.ProgressBar:SetMinMaxValues(0, self.scaner.total)
        self.ProgressBar:Show()
    end)
    self.scaner:SetCallback('OnProgress', function()
        self.ProgressBar:SetValue(self.scaner.progress)
        self.ProgressBar.Text:SetFormattedText('%d%%', self.scaner.progress / self.scaner.total * 100)
    end)

    self.HeaderText:SetText(L['Full scan'])
    self.ExecButton:SetText(L['Start scan'])

    self.statusUpdates = { --
        [STATUS_IDLE] = self.UpdateIdle,
        [STATUS_QUERY] = self.UpdateQuering,
        [STATUS_SCAN] = self.UpdateScanning,
    }

    self:HookScript('OnShow', self.OnShow)
    self:SetScript('OnUpdate', self.OnUpdate)
end

function FullScan:OnShow()
    self.status = STATUS_IDLE
    self.ProgressBar:Hide()
end

function FullScan:OnHide()
    self:Hide()
end

function FullScan:OnUpdate()
    self.ExecButton:SetEnabled(self.status == STATUS_IDLE and self:CanQuery())
    self.CloseButton:SetEnabled(self.status ~= STATUS_QUERY)

    local method = self.statusUpdates[self.status]
    if method then
        method(self)
    end
end

function FullScan:Start()
    self.status = STATUS_QUERY
    self.startTick = GetTime()
    self.scaner:Query()
end

function FullScan:OnDone()
    self.status = STATUS_DONE
    self:UpdateReport()
    self.CloseButton:Enable()
    self.ProgressBar:Hide()
end

function FullScan:UpdateReport()
    self.Text:SetText(self.scaner.report)
end

function FullScan:UpdateIdle()
    if self:CanQuery() then
        self.Text:SetFormattedText('%s %s', L['Next available time:'], L['Now'])
    elseif not self.startTick then
        self.Text:SetFormattedText('%s %s', L['Next available time:'], L['Unknown'])
    else
        self.Text:SetFormattedText('%s %s', L['Next available time:'],
                                   format(L['in about %s'], SecondsToTime(self.startTick + 15 * 60 - GetTime())))
    end
end

function FullScan:UpdateQuering()
    self.Text:SetFormattedText(L['Full scaning, elapsed time: %s'], SecondsToTime(GetTime() - self.startTick))
end

function FullScan:UpdateScanning()
    self.Text:SetFormattedText(L['Processing data, elapsed time: %s'], SecondsToTime(GetTime() - self.startTick))
end

function FullScan:CanQuery()
    if ns.Querier.queryAllDisabled then
        return false
    end
    local canQuery, canQueryAll = CanSendAuctionQuery('list')
    return canQuery and canQueryAll
end
