local mod	= DBM:NewMod("d566", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal"

mod:SetRevision("20241118070307")
mod:SetZone(1000, 999)

mod:RegisterCombat("scenario", 1000, 999)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 114570",
	"SPELL_CAST_SUCCESS 127010"
)

local warnWarEnginesSights		= mod:NewTargetNoFilterAnnounce(114570, 4)

local specWarnStormTotem		= mod:NewSpecialWarningSwitch(127010, nil, nil, nil, 1, 2)
local specWarnWarEnginesSights	= mod:NewSpecialWarningYou(114570, nil, nil, nil, 1, 2)--Actually used by his trash, but in a speed run, you tend to pull it all together
local yellWarEnginesSights		= mod:NewYell(114570)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 114570 then
		if args:IsPlayer() then
			specWarnWarEnginesSights:Show()
			specWarnWarEnginesSights:Play("targetyou")
			yellWarEnginesSights:Yell()
		else
			warnWarEnginesSights:Show(args.destName)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 127010 then
		specWarnStormTotem:Show()
		specWarnStormTotem:Play("attacktotem")
	end
end
