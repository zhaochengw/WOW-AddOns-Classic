local mod	= DBM:NewMod(156, "DBM-Raids-Cata", 4, 72)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103125714")
mod:SetCreatureID(44600)
mod:SetEncounterID(1030)
mod:SetZone(671)
--mod:SetModelSound("Sound\\Creature\\Chogall\\VO_BT_Chogall_BotEvent02.ogg", "Sound\\Creature\\Halfus\\VO_BT_Halfus_Event07.ogg")
--Long: Halfus! Hear me! The master calls, the master wants! Protect our secrets, Halfus! Destroy the intruders! Murder for his glory, murder for his hunger!
--Short: Dragons to my side!

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 83710 83707 83703",
	"SPELL_AURA_APPLIED 87683 84030 83908",
	"SPELL_AURA_APPLIED_DOSE 87683 83908",
	"SPELL_AURA_REMOVED 83908"
)

local warnBreath			= mod:NewCountAnnounce(83707, 3)
local warnVengeance			= mod:NewStackAnnounce(87683, 3)
local warnParalysis			= mod:NewSpellAnnounce(84030, 2)
local warnMalevolentStrike	= mod:NewStackAnnounce(83908, 2, nil, "Tank|Healer")

local specWarnFuriousRoar	= mod:NewSpecialWarningCount(83710, nil, nil, nil, 2, 2)
local specWarnShadowNova	= mod:NewSpecialWarningInterrupt(83703, "HasInterrupt", nil, nil, 1, 2)
local specWarnMalevolent	= mod:NewSpecialWarningStack(83908, nil, 8, nil, nil, 1, 6)

local timerFuriousRoarCD	= mod:NewCDCountTimer("d30", 83710, nil, nil, nil, 2)
local timerBreathCD			= mod:NewCDCountTimer(20, 83707, nil, nil, nil, 3)--every 20-25 seconds.
local timerParalysis		= mod:NewBuffActiveTimer(12, 84030, nil, nil, nil, 5)
local timerParalysisCD		= mod:NewCDTimer(35, 84030, 84030, nil, nil, nil, 2)
local timerNovaCD			= mod:NewCDTimer(7.2, 83703, nil, "HasInterrupt", 2, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--7.2 is actually exact next timer, but since there are other variables like roars, or paralysis that could mis time it, we use CD bar instead so we don't give false idea of precision.
local timerMalevolentStrike	= mod:NewTargetTimer(30, 83908, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

local berserkTimer			= mod:NewBerserkTimer(360)

mod.vb.roarCount = 0
mod.vb.breathCount = 0

function mod:OnCombatStart(delay)
	self.vb.roarCount = 0
	self.vb.breathCount = 0
	berserkTimer:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then--On heroic we know for sure the drake has breath ability.
		timerBreathCD:Start(10-delay, 1)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 83710 and self:AntiSpam(6) then
		self.vb.roarCount = self.vb.roarCount + 1
		specWarnFuriousRoar:Show(self.vb.roarCount)
		specWarnFuriousRoar:Play("stunsoon")
		timerFuriousRoarCD:Cancel()--We Cancel any scheduled roar timers before doing anything else.
		timerFuriousRoarCD:Start(nil, self.vb.roarCount+1)--And start a fresh one.
		timerFuriousRoarCD:Schedule(30, self.vb.roarCount+2)--If it comes off CD while he's stunned by paralysis, he no longer waits to casts it after stun, it now consumes his CD as if it was cast on time. This is why we schedule this timer. So we get a timer for next roar after a stun.
	elseif args.spellId == 83707 then
		self.vb.breathCount = self.vb.breathCount + 1
		warnBreath:Show(self.vb.breathCount)
		timerBreathCD:Start(nil, self.vb.breathCount+1)
	elseif args.spellId == 83703 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnShadowNova:Show(args.sourceName)
			specWarnShadowNova:Play("kickcast")
		end
		timerNovaCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 87683 then
		warnVengeance:Show(args.destName, args.amount or 1)
	elseif args.spellId == 84030 then
		warnParalysis:Show()
		timerParalysis:Start()
		timerParalysisCD:Start()
	elseif args.spellId == 83908 then
		timerMalevolentStrike:Stop(args.destName)
		timerMalevolentStrike:Start(30, args.destName)
		local amount = args.amount or 1
		if args:IsPlayer() and amount >= 8 then
			specWarnMalevolent:Show(amount)
			specWarnMalevolent:Play("stackhigh")
		else
			if amount % 4 == 0 or amount >= 10 then		-- warn every 4th stack and every stack if 10 or more
				warnMalevolentStrike:Show(args.destName, amount)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 83908 then
		timerMalevolentStrike:Stop(args.destName)
	end
end
