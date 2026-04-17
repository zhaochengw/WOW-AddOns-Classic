local mod	= DBM:NewMod("Maiden", "DBM-Raids-BC", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20260315035408")
mod:DisableHardcodedOptions()
mod:SetCreatureID(16457)
mod:SetEncounterID(654, 2446)
mod:SetModelID(16198)
mod:SetZone(532)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 29511",
	"SPELL_AURA_APPLIED 29522",
	"SPELL_AURA_REMOVED 29522"
)

--TODO, rependance timer is consistent but there is an unknown trigger that happens once per kill where the timer resets?
--Maybe reaching a health threshold resets the CD?
--ability.id = 29511 and type = "begincast"
local warningHolyFire		= mod:NewTargetNoFilterAnnounce(29522, 2)

local specWarnRepentance	= mod:NewSpecialWarningMoveTo(29522, nil, nil, nil, 1, 15)

local timerRepentanceCD		= mod:NewVarTimer("v28-64.7", 29511, nil, nil, nil, 6)
local timerHolyFire			= mod:NewTargetTimer(12, 29522, nil, nil, nil, 5, nil, DBM_COMMON_L.MAGIC_ICON)

local holyGround = DBM:GetSpellName(29512)

function mod:OnCombatStart(delay)
	timerRepentanceCD:Start()
	DBM:AddMsg("Repentance has a 28-64.7 second variance. Timer has been updated to reflect this.")
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 29511 then
		specWarnRepentance:Show(holyGround)
		specWarnRepentance:Play("movetopool")
		timerRepentanceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 29522 then
		warningHolyFire:Show(args.destName)
		timerHolyFire:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 29522 then
		timerHolyFire:Stop(args.destName)
	end
end
