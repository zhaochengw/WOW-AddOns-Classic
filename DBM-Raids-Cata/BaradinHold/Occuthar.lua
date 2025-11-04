local mod	= DBM:NewMod(140, "DBM-Raids-Cata", 6, 74)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25"

mod:SetRevision("20241103125714")
mod:SetCreatureID(52363)
mod:SetEncounterID(1250)
mod:SetZone(757)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 96920 96913",
	"SPELL_CAST_SUCCESS 96884",
	"SPELL_AURA_APPLIED 96913",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_PERIODIC_DAMAGE",
	"RANGE_DAMAGE",
	"SWING_DAMAGE"
)

local warnSearingShadows		= mod:NewCastAnnounce(96913, 3)
local warnEyes					= mod:NewSpellAnnounce(96920, 3)

local specWarnSearingShadows	= mod:NewSpecialWarningTaunt(96913, nil, nil, nil, 1, 2)
local specWarnFocusedFire		= mod:NewSpecialWarningGTFO(97212, nil, nil, nil, 1, 8)

local timerSearingShadows		= mod:NewCDTimer(24, 96913, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerEyes					= mod:NewCDTimer(57.5, 96920, nil, nil, nil, 1)
local timerFocusedFire			= mod:NewCDTimer(16, 96884, nil, nil, nil, 3) -- 24 16 16, repeating pattern. Can vary by a couple seconds, ie be 26 18 18, but the pattern is same regardless.

local berserkTimer				= mod:NewBerserkTimer(300)

mod.vb.focusedCast = 0

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerSearingShadows:Start(6-delay)--Need transcriptor to see what first one always is to be sure.
	timerEyes:Start(23-delay)--Need transcriptor to see what first one always is to be sure.
	timerFocusedFire:Start(-delay)--Need transcriptor to see what first one always is to be sure.
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 96920 then
		warnEyes:Show()
		timerEyes:Start()
		self.vb.focusedCast = 0
		timerFocusedFire:Start()--eyes resets the CD of focused. Blizz hotfix makes more sense now.
	elseif args.spellId == 96913 then
		warnSearingShadows:Show()
		timerSearingShadows:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 96884 then
		self.vb.focusedCast = self.vb.focusedCast + 1
		if self.vb.focusedCast < 3 then--Don't start it after 3rd cast since eyes will be cast next and reset the CD, we start a bar there instead.
			timerFocusedFire:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 96913 and not args:IsPlayer() and not DBM:UnitDebuff("player", 96884) then
		specWarnSearingShadows:Show(args.destName)
		specWarnSearingShadows:Play("tauntboss")
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName, _, _, overkill)
	if spellId == 97212 and destGUID == UnitGUID("player") and self:AntiSpam(3) then--Is this even right one? 96883, 101004 are ones that do a lot of damage?
		specWarnFocusedFire:Show(spellName)
		specWarnFocusedFire:Play("watchfeet")
	elseif (overkill or 0) > 0 then
		if self:GetCIDFromGUID(destGUID) == 52363 then--Hack cause occuthar doesn't die in combat log since 4.2. So we look for a killing blow that has overkill.
			DBM:EndCombat(self)
		end
	end
end
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE
mod.RANGE_DAMAGE = mod.SPELL_DAMAGE

function mod:SPELL_MISSED(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 97212 and destGUID == UnitGUID("player") and self:AntiSpam(3) then--Is this even right one? 96883, 101004 are ones that do a lot of damage?
		specWarnFocusedFire:Show(spellName)
		specWarnFocusedFire:Play("watchfeet")
	end
end

function mod:SWING_DAMAGE(_, _, _, _, destGUID, _, _, _, _, overkill)
	if (overkill or 0) > 0 then
		if self:GetCIDFromGUID(destGUID) == 52363 then--Hack cause occuthar doesn't die in combat log since 4.2. SO we look for a killing blow that has overkill.
			DBM:EndCombat(self)
		end
	end
end
