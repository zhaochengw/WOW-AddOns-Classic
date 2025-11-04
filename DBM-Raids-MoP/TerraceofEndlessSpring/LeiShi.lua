local mod	= DBM:NewMod(729, "DBM-Raids-MoP", 3, 320)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250906051052")
mod:SetCreatureID(62983)--62995 Animated Protector
mod:SetEncounterID(1506)
mod:SetZone(996)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Victory)--Kill detection is aweful. No death, no special cast. yell is like 40 seconds AFTER victory. terrible.
mod:SetUsedIcons(8, 7, 6, 5, 4, 3) -- on 25 heroic 6 guards spawn.

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 123250 123505 123461 123121 123705",
	"SPELL_AURA_APPLIED_DOSE 123121 123705",
	"SPELL_AURA_REMOVED 123250 123121 123461",
	"SPELL_CAST_START 123244 123705",
	"UNIT_HEALTH boss1",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnProtect						= mod:NewTargetNoFilterAnnounce(123250, 2)
local warnHideOver						= mod:NewAnnounce("warnHideOver", 2, 123244, nil, nil, nil, 123244)--Because we can. with creativeness, the boss returning is detectable a full 1-2 seconds before even visible. A good signal to stop aoe and get ready to return norm DPS
local warnSpray							= mod:NewStackAnnounce(123121, 3, nil, "Tank|Healer")

local specWarnAnimatedProtector			= mod:NewSpecialWarningSwitch(-6224, "-Healer", nil, nil, 1, 2)
local specWarnHide						= mod:NewSpecialWarningCount(123244, nil, nil, nil, 2, 2)
local specWarnGetAway					= mod:NewSpecialWarningCount(123461, nil, nil, nil, 2, 2)
local specWarnSpray						= mod:NewSpecialWarningStack(123121, "Tank", 6, nil, nil, 1, 6)
local specWarnSprayOther				= mod:NewSpecialWarningTaunt(123121, nil, nil, nil, 1, 2)

local timerSpecialCD					= mod:NewTimer(50, "timerSpecialCD", 123250, nil, nil, 6)--Variable, 49.5-55 seconds
local timerSpray						= mod:NewTargetTimer(10, 123121, nil, "Tank|Healer", nil, 5)
local timerGetAway						= mod:NewBuffActiveTimer(30, 123461, nil, nil, nil, 6)
local timerScaryFogCD					= mod:NewNextTimer(10, 123705, nil, nil, nil, 2)

local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnProtector", -6224, true, 5, {3, 4, 5, 6, 7, 8})

mod.vb.specialCast = 0
mod.vb.hideActive = false
mod.vb.specialRemaining = 0
mod.vb.addsIcon = 8
local lostHealth = 0
local prevlostHealth = 0
local lastProtect = 0--No sense making syncable varaible, it's GetTime which differs PC to PC
local hideName = DBM:GetSpellName(123244)

function mod:ScaryFogRepeat()
	timerScaryFogCD:Cancel()
	self:UnscheduleMethod("ScaryFogRepeat")
	local interval = 10 * (1/(1+lostHealth))--Seems that Scray Fog interval reduced by her casting speed. / EJ lies? seems on heroic, her casting speed increases by 1% per 1% health lost. (lfr: 0.8, normal: 0.9, heroic: 1.0?)
	timerScaryFogCD:Start(interval)
	self:ScheduleMethod(interval, "ScaryFogRepeat")
end

