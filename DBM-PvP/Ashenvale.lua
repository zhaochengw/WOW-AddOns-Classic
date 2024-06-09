if WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC or not C_Seasons or C_Seasons.GetActiveSeason() ~= 2 then
	return
end
local MAP_ASHENVALE = 1440
local mod = DBM:NewMod("m" .. MAP_ASHENVALE, "DBM-PvP")
local L = mod:GetLocalizedStrings()

mod:SetRevision("20240205173535")
-- TODO: we could teach this thing to handle outdoor zones instead of only instances
-- when implementing this make sure that the stop functions are called properly, i.e., that ZONE_CHANGED_NEW_AREA still fires when leaving
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents(
	"LOADING_SCREEN_DISABLED",
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_ENTERING_WORLD",
	"UPDATE_UI_WIDGET"
)

mod:AddBoolOption("HealthFrame", nil, nil, function() mod:healthFrameOptionChanged() end)
local startTimer = mod:NewStageTimer(0, 20230, "EstimatedStart", nil, "EstimatedStartTimer", nil, nil, nil, true) -- last arg is "keep"

local widgetIDs = {
	[5360] = true, -- Alliance progress
	[5361] = true, -- Horde progress
	[5367] = true, -- Alliance bosses remaining
	[5368] = true, -- Horde bosses remaining
	[5378] = true, -- Event time remaining
}

mod.stateTracking = {
	alliance = {},
	horde = {},
}
-- Only used if DBM is set to debug mode, raw log of all state updates including duplicates and no reset between events
mod.debugStateTracking = {
	alliance = {},
	horde = {},
}

function mod:resetStateTracking()
	table.wipe(self.stateTracking.alliance)
	table.wipe(self.stateTracking.horde)
end

