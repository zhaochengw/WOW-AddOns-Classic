local mod	= DBM:NewMod("d517", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241118070307")
mod:SetZone(1005)

mod:RegisterCombat("scenario", 1005)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 115013",
	"SPELL_CAST_SUCCESS 115013",
	"SPELL_AURA_APPLIED 122142",
	"CHAT_MSG_MONSTER_SAY",
	"UNIT_DIED"
)

--Borokhula the Destroyer
local warnSwampSmash			= mod:NewSpellAnnounce(115013, 3)--TODO, see if target scanning works and change to target warning and target special warning instead
local warnEarthShattering		= mod:NewSpellAnnounce(122142, 3)

--Borokhula the Destroyer
local timerSwampSmashCD			= mod:NewCDTimer(8, 115013, nil, nil, nil, 3)
local timerEarthShatteringCD	= mod:NewCDTimer(15.8, 122142, nil, nil, nil, 3)

function mod:SPELL_CAST_START(args)
	if args.spellId == 115013 then
		warnSwampSmash:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 115013 then
		timerSwampSmashCD:Start(6)--Only start timer if cast finishes. Boss can be stunned and it interrupts cast but doesn't put it on CD
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 122142 then
		warnEarthShattering:Show()
		timerEarthShatteringCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.BorokhulaPull or msg:find(L.BorokhulaPull) then
		self:SendSync("BorokhulaPulled")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 58739 then--Borokhula the Destroyer
		timerSwampSmashCD:Cancel()
		timerEarthShatteringCD:Cancel()
	end
end

function mod:OnSync(msg)
	if msg == "BorokhulaPulled" then
		timerSwampSmashCD:Start()
		timerEarthShatteringCD:Start()
	end
end
