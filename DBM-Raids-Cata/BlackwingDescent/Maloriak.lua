local mod	= DBM:NewMod(173, "DBM-Raids-Cata", 5, 73)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103125714")
mod:SetCreatureID(41378)
mod:SetEncounterID(1025)
mod:SetUsedIcons(1, 2, 3, 4, 6, 7)
mod:SetZone(669)
--mod:SetModelSound("Sound\\Creature\\Nefarian\\VO_BD_Nefarian_MaloriakIntro01.ogg", "Sound\\Creature\\Maloriak\\VO_BD_Maloriak_Event05.ogg")
--Long: Maloriak, try not to lose to these mortals. Semicompetent help is SO hard to create.
--Short: Mix and stir, apply heat...

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 77569 77991 92754 77896 78194",
	"SPELL_CAST_SUCCESS 77679",
	"SPELL_AURA_APPLIED 77699 77760 77912 77786 77615 92930",
	"SPELL_AURA_REMOVED 77699 77760 77786",
	"SPELL_INTERRUPT",
	"RAID_BOSS_EMOTE",
	"UNIT_HEALTH boss1"
)

local warnPhase					= mod:NewAnnounce("WarnPhase", 2)
local warnReleaseAdds			= mod:NewSpellAnnounce(77569, 3)
local warnRemainingAdds			= mod:NewAddsLeftAnnounce(-2932, 2, 77569)
local warnFlashFreeze			= mod:NewTargetAnnounce(77699, 4)
local warnBitingChill			= mod:NewTargetAnnounce(77760, 3)
local warnRemedy				= mod:NewSpellAnnounce(77912, 3)
local warnArcaneStorm			= mod:NewSpellAnnounce(77896, 4)
local warnConsumingFlames		= mod:NewTargetAnnounce(77786, 3)
local warnScorchingBlast		= mod:NewSpellAnnounce(77679, 4)
local warnDebilitatingSlime		= mod:NewSpellAnnounce(77615, 2)
local warnEngulfingDarkness		= mod:NewSpellAnnounce(92754, 4, nil, "Tank|Healer")--Heroic Ability
local warnPhase2Soon			= mod:NewPrePhaseAnnounce(2, 2)
local warnPhase2				= mod:NewPhaseAnnounce(2, 3, nil, nil, nil, nil, nil, 2)

local specWarnBitingChill		= mod:NewSpecialWarningMoveAway(77760, nil, nil, nil, 1, 2)
local yellBitingChill			= mod:NewShortYell(77760)
local specWarnConsumingFlames	= mod:NewSpecialWarningYou(77786, nil, nil, nil, 1, 2)
local specWarnSludge			= mod:NewSpecialWarningGTFO(92930, nil, nil, nil, 1, 8)
local specWarnArcaneStorm		= mod:NewSpecialWarningInterrupt(77896, false, nil, nil, 1, 2)--Cast kickable, but many used to let it channel anyways (because it kept boss from doing other stuff and was easy to heal)
local specWarnMagmaJets			= mod:NewSpecialWarningDodge(78194, nil, nil, nil, 1, 2)
local specWarnEngulfingDarkness	= mod:NewSpecialWarningDefensive(92754, nil, nil, nil, 3, 2, 3)--Heroic Ability
local specWarnFlashFreeze		= mod:NewSpecialWarningTarget(77699, "Ranged", nil, nil, 1, 2)--On Heroic it has a lot more health.
local specWarnRemedy			= mod:NewSpecialWarningDispel(77912, "MagicDispeller", nil, nil, 1, 2)
local specWarnAdds				= mod:NewSpecialWarningSpell(77569, false, nil, nil, 1, 2)

