local mod = DBM:NewMod(559, "DBM-Party-BC", 14, 257)
local L = mod:GetLocalizedStrings()

mod:SetRevision("20210605024644")
mod:SetCreatureID(17975)
mod:SetEncounterID(1926)
mod:SetModelID(19045)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 34557"
)

local specWarnTranq		= mod:NewSpecialWarning("warnTranq", "-Healer", nil, nil, 1, 2)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 34557 then      --Summon Frayer Protector
		specWarnTranq:Show()
		specWarnTranq:Play("killmob")
	end
end
