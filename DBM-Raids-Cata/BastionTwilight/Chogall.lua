local mod	= DBM:NewMod(167, "DBM-Raids-Cata", 4, 72)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241115112135")
mod:SetCreatureID(43324)
mod:SetEncounterID(1029)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetZone(671)
--mod:SetModelSound("Sound\\Creature\\Chogall\\VO_BT_Chogall_BotEvent15.ogg", "Sound\\Creature\\Chogall\\VO_BT_Chogall_BotEvent42.ogg")
--Long: Foolish mortals-(Usurper's children!) nothing you have done- (Spawn of a lesser god!) I am TRYING to speak here. (Words, words, words. The Master wants murder.) ALL falls to chaos. ALL will be destroyed. (Chaos, chaos!) Your work here today changes nothing. (Chaos, chaos, all things end) No mortal may see what you have and live. Your end has come.
--Short: (The Master sees, the Master sees!)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 81628 82524 82411 81713",
	"SPELL_CAST_SUCCESS 82414 82630 81556 81171 81685",
	"SPELL_AURA_APPLIED 91317 81194 81572",--82518
	"SPELL_AURA_REMOVED 91317",
	"SPELL_DAMAGE 81538",
	"SPELL_MISSED 81538",
	"UNIT_HEALTH boss1",
	"UNIT_AURA player"
)

--TODO, is specwarnFury even useful
local warnWorship					= mod:NewTargetAnnounce(91317, 3, nil, nil, nil, nil, nil, 2, true)--Phase 1 (spoken, no filter true)
local warnFury						= mod:NewSpellAnnounce(82524, 3, nil, "Tank|Healer")--Phase 1
local warnAdherent					= mod:NewSpellAnnounce(81628, 4)--Phase 1
local warnShadowOrders				= mod:NewSpellAnnounce(81556, 3, nil, "Dps")--Warning is disabled on normal mode, it has no use there
local warnFlameOrders				= mod:NewSpellAnnounce(81171, 3, nil, "Dps")--This one is also disabled on normal.
local warnFlamingDestruction		= mod:NewSpellAnnounce(81194, 4, nil, "Tank|Healer")
local warnEmpoweredShadows			= mod:NewSpellAnnounce(81572, 4, nil, "Healer")
local warnCorruptingCrash			= mod:NewTargetAnnounce(81685, 2)--Doesn't need to be off by defaut anymore since it's now a filtered warning by default
local warnPhase2					= mod:NewPhaseAnnounce(2)
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2)
local warnCreations					= mod:NewSpellAnnounce(82414, 3)--Phase 2

local specWarnSickness				= mod:NewSpecialWarningYou(82235, nil, nil, nil, 1, 2)--Ranged should already be spread out and not need a special warning every sickness.
local specWarnBlaze					= mod:NewSpecialWarningGTFO(81538, nil, nil, nil, 1, 8)
local specWarnEmpoweredShadows		= mod:NewSpecialWarningSpell(81572, "Healer", nil, nil, true)
local specWarnCorruptingCrash		= mod:NewSpecialWarningMoveAway(81685, nil, nil, nil, 1, 2)--Subject to accuracy flaws in rare cases but most of the time it's right.
local yellCrash						= mod:NewYell(81685)--^^
local specWarnDepravity				= mod:NewSpecialWarningInterrupt(81713, nil, nil, nil, 1, 2)--On by default cause these things don't get interrupted otherwise. but will only warn if it's target.
--local specwarnFury					= mod:NewSpecialWarningTarget(82524, "Tank", nil, nil, 1, 2)
local specwarnFlamingDestruction	= mod:NewSpecialWarningDefensive(81194, nil, nil, nil, 1, 2)

