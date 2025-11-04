local mod	= DBM:NewMod("BoTrash", "DBM-Raids-Cata", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103125714")
mod:SetModelID(37193)
mod:SetZone(671)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 93362 93377",
	"SPELL_CAST_SUCCESS 93340",
	"SPELL_AURA_APPLIED 87903",
	"SPELL_AURA_REMOVED 87903"
)

local warnFrostWhirl		= mod:NewSpellAnnounce(93340, 4)--This is nasty frost whirl elementals do before ascendant Council.
local warnFlameStrike		= mod:NewTargetAnnounce(93362, 4)--This is Flame strike we need to not stand in unless we're dispeling frost dudes shield.
local warnRupture			= mod:NewTargetAnnounce(93377, 4)--This is twilight rupture the big guys do in hallway before halfus.

local specWarnVolcanicWrath	= mod:NewSpecialWarningInterrupt(87903, "HasInterrupt", nil, nil, 1, 2)
local specWarnRupture		= mod:NewSpecialWarningSpell(93377, nil, nil, nil, 2, 2)
local specWarnFlameStrike	= mod:NewSpecialWarningGTFO(93362, nil, nil, nil, 1, 8)
local yellFlamestrike		= mod:NewYell(93362)

local timerVolcanicWrath	= mod:NewBuffActiveTimer(9, 87903, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--Maybe need a Guid based targettimer since most pulls have 2 of these?

local flamestrikeRunning = false

function mod:SetFlamestrike(CouncilPull)
	if CouncilPull and flamestrikeRunning then
		self:UnregisterShortTermEvents()
		flamestrikeRunning = false
	end
	if not flamestrikeRunning and not CouncilPull then
		self:RegisterShortTermEvents(
			"SPELL_DAMAGE 93362",
			"SPELL_MISSED 93362"
		)
		flamestrikeRunning = true
	end
end

function mod:RuptureTarget(targetname)
	if not targetname then return end
	warnRupture:Show(targetname)
	--if targetname == UnitName("player") then
	--	yellFlamestrike:Yell()
	--end
end

function mod:FlameStrikeTarget(targetname)
	if not targetname then return end
	warnFlameStrike:Show(targetname)
	if targetname == UnitName("player") then
		yellFlamestrike:Yell()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 93362 then
		self:SetFlamestrike()
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "FlameStrikeTarget", 0.1, 4)
	elseif args.spellId == 93377 then
		specWarnRupture:Show()
		specWarnRupture:Play("watchstep")
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "RuptureTarget", 0.1, 4)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 93340 then
		warnFrostWhirl:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 87903 then
		specWarnVolcanicWrath:Show(args.sourceName)
		specWarnVolcanicWrath:Play("kickcast")
		timerVolcanicWrath:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 87903 then--I will have to log this trash to verify this spell event.
		timerVolcanicWrath:Cancel()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 93362 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnFlameStrike:Show(spellName)
		specWarnFlameStrike:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
