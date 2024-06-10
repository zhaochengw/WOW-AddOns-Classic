if not C_Seasons or C_Seasons.GetActiveSeason() ~= 2 then
	return
end
local MAP_STRANGLETHORN = 1434
local mod = DBM:NewMod("m" .. MAP_STRANGLETHORN, "DBM-PvP")
local L = mod:GetLocalizedStrings()

local pvpMod = DBM:GetModByName("PvPGeneral")

mod:SetRevision("20240505221847")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents(
	"LOADING_SCREEN_DISABLED",
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_ENTERING_WORLD",
	"UPDATE_UI_WIDGET",
	"SPELL_AURA_APPLIED 441785"
)

local startTimer = mod:NewNextTimer(0, 436097)
local eventRunningTimer = mod:NewBuffActiveTimer(30 * 60, 436097)
local resTimerSelf = mod:NewBuffFadesTimer(20, 441785, nil, nil, "ResTimerSelf")
local resTimerParty = mod:NewTargetTimer(20, 441785, nil, false, "ResTimerParty")

mod:AddBoolOption("ResTimerPartyClassColors", true)

-- FIXME: work-around for options until https://github.com/DeadlyBossMods/DBM-Unified/pull/447 is released
local modLocale = DBM:GetModLocalization("m1434")
modLocale:SetOptionLocalization({
	ResTimerSelf = L.ResTimerSelf,
	ResTimerParty = L.ResTimerParty,
	ResTimerPartyClassColors = L.ResTimerPartyClassColors,
})

local widgetIDs = {
	[5608] = true, -- Event active (shows up after ~5 minutes)
	[5609] = true, -- Event not active
}

-- Observed start and end times (GetServerTime()), seems to be exactly 30 minutes but start/end is a bit random
-- 18:00:58 to 18:30:58
-- 21:00:48 to 21:30:47
-- 12:00:?? to 12:30:36
-- 21:00:38 to 21:30:38
-- 00:00:?? to 00:30:36
-- 12:00:16 to 12:30:17
-- 15:00:12 to 15:30:12

function mod:updateStartTimer()
	local remaining = pvpMod:GetTimeUntilWorldPvpEvent()
	local total = 3 * 60 * 60
	if remaining < 2.5 * 60 * 60 then
		startTimer:Update(total - remaining, total)
	else
		startTimer:Stop()
	end
end

local function debugTimeString()
	local time = date("*t", GetServerTime())
	local gameHour, gameMin = GetGameTime()
	return ("server time %02d:%02d:%02d, game time %02d:%02d"):format(time.hour, time.min, time.sec, gameHour, gameMin)
end

function mod:startEvent(timeRemaining)
	DBM:Debug("Start/update Stranglethorn event, " .. timeRemaining .. " minutes at " .. debugTimeString())
	if not self.eventRunning then
		startTimer:Stop()
	end
	self.eventRunning = true
	if not eventRunningTimer:IsStarted() and timeRemaining > 0 then -- Event start sometimes triggers for 0 minutes
		-- Event starts triggers two updates at the exact same time for 31 and 30
		-- Event goes for exactly 30 minutes after we first see an update like this
		if timeRemaining == 31 or timeRemaining == 30 then
			eventRunningTimer:Start()
		else
			-- We joined late, this is a bit messy because the widget updates and time remaining is only poorly correlated with actual timings.
			-- For example, event triggers like this are common:
			-- 3 minute at 28:35 server time, 1 minute at 29:38 server time, ended at 30:36 (2 min update was just skipped)
			-- 3 minute at 28:10 server time, 2 minute at 29:13 server time, 1 minute at 30:15 server time, ended at 30:17
			local remaining = pvpMod:GetTimeUntilWorldPvpEvent() - 2.5 * 60 * 60
			eventRunningTimer:Update(30 * 60 - remaining, 30 * 60)
		end
	end
end


