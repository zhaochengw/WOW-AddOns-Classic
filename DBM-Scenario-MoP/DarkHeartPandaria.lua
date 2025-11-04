local mod	= DBM:NewMod("d647", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241118070307")
mod:SetZone(1144)

mod:RegisterCombat("scenario", 1144)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 142139 141421 142840",
	"SPELL_CAST_SUCCESS 141418 141456",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

--Trash (and somewhat Urtharges)
local warnStoneRain				= mod:NewSpellAnnounce(142139, 3)--Hit debuff, interrupt or move out of it
local warnSummonFieryAnger		= mod:NewCastAnnounce(141488, 3, 2.5)
local warnDetonate				= mod:NewCastAnnounce(141456, 4, 5)--Can kill or run away from. It's actually more practical to ignore it and let it kill itself to speed up run
--Urtharges the Destroyer
local warnRuptureLine			= mod:NewTargetAnnounce(141418, 3)
local warnCallElemental			= mod:NewSpellAnnounce(141872, 4)
--Echo of Y'Shaarj
local warnMalevolentForce		= mod:NewCastAnnounce(142840, 4, 2)

--Trash (and somewhat Urtharges)
local specWarnStoneRain			= mod:NewSpecialWarningInterrupt(142139, "HasInterrupt", nil, nil, 1, 2)
local specWarnSpellShatter		= mod:NewSpecialWarningCast(141421, "SpellCaster", nil, 3, 1, 2)
local specWarnSummonFieryAnger	= mod:NewSpecialWarningInterrupt(141488, "HasInterrupt", nil, nil, 1, 2)
--Urtharges the Destroyer
local specWarnRuptureLine		= mod:NewSpecialWarningMoveAway(141418, nil, nil, nil, 1, 2)
--Echo of Y'Shaarj
local specWarnMalevolentForce	= mod:NewSpecialWarningInterrupt(142840, "HasInterrupt", nil, nil, 1, 2)--Not only cast by last boss but trash near him as well, interrupt important for both. Although only bosses counts for achievement.

--Trash
--local timerSpellShatter			= mod:NewCDTimer(2, 141421, nil, nil, nil, 2)--Refine and nameplate timer maybe?

function mod:SPELL_CAST_START(args)
	if args.spellId == 142139 and self:AntiSpam(3, 1) then
		if self.Options.SpecWarn142139interrupt and self:CheckInterruptFilter(args.sourceGUID, nil, true) then
			specWarnStoneRain:Show(args.sourceName)
			specWarnStoneRain:Play("kickcast")
		else
			warnStoneRain:Show()
		end
	elseif args.spellId == 141421 then
		specWarnSpellShatter:Show()
		specWarnSpellShatter:Play("stopcast")
	elseif args.spellId == 141421 and self:AntiSpam(3, 2) then
		if self.Options.SpecWarn141421interrupt and self:CheckInterruptFilter(args.sourceGUID, nil, true) then
			specWarnSummonFieryAnger:Show(args.sourceName)
			specWarnSummonFieryAnger:Play("kickcast")
		else
			warnSummonFieryAnger:Show()
		end
	elseif args.spellId == 142840 then
		if self.Options.SpecWarn142840interrupt and self:CheckInterruptFilter(args.sourceGUID, nil, true) then
			specWarnMalevolentForce:Show(args.sourceName)
			specWarnMalevolentForce:Play("kickcast")
		else
			warnMalevolentForce:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 141418 then
		if args:IsPlayer() then
			specWarnRuptureLine:Show()
			specWarnRuptureLine:Play("runout")
		else
			warnRuptureLine:Show(args.destName)
		end
	elseif args.spellId == 141456 and self:AntiSpam(2, 1) then
		warnDetonate:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 141872 and self:AntiSpam(3, 2) then--Call Elemental
		self:SendSync("CallElemental")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.summonElemental or msg:find(L.summonElemental)) and self:AntiSpam(3, 2) then
		self:SendSync("CallElemental")
	end
end

function mod:OnSync(msg)
	if msg == "CallElemental" then
		warnCallElemental:Show()
	end
end
