local mod	= DBM:NewMod("d539", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal"

mod:SetRevision("20241118070307")
mod:SetZone(1051)

mod:RegisterCombat("scenario", 1051)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 124428",
	"SPELL_CAST_START 124359 125392"
)

--Li Te
local warnWaterShell	= mod:NewSpellAnnounce(124653, 2)
--Den Mother Moof
local warnBurrow		= mod:NewSpellAnnounce(124359, 2)

--Warbringer Qobi
local specWarnFireLine	= mod:NewSpecialWarningDodge(125392, nil, nil, nil, 2, 2)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 124428 then
		warnWaterShell:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 124359 then
		warnBurrow:Show()
	elseif args.spellId == 125392 then
		specWarnFireLine:Show()
		specWarnFireLine:Play("farfromline")
	end
end
