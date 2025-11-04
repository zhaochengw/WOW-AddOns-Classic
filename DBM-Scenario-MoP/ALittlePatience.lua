local mod	= DBM:NewMod("d589", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal"

mod:SetRevision("20241118070307")
mod:SetZone(1104)

mod:RegisterCombat("scenario", 1104)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 134974",
	"SPELL_AURA_REMOVED 134974"
)

--Todo, Add some more resource gathering warnings/timers? Unfortunately none of those events got recorded by transcriptor. it appears they are all UNIT_AURA only :\
--Commander Scargash
local warnBloodRage		= mod:NewTargetNoFilterAnnounce(134974, 3)--15 second target fixate

--Commander Scargash
local specWarnBloodrage	= mod:NewSpecialWarningRun(134974, nil, nil, nil, 4, 2)

--Commander Scargash
local timerBloodRage	= mod:NewTargetTimer(15, 134974, nil, nil, 5)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 134974 then
		timerBloodRage:Start(args.destName)
		if args:IsPlayer() then
			specWarnBloodrage:Show()
			specWarnBloodrage:Play("justrun")
		else
			warnBloodRage:Show(args.destName)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 134974 then
		timerBloodRage:Cancel(args.destName)
	end
end