---@return number|nil
---@return number|nil
local function getEstimate(data)
	if #data < 3 then return end
	local latest = data[#data]
	for i = #data - 2, 1, -1 do -- estimate based on at least 2 ticks
		local entry = data[i]
		local timeDiff = latest.time - entry.time
		local diff = latest.percent - entry.percent
		if timeDiff > 120 then -- and at least 2 minutes
			if diff <= 0 then
				-- early in the prep phase it likes to randomly jump around a bit
				return
			end
			local rate = diff / timeDiff
			local totalTime = 100 / rate
			local remaining = (100 - latest.percent) / rate
			return remaining, totalTime
		end
	end
end

function mod:updateStartTimer()
	if self.eventRunning then
		-- prevent an update for the prep phase immediately after event start from re-starting timers
		-- (yes, this happened)
		return
	end
	-- Raw data dump example: https://docs.google.com/spreadsheets/d/15K8YfAKg0_cho0Ebj8iOlCCFbwoWj-QLcrDpZBpmuaA/edit#gid=0
	-- Layering can mess this up, we may want to detect large discontinuities in the data and just abort in that case
	-- TODO: we may want to consider rate limiting the timer update if it jumps around a lot
	-- however, these events here only gets triggered like once per minute and the rate is very stable (see data above)
	-- so I haven't observed jumpiness on the timer yet
	local aRemaining, aTotal = getEstimate(self.stateTracking.alliance)
	local hRemaining, hTotal = getEstimate(self.stateTracking.horde)
	if not aRemaining or not hRemaining or not aTotal or not hTotal then
		return
	end
	-- TODO: we can use the estimates to estimate the start time, this should yield the same result if the estimate is good
	-- TODO: some people on reddit claimed that once one faction reaches 100% their progress gets added to the other one
	-- this does not seem to be true as far as i can tell
	local remaining = math.max(aRemaining, hRemaining)
	local total = math.max(aTotal, hTotal)
	if total > 8 * 60 * 60 then -- estimates of > 8 hours total time are probably bad and useless anyways
		DBM:Debug("Got total time estimate of " .. total .. ", discarding")
		return
	end
	startTimer:Update(total - remaining, total)
	if remaining > 180 then
		startTimer:UpdateName(L.TimerEstimate)
	else -- last few minutes feel a bit random
		startTimer:UpdateName(L.TimerSoon)
	end
end

function mod:setupHealthTracking(hideFrame, forceRecreate)
	local generalMod = DBM:GetModByName("PvPGeneral")
	if forceRecreate and self.tracker then
		self.tracker:Cancel()
		self.tracker = nil
	end
	if not self.tracker then
		self.tracker = generalMod:NewHealthTracker({"YELL", "RAID"}, true)
		self.tracker:TrackHealth(212804, "RunestoneBoss", BLUE_FONT_COLOR)
		self.tracker:TrackHealth(212707, "GlaiveBoss", BLUE_FONT_COLOR)
		self.tracker:TrackHealth(212803, "ResearchBoss", BLUE_FONT_COLOR)
		self.tracker:TrackHealth(212970, "MoonwellBoss", BLUE_FONT_COLOR)
		self.tracker:TrackHealth(212801, "ShredderBoss", RED_FONT_COLOR)
		self.tracker:TrackHealth(212730, "CatapultBoss", RED_FONT_COLOR)
		self.tracker:TrackHealth(212802, "LumberBoss", RED_FONT_COLOR)
		self.tracker:TrackHealth(212969, "BonfireBoss", RED_FONT_COLOR)
	end
	if hideFrame then
		DBM.InfoFrame:Hide() -- still participate in syncing, just don't show the frame
	end
end

function mod:healthFrameOptionChanged()
	if self.eventRunning then
		self:setupHealthTracking(not self.Options.HealthFrame, true)
	end
end

function mod:startEvent()
	DBM:Debug("Detected start of Ashenvale event")
	startTimer:Stop()
	self:setupHealthTracking(not self.Options.HealthFrame)
end

function mod:stopEvent()
	DBM:Debug("Detected end of Ashenvale event or leaving zone")
	startTimer:Stop()
	if self.tracker then
		self.tracker:Cancel()
		self.tracker = nil
	end
	self:resetStateTracking()
end

function mod:checkEventState()
	local eventTime = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(5378)
	if eventTime and eventTime.state ~= Enum.IconAndTextWidgetState.Hidden then
		if not self.eventRunning then
			self.eventRunning = true
			self:startEvent()
		end
	elseif self.eventRunning then
		self.eventRunning = false
		self:stopEvent()
	end
end

function mod:UPDATE_UI_WIDGET(tbl)
	if not self.inZone then
		return
	end
	if tbl and widgetIDs[tbl.widgetID] then
		self:checkEventState()
	end
	-- There's a lot of messy logic that evaluates all kind of weird data that I've observed, some of this can likely
	-- be deleted once these fixes land:
	-- https://www.bluetracker.gg/wow/topic/us-en/1742396-update-on-the-battle-for-ashenvale-and-layers-12142023/
	if tbl.widgetID == 5360 or tbl.widgetID == 5361 then
		local info = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(tbl.widgetID)
		local percent = info and info.text and info.text:match("(%d+)")
		if percent then
			percent = tonumber(percent)
			if DBM.Options.DebugMode then
				local data = tbl.widgetID == 5360 and self.debugStateTracking.alliance or self.debugStateTracking.horde
				data[#data + 1] = {time = GetTime(), percent = percent}
			end
			if percent < 4 then
				-- progress seems to reset a few times when the prep phase is starting
				-- i guess this may be related to different layers finishing resetting it?
				-- anyways, let's just start at 4% to avoid reporting nonsense at the beginning
				return
			end
			local data = tbl.widgetID == 5360 and self.stateTracking.alliance or self.stateTracking.horde
			if data[#data] and data[#data].percent >= 100 then
				-- stop updating once it reaches 100. yes it can go down by a few percent(who knows why?), but we don't care
				return
			end
			-- sometimes it drops by exactly one percent, usually only for half a second, so just ignore drops by exactly one in general
			if data[#data] and data[#data].percent == percent + 1 then
				return
			end
			-- Sometimes it just randomly drops by several percent, e.g.,
			-- https://docs.google.com/spreadsheets/d/15K8YfAKg0_cho0Ebj8iOlCCFbwoWj-QLcrDpZBpmuaA/edit#gid=331144407
			-- This should no longer happen since Dec 15th 2023
			if data[#data] and data[#data].percent - percent >= 3 then
				-- I've seen it randomly jump around between two different values for a minute or so, don't spam the user in this case
				if startTimer:IsStarted() and self:AntiSpam(120, 1) then
					self:AddMsg(L.ErrorSuddenDrop, L.InfoMsgPrefix)
				end
				self:resetStateTracking()
			end
			local time = GetTime()
			-- Updates sometimes trigger multiple times with the new and old value mixed together
			-- These duplicate triggers happen on the same frame and the latest value seems to be the current one
			if data[#data] and data[#data].time == time then
				data[#data] = nil
			end
			if not data[#data] or data[#data].percent ~= percent then
				data[#data + 1] = {time = GetTime(), percent = percent}
				self:updateStartTimer()
			end
		end
	end
end

function mod:enterAshenvale()
	self.inZone = true
	self:checkEventState()
end

function mod:leaveAshenvale()
	self.inZone = false
	self:stopEvent()
end

function mod:ZoneChanged()
	local map = C_Map.GetBestMapForUnit("player")
	if map == MAP_ASHENVALE and not self.inZone then
		self:enterAshenvale()
	elseif map ~= MAP_ASHENVALE and self.inZone then
		self:leaveAshenvale()
	end
end
mod.LOADING_SCREEN_DISABLED = mod.ZoneChanged
mod.ZONE_CHANGED_NEW_AREA   = mod.ZoneChanged
mod.PLAYER_ENTERING_WORLD   = mod.ZoneChanged
mod.OnInitialize            = mod.ZoneChanged

function mod:DebugExportState()
	local state = DBM.Options.DebugMode and self.debugStateTracking or self.stateTracking
	local export = {"Time,Alliance,Horde"}
	local a, h = 1, 1
	while true do
		local entryA = state.alliance[a]
		local entryH = state.horde[h]
		if not entryA and not entryH then
			break
		end
		if not entryH or entryA and entryA.time < entryH.time then
			export[#export + 1] = entryA.time .. "," .. entryA.percent
			a = a + 1
		else
			export[#export + 1] = entryH.time .. ",," .. entryH.percent
			h = h + 1
		end
	end
	DBM:ShowUpdateReminder(nil, nil, "CSV dump of progress data for last event", table.concat(export, "\n"))
end