local timerPhase				= mod:NewStageTimer(49, 89250)--Just some random cauldron icon not actual spellid
local timerFlashFreeze			= mod:NewCDTimer(14, 77699, nil, nil, nil, 3)--Varies on other abilities CDs
local timerAddsCD				= mod:NewCDTimer(15, 77569, nil, "-Healer", nil, 1)--Varies on other abilities CDs
local timerArcaneStormCD		= mod:NewCDTimer(14, 77896, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)--Varies on other abilities CDs
local timerConsumingFlames		= mod:NewTargetTimer(10, 77786, nil, "Healer", nil, 5)
local timerScorchingBlast		= mod:NewCDTimer(10, 77679, nil, nil, nil, 2)--Varies on other abilities CDs
local timerDebilitatingSlime	= mod:NewBuffActiveTimer(15, 77615, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerMagmaJetsCD			= mod:NewNextTimer(10, 78194, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerEngulfingDarknessCD	= mod:NewNextTimer(12, 92754, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)--Heroic Ability

local berserkTimer				= mod:NewBerserkTimer(420)

mod:AddSetIconOption("FlashFreezeIcon", 77699, true, 0, {1, 2, 3, 4, 5, 6}, true)
mod:AddSetIconOption("BitingChillIcon", 77760, false, 0, {1, 2, 3, 4, 5, 6}, true)
mod:AddSetIconOption("ConsumingFlamesIcon", 77786, false, 0, {7})
mod:AddBoolOption("SetTextures", true)--Just about ALL friendly spells cover dark sludge and make it very hard to see it.

mod.vb.adds = 18
mod.vb.AddsInterrupted = false
mod.vb.bitingChillIcon = 6--Descending (to reduce chance of running into flash freeze)
mod.vb.flashFreezeIcon = 1--Ascending (to reduce chance of running into biting chill)
mod.vb.prewarnedPhase2 = false
local bitingChillTargets = {}
local flashFreezeTargets = {}
local CVAR = false
local Red = DBM:EJ_GetSectionInfo(2935)
local Green = DBM:EJ_GetSectionInfo(2941)
local Blue = DBM:EJ_GetSectionInfo(2938)
local Dark = DBM:EJ_GetSectionInfo(2943)

local function showBitingChillWarning(self)
	warnBitingChill:Show(table.concat(bitingChillTargets, "<, >"))
	table.wipe(bitingChillTargets)
	self.vb.bitingChillIcon = 6
end

local function showFlashFreezeWarning(self)
	warnFlashFreeze:Show(table.concat(flashFreezeTargets, "<, >"))
	table.wipe(flashFreezeTargets)
	self.vb.flashFreezeIcon = 1
	timerFlashFreeze:Start()
end

local function InterruptCheck(self)
	if not self.vb.AddsInterrupted then
		self.vb.adds = self.vb.adds - 3
		warnRemainingAdds:Show(self.vb.adds)
	end
	self.vb.AddsInterrupted = false
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	if self:IsDifficulty("heroic10", "heroic25") then
		berserkTimer:Start(720-delay)--12 min berserk on heroic
	else
		berserkTimer:Start(-delay)--7 min on normal
	end
	self.vb.adds = 18
	self.vb.AddsInterrupted = false
	self.vb.bitingChillIcon = 6
	self.vb.flashFreezeIcon = 1
	self.vb.prewarnedPhase2 = false
	CVAR = false
	timerArcaneStormCD:Start(10-delay)--10-15 seconds from pull
	timerAddsCD:Start()--This may or may not happen depending on arcane storms duration and when it was cast.
	timerPhase:Start(18.5-delay)
	table.wipe(bitingChillTargets)
	table.wipe(flashFreezeTargets)
end

function mod:OnCombatEnd()
	if self.Options.SetTextures and not GetCVarBool("projectedTextures") and CVAR then
		SetCVar("projectedTextures", 1)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 77569 then
		if self.Options.SpecWarn77569spell then
			specWarnAdds:Show()--Special case that does not use standardized melee/ranged check do to fact this one usually has very specific assignments and may have a melee assigned that has to be warned regardless of target.
			specWarnAdds:Play("mobsoon")
		else
			warnReleaseAdds:Show()
		end
		timerAddsCD:Start()
		if self.vb.adds >= 3 then--only schedule it if there actually are adds left.
			self:Schedule(3, InterruptCheck, self)
		end
	elseif args.spellId == 77991 then
		self:SetStage(2)
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
		timerMagmaJetsCD:Start()
		timerFlashFreeze:Cancel()
		timerScorchingBlast:Cancel()
		timerAddsCD:Cancel()
		timerEngulfingDarknessCD:Cancel()
		if self.Options.SetTextures and not GetCVarBool("projectedTextures") and CVAR then
			SetCVar("projectedTextures", 1)
		end
	elseif args.spellId == 92754 then
		timerEngulfingDarknessCD:Start()
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--Change to boss1 if boss unitIds work in classic cata
			specWarnEngulfingDarkness:Show()
			specWarnEngulfingDarkness:Play("defensive")
		else
			warnEngulfingDarkness:Show()
		end
	elseif args.spellId == 77896 then
		timerArcaneStormCD:Start()
		if self.Options.SpecWarn77896interrupt then
			specWarnArcaneStorm:Show(args.sourceName)
			specWarnArcaneStorm:Play("kickcast")
		else
			warnArcaneStorm:Show()
		end
	elseif args.spellId == 78194 then
		if self:IsDifficulty("heroic10", "heroic25") then
			timerMagmaJetsCD:Start(5)
		else
			timerMagmaJetsCD:Start()
		end
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--Change to boss1 if boss unitIds work in classic cata
			specWarnMagmaJets:Show()
			specWarnMagmaJets:Play("shockwave")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 77679 then
		warnScorchingBlast:Show()
		timerScorchingBlast:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 77699 then
		flashFreezeTargets[#flashFreezeTargets + 1] = args.destName
		if self:IsDifficulty("heroic10", "heroic25") then
			specWarnFlashFreeze:CombinedShow(0.5, args.destName)
			specWarnFlashFreeze:ScheduleVoice(0.5, "targetchange")
		end
		if self.vb.flashFreezeIcon < 7 then
			if self.Options.FlashFreezeIcon then
				self:SetIcon(args.destName, self.vb.flashFreezeIcon)
			end
		end
		self.vb.flashFreezeIcon = self.vb.flashFreezeIcon + 1
		self:Unschedule(showFlashFreezeWarning)
		self:Schedule(0.3, showFlashFreezeWarning, self)
	elseif args.spellId == 77760 then
		bitingChillTargets[#bitingChillTargets + 1] = args.destName
		if self.vb.bitingChillIcon > 0 then
			if self.Options.BitingChillIcon then
				self:SetIcon(args.destName, self.vb.bitingChillIcon)
			end
		end
		self.vb.bitingChillIcon = self.vb.bitingChillIcon - 1
		if args:IsPlayer() then
			specWarnBitingChill:Show()
			specWarnBitingChill:Play("scatter")
			yellBitingChill:Yell()
		end
		self:Unschedule(showBitingChillWarning)
		self:Schedule(0.3, showBitingChillWarning, self)
	elseif args.spellId == 77912 and not args:IsDestTypePlayer() then
		if self.Options.SpecWarn77912dispel then
			specWarnRemedy:Show(args.destName)
			specWarnRemedy:Play("dispelboss")
		else
			warnRemedy:Show()
		end
	elseif args.spellId == 77786 then
		warnConsumingFlames:Show(args.destName)
		timerConsumingFlames:Start(args.destName)
		if self.Options.ConsumingFlamesIcon then
			self:SetIcon(args.destName, 7)
		end
		if args:IsPlayer() then
			specWarnConsumingFlames:Show()
			specWarnConsumingFlames:Play("targetyou")
		end
	elseif args.spellId == 77615 and self:AntiSpam(3, 1) then
		warnDebilitatingSlime:Show()
		timerDebilitatingSlime:Start()
	elseif args.spellId == 92930 and args:IsPlayer() and self:AntiSpam(3, 2) then
		specWarnSludge:Show(args.spellName)
		specWarnSludge:Play("watchfeet")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 77699 then
		if self.Options.FlashFreezeIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 77760 then
		if self.Options.BitingChillIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 77786 then
		if self.Options.ConsumingFlamesIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 77569) then
		self.vb.AddsInterrupted = true
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.YellRed or msg:find(L.YellRed) then
		warnPhase:Show(Red)
		timerAddsCD:Start()
		timerArcaneStormCD:Start(19)
		timerScorchingBlast:Start(22)
		timerPhase:Start()
		timerFlashFreeze:Cancel()
		timerEngulfingDarknessCD:Cancel()
		if self.Options.SetTextures and not GetCVarBool("projectedTextures") and CVAR then
			SetCVar("projectedTextures", 1)
		end
	elseif msg == L.YellBlue or msg:find(L.YellBlue) then
		warnPhase:Show(Blue)
		timerPhase:Start()
		timerAddsCD:Start()
		timerArcaneStormCD:Start(19)
		timerFlashFreeze:Start(22)
		timerScorchingBlast:Cancel()
		timerEngulfingDarknessCD:Cancel()
		if self.Options.SetTextures and not GetCVarBool("projectedTextures") and CVAR then
			SetCVar("projectedTextures", 1)
		end
	elseif msg == L.YellGreen or msg:find(L.YellGreen) then
		warnPhase:Show(Green)
		timerPhase:Start()
		timerAddsCD:Start()
		timerArcaneStormCD:Start(12)--First one is always shorter in green phase then other 2.
		timerFlashFreeze:Cancel()
		timerScorchingBlast:Cancel()
		timerEngulfingDarknessCD:Cancel()
	elseif msg == L.YellDark or msg:find(L.YellDark) then
		warnPhase:Show(Dark)
		timerEngulfingDarknessCD:Start(16.5)
		timerPhase:Start(100)
		timerArcaneStormCD:Cancel()
		timerAddsCD:Cancel()
		if self.Options.SetTextures and GetCVarBool("projectedTextures") then
			CVAR = true
			SetCVar("projectedTextures", 0)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 41378 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 35 and self.vb.prewarnedPhase2 then
			self.vb.prewarnedPhase2 = false
		elseif h > 24 and h < 29 and not self.vb.prewarnedPhase2 then
			self.vb.prewarnedPhase2 = true
			warnPhase2Soon:Show()
		end
	end
end
