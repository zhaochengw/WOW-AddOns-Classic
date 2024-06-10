if not C_Seasons or C_Seasons.GetActiveSeason() ~= 2 then
	return
end
local MAP_ASHENVALE = 1440
local mod = DBM:NewMod("m" .. MAP_ASHENVALE, "DBM-PvP")

local pvpMod = DBM:GetModByName("PvPGeneral")

mod:SetRevision("20240505221847")
-- TODO: we could teach this thing to handle outdoor zones instead of only instances
-- when implementing this make sure that the stop functions are called properly, i.e., that ZONE_CHANGED_NEW_AREA still fires when leaving
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents(
	"LOADING_SCREEN_DISABLED",
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_ENTERING_WORLD",
	"UPDATE_UI_WIDGET",
	"UNIT_AURA player"
)

mod:AddBoolOption("HealthFrame", nil, nil, function() mod:healthFrameOptionChanged() end)
local startTimer = mod:NewStageTimer(0, 20230, "EstimatedStart", nil, "EstimatedStartTimer")

local widgetIDs = {
	[5367] = true, -- Alliance bosses remaining
	[5368] = true, -- Horde bosses remaining
	[5378] = true, -- Event time remaining
}

-- Observed start times:
-- 16:00:12

local function debugTimeString()
	local time = date("*t", GetServerTime())
	local gameHour, gameMin = GetGameTime()
	return ("server time %02d:%02d:%02d, game time %02d:%02d"):format(time.hour, time.min, time.sec, gameHour, gameMin)
end

function mod:updateStartTimer()
	if self.eventRunning then
		-- prevent an update for the prep phase immediately after event start from re-starting timers
		-- (yes, this happened)
		return
	end
	local remaining = pvpMod:GetTimeUntilWorldPvpEvent(1)
	local total = 3 * 60 * 60
	if remaining < 2.75 * 60 * 60 then
		startTimer:Update(total - remaining, total)
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

function mod:UNIT_AURA(target)
	if target ~= "player" then return end
	local wasInDream = self.inEmeraldDream
	self.inEmeraldDream = not not C_UnitAuras.GetPlayerAuraBySpellID(444759)
	if self.inZone and self.eventRunning then
		if self.tracker and self.Options.HealthFrame and not self.inEmeraldDream then
			-- Only re-show it if we left the Emerald Dream to avoid re-showing it if it was hidden via the dropdown menu
			if wasInDream then
				self.tracker:ShowInfoFrame()
			end
		else
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:startEvent()
	DBM:Debug("Detected start of Ashenvale event at " .. debugTimeString())
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
end

function mod:enterAshenvale()
	self.inZone = true
	self:checkEventState()
	self:updateStartTimer()
end

function mod:leaveAshenvale()
	self.inZone = false
	self:stopEvent()
	startTimer:Stop()
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
