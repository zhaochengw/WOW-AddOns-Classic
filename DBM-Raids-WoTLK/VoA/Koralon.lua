local mod	= DBM:NewMod("Koralon", "DBM-Raids-WoTLK", 9)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103133102")
mod:SetCreatureID(35013)
mod:SetEncounterID(not mod:IsPostCata() and 776 or 1128)
mod:SetModelID(29524)
mod:SetZone(624)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 66665 66725",
	"SPELL_AURA_APPLIED 66684 66721",
	"SPELL_AURA_APPLIED_DOSE 66721"
)

local warnBreath			= mod:NewSpellAnnounce(66665, 3)
local warnMeteor			= mod:NewSpellAnnounce(66725, 3)
local WarnBurningFury		= mod:NewStackAnnounce(66721, 2)

local specWarnCinder		= mod:NewSpecialWarningMove(66684, nil, nil, nil, 1, 2)

local timerNextMeteor		= mod:NewCDTimer(16.9, 66725, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--16.9-47, typical classic timer
local timerNextBurningFury	= mod:NewNextTimer(20, 66721, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)
local timerBreath			= mod:NewBuffActiveTimer(4.5, 66665, nil, nil, nil, 5)
local timerBreathCD			= mod:NewCDTimer(35, 66665, nil, nil, nil, 2)--Seems to variate, but 35sec cooldown looks like a good testing number to start.

local timerKoralonEnrage	= mod:NewTimer(300, "KoralonEnrage", 26662)

function mod:OnCombatStart(delay)
	timerKoralonEnrage:Start(-delay)
	timerBreathCD:Start(12-delay)
	timerNextMeteor:Start(30.3-delay)
	timerNextBurningFury:Start()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 66665 then
		warnBreath:Show()
		timerBreath:Start()
		timerBreathCD:Start()
	elseif args.spellId == 66725 then
		warnMeteor:Show()
		timerNextMeteor:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsPlayer() and args.spellId == 66684 then
		specWarnCinder:Show()
		specWarnCinder:Play("runaway")
	elseif args.spellId == 66721 then
		WarnBurningFury:Show(args.destName, args.amount or 1)
		timerNextBurningFury:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
