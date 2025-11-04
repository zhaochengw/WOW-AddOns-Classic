local mod	= DBM:NewMod("d504", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241118070307")
mod:SetZone(1030)

mod:RegisterCombat("scenario", 1030)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 142884 119843",
	"SPELL_CAST_SUCCESS 120824",
	"SPELL_AURA_APPLIED 120817 127823 120929 120215",
	"SPELL_AURA_REMOVED 120817 127823",
	"UNIT_DIED"
)

--Todo, Gather Heroic data, actual Cds when the bosses last longer than 10 seconds.
--Jin Ironfist
local warnRelentless		= mod:NewTargetNoFilterAnnounce(120817, 3)--10 second target fixate
--Maragor
local warnFear				= mod:NewCastAnnounce(142884, 3)
--Abomination of Anger
local warnBreathofHate		= mod:NewSpellAnnounce(120929, 3)
local warnCloudofAnger		= mod:NewSpellAnnounce(120824, 3, 120743)--142432 is heroic ID in 5.3 only, need to figure out damage type event, SPELL_DAMAGE or SPELL_PERIODIC_DAMAGE and add move warning

--Jin Ironfist
--local specWarnRelentless	= mod:NewSpecialWarningRun(120817)--Maybe on heroic this actually deadly and you must run? if so, uncomment
local specWarnEnrage		= mod:NewSpecialWarningDispel(127823, "RemoveEnrage", nil, nil, 1, 2)
--Maragor
local specWarnFear			= mod:NewSpecialWarningInterrupt(142884, "HasInterrupt", nil, nil, 1, 2)
local specWarnGuardianStrike= mod:NewSpecialWarningRun(119843, "Melee", nil, nil, 4, 2)
--Abomination of Anger
local specWarnDarkforce		= mod:NewSpecialWarningRun(120215, nil, nil, nil, 4, 2)

--Jin Ironfist
local timerRelentless		= mod:NewTargetTimer(10, 120817, nil, nil, nil, 5)
local timerEnrage			= mod:NewBuffActiveTimer(10, 127823, nil, nil, nil, 5, nil, DBM_COMMON_L.ENRAGE_ICON)
--local timerRelentlessCD		= mod:NewCDTimer(10, 120817)
--Abomination of Anger
local timerBreathCD			= mod:NewCDTimer(18.2, 120929, nil, nil, nil, 3)
local timerCloudofAngerCD	= mod:NewCDTimer(17, 120824, nil, nil, nil, 3)--Limited sample size, may be shorter
local timerDarkforce		= mod:NewCastTimer(5, 120215, nil, nil, nil, 5)
local timerDarkforceCD		= mod:NewCDTimer(30.1, 120215, nil, nil, nil, 3)

function mod:SPELL_CAST_START(args)
	if args.spellId == 142884 then
		if self.Options.SpecWarn142884interrupt and self:CheckInterruptFilter(args.sourceGUID, nil, true) then
			specWarnFear:Show(args.sourceName)
			specWarnFear:Play("kickcast")
		else
			warnFear:Show()
		end
	elseif args.spellId == 119843 then
		specWarnGuardianStrike:Show()
		specWarnGuardianStrike:Play("justrun")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 120824 then
		warnCloudofAnger:Show()
		timerCloudofAngerCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 120817 then
		warnRelentless:Show(args.destName)
		timerRelentless:Start(args.destName)
	elseif args.spellId == 127823 then
		specWarnEnrage:Show(args.destName)
		specWarnEnrage:Play("enrage")
		timerEnrage:Start()
	elseif args.spellId == 120929 then
		warnBreathofHate:Show()
		timerBreathCD:Start()
	elseif args.spellId == 120215 then
		specWarnDarkforce:Show()
		specWarnDarkforce:Play("justrun")
		timerDarkforce:Start(self:IsHeroic() and 3.5 or 5)
		timerDarkforceCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 120817 then
		timerRelentless:Cancel(args.destName)
	elseif args.spellId == 127823 then
		timerEnrage:Cancel()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 61814 then--Jin Ironfist
		--No CDs yet, but will have some later, probably heroic
	elseif cid == 71492 then--Maragor
		--No CDs yet, but will have some later, probably heroic
	elseif cid == 61707 then--Abomination of Anger
		timerBreathCD:Cancel()
		timerCloudofAngerCD:Cancel()
		timerDarkforceCD:Start()
	end
end
