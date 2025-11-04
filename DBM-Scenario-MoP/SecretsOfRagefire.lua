local mod	= DBM:NewMod("d649", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241118070307")
mod:SetZone(1131)

mod:RegisterCombat("scenario", 1131)

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_START 142771",
	"SPELL_CAST_SUCCESS 142320 142306 142773",
	"SPELL_DAMAGE 142311 142768",
	"SPELL_MISSED 142311 142768",
	"UNIT_DIED"
)

--Dark Shaman Xorenth
local warnGlacialFreezeTotem		= mod:NewSpellAnnounce(142320, 2)
--Overseer Elaglo
local warnShatteringStomp			= mod:NewSpellAnnounce(142771, 3)--The cds on these abilities were HIGHLY variable
local warnShatteringCharge			= mod:NewTargetNoFilterAnnounce(142773, 3)--So timers probably not useful, I localized pull just in case though

--Dark Shaman Xorenth
local specWarnRuinedEarthMove		= mod:NewSpecialWarningDodge(142311, nil, nil, nil, 2, 2)
--Overseer Elaglo
local specWarnGTFO					= mod:NewSpecialWarningGTFO(142768, nil, nil, nil, 1, 8)

--Dark Shaman Xorenth
local timerGlacialFreezeTotemCD		= mod:NewCDTimer(25, 142320, nil, nil, nil, 1)--Only got cast twice in my log, so cd may be variable, need more data.
local timerRuinedEarth				= mod:NewBuffActiveTimer(15, 142306)
local timerRuinedEarthCD			= mod:NewCDTimer(19.5, 142306, nil, nil, nil, 3)--Timer started when last ended, but actual CD is 34.5ish

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.XorenthPull or msg:find(L.XorenthPull) then
		self:SendSync("XorenthPulled")
--	elseif msg == L.ElagloPull or msg:find(L.ElagloPull) then
--		self:SendSync("ElagloPulled")
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 142771 then
		warnShatteringStomp:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 142320 then
		warnGlacialFreezeTotem:Show()
		timerGlacialFreezeTotemCD:Start()
	elseif args.spellId == 142306 then
		specWarnRuinedEarthMove:Show()
		specWarnRuinedEarthMove:Play("watchstep")
		timerRuinedEarth:Start()
		timerRuinedEarthCD:Schedule(15)--Start CD when current one ends
	elseif args.spellId == 142773 then
		warnShatteringCharge:Show(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 142311 or spellId == 142768) and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 70683 then--Dark Shaman Xorenth
		timerGlacialFreezeTotemCD:Cancel()
		timerRuinedEarth:Cancel()
		timerRuinedEarthCD:Cancel()
--	elseif cid == 71030 then--Overseer Elaglo
	end
end

function mod:OnSync(msg)
	if msg == "XorenthPulled" then
		timerGlacialFreezeTotemCD:Start(10)
		timerRuinedEarthCD:Start()--Also 19.5
--	elseif msg == "ElagloPulled" then
	end
end
