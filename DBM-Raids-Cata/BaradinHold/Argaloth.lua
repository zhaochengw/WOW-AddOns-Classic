local mod	= DBM:NewMod(139, "DBM-Raids-Cata", 6, 74)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25"

mod:SetRevision("20241103125714")
mod:SetCreatureID(47120)
mod:SetEncounterID(1033)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetZone(757)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 88972",
	"SPELL_AURA_APPLIED 88954 88972 88942",
	"SPELL_AURA_REMOVED 88954 88972",
	"SPELL_DAMAGE 89000",
	"SPELL_MISSED 89000",
	"UNIT_HEALTH boss1"
)

local warnConsuming			= mod:NewTargetNoFilterAnnounce(88954, 3, nil, "RemoveMagic|Healer")
local warnFirestormSoon		= mod:NewSoonAnnounce(88972, 3)

local specWarnMeteorSlash	= mod:NewSpecialWarningTaunt(88942, nil, nil, nil, 1, 2)
local specWarnFirestormCast	= mod:NewSpecialWarningDodge(88972, nil, nil, nil, 2, 2)
local specWarnFirestorm		= mod:NewSpecialWarningGTFO(89000, nil, nil, nil, 1, 8)

local timerConsuming		= mod:NewBuffFadesTimer(15, 88954, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.MAGIC_ICON)
local timerConsumingCD		= mod:NewCDTimer(24, 88954, nil, "Healer", 2, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerMeteorSlash		= mod:NewNextTimer(15, 88942, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFirestorm		= mod:NewBuffActiveTimer(15, 88972, nil, nil, nil, 6)
local timerFirestormCast	= mod:NewCastTimer(3, 88972, nil, nil, nil, 2)

local berserkTimer			= mod:NewBerserkTimer(300)

mod:AddSetIconOption("SetIconOnConsuming", 88954, false, 0, {1, 2, 3, 4, 5, 6, 7, 8})

local consumingTargets = {}
mod.vb.consumingIcon = 8
mod.vb.prewarnedFirestorm = false
mod.vb.consuming = 0

local function showConsumingWarning(self)
	warnConsuming:Show(table.concat(consumingTargets, "<, >"))
	table.wipe(consumingTargets)
	self.vb.consumingIcon = 8
	self.vb.prewarnedFirestorm = false
end

function mod:OnCombatStart(delay)
	table.wipe(consumingTargets)
	self.vb.consumingIcon = 8
	berserkTimer:Start(-delay)
	self.vb.consuming = 0
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 88972 then
		specWarnFirestormCast:Show()
		specWarnFirestormCast:Play("watchstep")
		timerMeteorSlash:Cancel()
		timerConsumingCD:Cancel()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 88954 then
		self.vb.consuming = self.vb.consuming + 1--Count raid members who got consuming
		timerConsuming:Start()
		timerConsumingCD:Start()
		consumingTargets[#consumingTargets + 1] = args.destName
		if self.Options.SetIconOnConsuming then
			self:SetIcon(args.destName, self.vb.consumingIcon)
		end
		self.vb.consumingIcon = self.vb.consumingIcon - 1
		self:Unschedule(showConsumingWarning)
		if (self:IsDifficulty("normal10") and #consumingTargets >= 3) or (self:IsDifficulty("normal25") and #consumingTargets >= 8) then
			showConsumingWarning(self)
		else
			self:Schedule(0.3, showConsumingWarning, self)
		end
	elseif args.spellId == 88972 then
		timerFirestorm:Start()
	elseif args.spellId == 88942 then--Debuff application not cast, special warning for tank taunts.
		if self:AntiSpam(3, 1) then
			timerMeteorSlash:Start()--Move this to a cast event dummy
			if not args:IsPlayer() then
				specWarnMeteorSlash:Show(args.destName)
				specWarnMeteorSlash:Play("tauntboss")
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 88954 then
		self.vb.consuming = self.vb.consuming - 1--Count raid members who had it dispelled
		if self.Options.SetIconOnConsuming then
			self:SetIcon(args.destName, 0)
		end
		if self.vb.consuming == 0 then--End Buff active timer when no raid members have it
			timerConsuming:Cancel()
		end
	elseif args.spellId == 88972 then
		timerMeteorSlash:Start(13)
		timerConsumingCD:Start(9)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 89000 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then -- Flames on ground from Firestorm
		specWarnFirestorm:Show(spellName)
		specWarnFirestorm:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 47120 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 75 or h > 45 and h < 55 then
			self.vb.prewarnedFirestorm = false
		elseif not self.vb.prewarnedFirestorm and (h > 69 and h < 72 or h > 35 and h < 38) then
			warnFirestormSoon:Show()
			self.vb.prewarnedFirestorm = true
		end
	end
end