function mod:OnCombatStart(delay)
	self.vb.specialCast = 0
	self.vb.hideActive = false
	self.vb.specialRemaining = 0
	self.vb.addsIcon = 8
	lastProtect = 0
	lostHealth = 0
	prevlostHealth = 0
	timerSpecialCD:Start(30.5-delay, 1)--Variable, 30.5-37 (or aborted if 80% protect happens first)
	if self:IsHeroic() then
		berserkTimer:Start(420-delay)
	else
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 123250 then
		self.vb.addsIcon = 8--This event might be too late if adds spawn before protect goes up, needs testing
		local elapsed, total = timerSpecialCD:GetTime(self.vb.specialCast+1)
		self.vb.specialRemaining = total - elapsed
		lastProtect = GetTime()
		warnProtect:Show(args.destName)
		specWarnAnimatedProtector:Show()
		specWarnAnimatedProtector:Play("killmob")
		self:Schedule(0.2, function()
			timerSpecialCD:Cancel()
		end)
	elseif spellId == 123505 then
		if self.Options.SetIconOnProtector then
			self:ScanForMobs(args.destGUID, 2, self.vb.addsIcon, 1, nil, 8, "SetIconOnProtector", nil, nil, true)
		end
		self.vb.addsIcon = self.vb.addsIcon - 1
	elseif spellId == 123461 then
		self.vb.specialCast = self.vb.specialCast + 1
		specWarnGetAway:Show(self.vb.specialCast)
		specWarnGetAway:Play("pushbackincoming")
		timerSpecialCD:Start(nil, self.vb.specialCast+1)
		if self:IsHeroic() then
			timerGetAway:Start(45)
		else
			timerGetAway:Start()
		end
	elseif spellId == 123121 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then--Only want sprays that are on tanks, not bads standing on tanks.
			local amount = args.amount or 1
			timerSpray:Start(args.destName)
			if amount % 3 == 0 then
				warnSpray:Show(args.destName, amount)
				if amount >= 6 and args:IsPlayer() then
					specWarnSpray:Show(amount)
					specWarnSpray:Play("stackhigh")
				else
					if amount >= 6 and not DBM:UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
						specWarnSprayOther:Show(args.destName)
						specWarnSprayOther:Play("tauntboss")
					end
				end
			end
		end
	elseif spellId == 123705 and self:AntiSpam(2.5, 1) then
		self:ScaryFogRepeat()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 123250 then
		if timerSpecialCD:GetTime(self.vb.specialCast+1) == 0 then -- failsafe. (i.e : 79.8% hide -> protect... bar remains)
			local protectElapsed = GetTime() - lastProtect
			local specialCD = self.vb.specialRemaining - protectElapsed
			if specialCD < 5 then
				timerSpecialCD:Stop()
				timerSpecialCD:Start(5, self.vb.specialCast+1)
			else
				timerSpecialCD:Stop()
				timerSpecialCD:Start(specialCD, self.vb.specialCast+1)
			end
		end
	elseif spellId == 123121 then
		timerSpray:Cancel(args.destName)
	elseif spellId == 123461 then
		timerGetAway:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 123244 then
		self.vb.specialCast = self.vb.specialCast + 1
		self.vb.hideActive = true
		timerScaryFogCD:Cancel()
		self:UnscheduleMethod("ScaryFogRepeat")
		specWarnHide:Show(self.vb.specialCast)
		specWarnHide:Play("phasechange")
		timerSpecialCD:Start(nil, self.vb.specialCast+1)
		self:SetWipeTime(60)--If she hides at 1.6% or below, she will be killed during hide. In this situration, yell fires very slowly. This hack can prevent recording as wipe.
		self:RegisterShortTermEvents(
			"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register on hide, because it also fires just before hide, every time and don't want to trigger "hide over" at same time as hide.
		)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(3)--Show everyone during hide
		end
	elseif spellId == 123705 then
		self:ScaryFogRepeat()
	end
end

function mod:UNIT_HEALTH(uId)
	local currentHealth = 1 - (UnitHealth(uId) / UnitHealthMax(uId))
	if currentHealth and currentHealth < 1 and currentHealth > prevlostHealth then -- Failsafe.
		lostHealth = currentHealth
		prevlostHealth = currentHealth
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 127524 then
		DBM:EndCombat(self)
	end
end

--Fires twice when boss returns, once BEFORE visible (and before we can detect unitID, so it flags unknown), then once a 2nd time after visible
--"<233.9> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#nil#nil#Unknown#0xF130F6070000006C#normal#0#nil#nil#nil#nil#normal#0#nil#nil#nil#nil#normal#0#nil#nil#nil#nil#normal#0#Real Args:", -- [14168]
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	if self.vb.hideActive then
        self.vb.hideActive = false
		return
	end
	self:SetWipeTime(3)
	self:UnregisterShortTermEvents()--Once boss appears, unregister event, so we ignore the next two that will happen, which will be 2nd time after reappear, and right before next Hide.
	warnHideOver:Show(hideName)
end