local timerWorshipCD				= mod:NewCDTimer(36, 91303, nil, nil, nil, 3, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerAdherent					= mod:NewCDTimer(92, 81628, nil, nil, nil, 1)
local timerFesterBlood				= mod:NewNextTimer(40, 82299, nil, nil, nil, 1)--40 seconds after an adherent is summoned
local timerFlamingDestruction		= mod:NewBuffActiveTimer(10, 81194, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerEmpoweredShadows			= mod:NewBuffActiveTimer(9, 81572, nil, "Healer", nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerFuryCD					= mod:NewCDTimer(47, 82524, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--47-48 unless a higher priority ability is channeling (such as summoning adds or MC)
local timerCreationsCD				= mod:NewNextTimer(30, 82414, nil, nil, nil, 1)
local timerSickness					= mod:NewBuffFadesTimer(5, 82235, nil, nil, nil, 5)
local timerFlamesOrders				= mod:NewNextTimer(25, 81171, nil, "Dps", nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)--Orders are when he summons elemental
local timerShadowsOrders			= mod:NewNextTimer(25, 81556, nil, "Dps", nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)--These are more for dps to switch to them to lower em so useless for normal mode
local timerFlamingDestructionCD		= mod:NewNextTimer(20, 81194, nil, "Tank|Healer", nil, 5)--Timer for when the special actually goes off (when he absorbs elemental)
local timerEmpoweredShadowsCD		= mod:NewNextTimer(20, 81572, nil, "Healer", nil, 5, nil, DBM_COMMON_L.HEALER_ICON)--^^
local timerDepravityCD				= mod:NewCDTimer(12, 81713, nil, "HasInterrupt", 2, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnWorship", 91317, true, 0, {1, 2, 3, 4})
mod:AddSetIconOption("SetIconOnCreature", 82411, false, 5, {1, 2, 3, 4, 5, 6, 7, 8})
mod:AddInfoFrameOption(-3165, true)

mod.vb.prewarned_Phase2 = false
mod.vb.firstFury = false
mod.vb.worshipIcon = 1
mod.vb.creatureIcon = 8
mod.vb.worshipCooldown = 20.5
mod.vb.shadowOrdersCD = 15
local worshipTargets = {}
local Bloodlevel = DBM:EJ_GetSectionInfo(3165)

local function showWorshipWarning(self)
	warnWorship:Show(table.concat(worshipTargets, "<, >"))
	warnWorship:Play("findmc")
	table.wipe(worshipTargets)
	self.vb.worshipIcon = 1
	timerWorshipCD:Start(self.vb.worshipCooldown)
end

function mod:CorruptingCrashTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnCorruptingCrash:Show()
		specWarnCorruptingCrash:Play("runout")
		yellCrash:Yell()
	else
		warnCorruptingCrash:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.prewarned_Phase2 = false
	self.vb.firstFury = false
	self.vb.worshipIcon = 1
	self.vb.worshipCooldown = 20.5
	self.vb.shadowOrdersCD = 15
	timerFlamesOrders:Start(5-delay)
	timerWorshipCD:Start(10-delay)
	table.wipe(worshipTargets)
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(Bloodlevel)
		DBM.InfoFrame:Show(5, "playerpower", 1, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 81628 then
		warnAdherent:Show()
		timerAdherent:Start()
		timerFesterBlood:Start()
	elseif args.spellId == 82524 then
		warnFury:Show()
		timerFuryCD:Start()
		if not self.vb.firstFury then--85% fury of chogal, it resets cd on worship and changes cd to 36
			self.vb.firstFury = true
			self.vb.worshipCooldown = 36
			self.vb.shadowOrdersCD = 25
			timerWorshipCD:Stop()
			timerWorshipCD:Start(10)--worship is 10 seconds after first fury, regardless of what timer was at before 85%
			timerShadowsOrders:Cancel()--Cancel shadows orders timer, flame is going to be next.
			timerFlamesOrders:Stop()
			timerFlamesOrders:Start(15)--Flames orders is 15 seconds after first fury, regardless whether or not shadow was last.
		end
	elseif args.spellId == 82411 then -- Creatures are channeling after their spawn.
		if self.Options.SetIconOnCreature then
			self:ScanForMobs(args.sourceGUID, 2, self.vb.creatureIcon, 1, nil, 10, "SetIconOnCreature")--44045
		end
		self.vb.creatureIcon = self.vb.creatureIcon - 1
	elseif args.spellId == 81713 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDepravity:Show(args.sourceName)
			specWarnDepravity:Play("kickcast")
		end
		if self:IsDifficulty("normal10", "heroic10") then
			timerDepravityCD:Start()--every 12 seconds on 10 man from their 1 adherent, can be solo interrupted.
		else
			timerDepravityCD:Start(6)--every 6 seconds on 25 man (unless interrupted by a mage then 7.5 cause of school lockout)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 82414 then
		self.vb.creatureIcon = 8
		warnCreations:Show()
		if self:IsDifficulty("heroic10", "heroic25") then -- other difficulty not sure, only comfirmed 25 man heroic
			timerCreationsCD:Start(40)
		else
			timerCreationsCD:Start()--30
		end
	elseif args.spellId == 82630 then
		self:SetStage(2)
		warnPhase2:Show()
		timerAdherent:Cancel()
		timerWorshipCD:Cancel()
		timerFesterBlood:Cancel()
		timerFlamesOrders:Cancel()
		timerShadowsOrders:Cancel()
	elseif args.spellId == 81556 then--Shadow's Orders
		if self:IsDifficulty("heroic10", "heroic25") then
			warnShadowOrders:Show()--No reason to do this warning on normal, nothing spawns so nothing you can do about it.
			timerEmpoweredShadowsCD:Start()--Time til he actually absorbs elemental and gains it's effects
			timerFlamesOrders:Start()--always 25 seconds after shadows orders, regardless of phase.
		else
			timerEmpoweredShadowsCD:Start(10.8)--Half the time on normal since you don't actually have to kill elementals plus the only thing worth showing on normal.
		end
	elseif args.spellId == 81171 then--Flame's Orders
		if self:IsDifficulty("heroic10", "heroic25") then
			warnFlameOrders:Show()--No reason to do this warning on normal, nothing spawns so nothing you can do about it.
			timerFlamingDestructionCD:Start()--Time til he actually absorbs elemental and gains it's effects
			timerShadowsOrders:Start(self.vb.shadowOrdersCD)--15 seconds after a flame order above 85%, 25 seconds after a flame orders below 85%
		else
			timerFlamingDestructionCD:Start(10.8)--Half the time on normal since you don't actually have to kill elementals plus the only thing worth showing on normal.
		end
	elseif args.spellId == 81685 then
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "CorruptingCrashTarget", 0.1, 5)--Scan only boss unit IDs?
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 91317 then
		worshipTargets[#worshipTargets + 1] = args.destName
		if self.Options.SetIconOnWorship then
			self:SetIcon(args.destName, self.vb.worshipIcon)
		end
		self.vb.worshipIcon = self.vb.worshipIcon + 1
		self:Unschedule(showWorshipWarning)
		if (self:IsDifficulty("normal25", "heroic25") and #worshipTargets >= 4) or (self:IsDifficulty("normal10", "heroic10") and #worshipTargets >= 2) then
			showWorshipWarning(self)
		else
			self:Schedule(0.3, showWorshipWarning, self)
		end
	elseif args.spellId == 81194 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then--Boss1 isn't certainty, could missing in classic still
			specwarnFlamingDestruction:Show()
			specwarnFlamingDestruction:Play("defensive")
		else
			warnFlamingDestruction:Show()
		end
		timerFlamingDestruction:Start()
	elseif args.spellId == 81572 then
		warnEmpoweredShadows:Show()
		specWarnEmpoweredShadows:Show()
		timerEmpoweredShadows:Start()
--	elseif args.spellId == 82518 then
--		specwarnFury:Show(args.destName)
--		specwarnFury:Play("tauntboss")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 91317 then
		if self.Options.SetIconOnWorship then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 81538 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnBlaze:Show(spellName)
		specWarnBlaze:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 43324 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 40 and self.vb.prewarned_Phase2 then
			self.vb.prewarned_Phase2 = false
		elseif not self.vb.prewarned_Phase2 and (h > 27 and h < 30) then
			warnPhase2Soon:Show()
			self.vb.prewarned_Phase2 = true
		end
	end
end

function mod:UNIT_AURA(uId)
	if DBM:UnitDebuff("player", 82235) and self:AntiSpam(7, 2) then
		specWarnSickness:Show()
		specWarnSickness:Play("range5")
		timerSickness:Start()
	end
end
