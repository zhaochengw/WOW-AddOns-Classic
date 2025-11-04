local mod	= DBM:NewMod("d646", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241118070307")
mod:SetZone(1130)

mod:RegisterCombat("scenario", 1130)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 141423",
	"SPELL_CAST_SUCCESS 132980 142669",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--Hekima the Wise
local warnHekimasWisdom		= mod:NewCastAnnounce(141423, 4, 4)

--Farastu
local specWarnIceSpikes		= mod:NewSpecialWarningDodge(132980, nil, nil, nil, 2, 2)
local specWarnFrozenSolid	= mod:NewSpecialWarningTarget(141407, nil, nil, nil, 1, 2)
--Hekima the Wise
local specWarnHekimasWisdom	= mod:NewSpecialWarningInterrupt(141423, "HasInterrupt", nil, nil, 1, 2)--Not only cast by last boss but trash near him as well, interrupt important for both. Although only bosses counts for achievement.
local specWarnZandalarBanner= mod:NewSpecialWarningSwitch(142669, nil, nil, nil, 1, 2)

--Farastu
local timerIceSpikesCD		= mod:NewCDTimer(10, 132980, nil, nil, nil, 3)
local timerFrozenSolidCD	= mod:NewCDTimer(20, 141407, nil, nil, nil, 3)

function mod:SPELL_CAST_START(args)
	if args.spellId == 141423 then
		if self.Options.SpecWarn141423interrupt and self:CheckInterruptFilter(args.sourceGUID, nil, true) then
			specWarnHekimasWisdom:Show(args.sourceName)
			specWarnHekimasWisdom:Play("kickcast")
		else
			warnHekimasWisdom:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 132980 then
		specWarnIceSpikes:Show()
		specWarnIceSpikes:Play("watchstep")
		timerIceSpikesCD:Start()
	elseif args.spellId == 142669 then
		specWarnZandalarBanner:Show()
		specWarnZandalarBanner:Play("targetchange")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 70474 then--Farastu
		timerIceSpikesCD:Cancel()
		timerFrozenSolidCD:Cancel()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:141407") and target then--Does show in combat log, but emote gives targetname 2 seconds earlier.
		target = DBM:GetUnitFullName(target) or target
		specWarnFrozenSolid:Show(target)
		specWarnFrozenSolid:Play("targetchange")
		timerFrozenSolidCD:Start()
	end
end
