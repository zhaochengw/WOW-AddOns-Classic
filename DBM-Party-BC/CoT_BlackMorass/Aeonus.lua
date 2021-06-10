local mod	= DBM:NewMod(554, "DBM-Party-BC", 12, 255)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20210605024644")
mod:SetCreatureID(17881)
mod:SetEncounterID(1919)
mod:SetModelID(20510)
mod:SetModelScale(0.2)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_EMOTE",
	"SPELL_CAST_SUCCESS 31422"
)

--TODO, actual CD timers
local warnFrenzy		= mod:NewAnnounce("warnEnrage", 3)
local warnTimeStop		= mod:NewSpellAnnounce(31422, 3)

local timerTimeStop		= mod:NewBuffActiveTimer(4, 31422, nil, nil, nil, 3)

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.AeonusFrenzy and self:IsInCombat() then		-- Frenzy
		warnFrenzy:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31422 then     --Time Stop
		warnTimeStop:Show()
		timerTimeStop:Start()
	end
end