function mod:stopEvent()
	DBM:Debug(("Detected end of Stranglethorn event or leaving zone, time remaining on timer: %.2f"):format(eventRunningTimer:GetRemaining()))
	startTimer:Stop()
	eventRunningTimer:Stop()
	self.eventRunning = false
	DBM:Debug("Event stopped at " .. debugTimeString())
end

function mod:checkEventState()
	local eventRunning = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(5608)
	local eventNotRunning = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(5609)
	local eventRunningShown = eventRunning and eventRunning.state ~= Enum.IconAndTextWidgetState.Hidden
	local eventNotRunningShown = eventNotRunning and eventNotRunning.state ~= Enum.IconAndTextWidgetState.Hidden
	if eventNotRunningShown then
		if self.eventRunning then
			self.eventRunning = false
			self:stopEvent()
		end
	end
	if eventNotRunningShown or (not eventNotRunningShown and not eventRunningShown) then
		self:updateStartTimer()
	end
end

function mod:UPDATE_UI_WIDGET(tbl)
	if not self.inZone then
		return
	end
	if tbl and widgetIDs[tbl.widgetID] then
		self:checkEventState()
	end
	if tbl.widgetID == 5608 then
		local info = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(5608)
		if info and info.state ~= Enum.IconAndTextWidgetState.Hidden and info.text then
			local timeRemaining = info.text:match(L.ParseTimeFromWidget)
			timeRemaining = tonumber(timeRemaining) or -1
			self:startEvent(timeRemaining)
		end
	end
end

function mod:enterStranglethorn()
	self.inZone = true
	self:checkEventState()
	self:updateStartTimer()
end

function mod:leaveStranglethorn()
	self.inZone = false
	self:stopEvent()
	startTimer:Stop()
	startTimer:Stop()
end

function mod:ZoneChanged()
	local map = C_Map.GetBestMapForUnit("player")
	if map == MAP_STRANGLETHORN and not self.inZone then
		self:enterStranglethorn()
	elseif map ~= MAP_STRANGLETHORN and self.inZone then
		self:leaveStranglethorn()
	end
end
mod.LOADING_SCREEN_DISABLED = mod.ZoneChanged
mod.ZONE_CHANGED_NEW_AREA   = mod.ZoneChanged
mod.PLAYER_ENTERING_WORLD   = mod.ZoneChanged
mod.OnInitialize            = mod.ZoneChanged

-- "<25.40 00:30:28> [GOSSIP_SHOW] Creature-0-5208-0-20366-219822-0003E3B087#121411:Return me to life.",
-- "<26.41 00:30:29> [CLEU] SPELL_AURA_APPLIED#Player-5826-020CBDBB#Tandanu#Player-5826-020CBDBB#Tandanu#441785#Drained of Blood#DEBUFF#nil",
function mod:SPELL_AURA_APPLIED(args)
	if not self.eventRunning then
		return
	end
	if args:IsSpellID(441785) and args:IsDestTypePlayer() then
		local isPartyOrMe = args:IsPlayer()	or bit.band(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY) ~= 0
		if isPartyOrMe then
			self:SendSync("Res", args.destName)
		end
	end
end

local playerName = UnitName("player")

function mod:OnSync(msg, target, sender)
	if msg ~= "Res" or type(target) ~= "string" or not DBM:GetRaidRoster(target) then
		return
	end
	if target == playerName then
		-- Only you can start the timer for you
		-- This prevents some abuse because this timer is enabled by default and you are in a group with effectively random people
		if sender == playerName then
			resTimerSelf:Start()
		end
	elseif self.Options.ResTimerParty and not resTimerParty:IsStarted(target) then
		resTimerParty:Start(target)
		if self.Options.ResTimerPartyClassColors then
			local color = RAID_CLASS_COLORS[DBM:GetRaidClass(target)]
			resTimerParty:SetColor({r = color.r, g = color.g, b = color.b}, target)
		end
	end
end
