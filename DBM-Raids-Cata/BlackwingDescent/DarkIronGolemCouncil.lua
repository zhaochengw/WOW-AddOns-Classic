local mod	= DBM:NewMod(169, "DBM-Raids-Cata", 5, 73)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103125714")
mod:SetCreatureID(42180, 42178, 42179, 42166)
mod:SetEncounterID(1027)
mod:SetUsedIcons(1, 3, 6, 7, 8)
mod:SetZone(669)
--mod:SetModelSound("Sound\\Creature\\Nefarian\\VO_BD_Nefarian_OmnitronIntro01.ogg", "Sound\\Creature\\Council\\VO_BD_Council_Event01.ogg")
--Long: Hmm, the Omnotron Defense System. Centuries ago, these constructs were considered the dwarves greatest tactical achievements. With so many counters to each construct's attacks, I'll have to rectify these designs for them to provide me ANY entertainment!
--Short: Intruders detected. Primary defense matrix initiated.

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 79023 79582 79900 79835 79729 91849 79710",
	"SPELL_CAST_SUCCESS 80157 80053 79624 91857",
	"SPELL_AURA_APPLIED 78740 78726 79501 79888 80094 80161 79629 92048 92023 92053",
	"SPELL_AURA_REMOVED 79888 92053",
	"SPELL_INTERRUPT",
	"SPELL_DAMAGE 79710",
	"SPELL_MISSED 79710"
)

local Magmatron = DBM:EJ_GetSectionInfo(3207)
local Electron = DBM:EJ_GetSectionInfo(3201)
local Toxitron = DBM:EJ_GetSectionInfo(3208)
local Arcanotron = DBM:EJ_GetSectionInfo(3194)

--NOTE: Could add voice pack alert for shields ending with "shieldover"
--All
local warnActivated				= mod:NewTargetNoFilterAnnounce(78740, 3)

local specWarnActivated			= mod:NewSpecialWarningSwitch(78740, false, nil, nil, 1, 2)--Good for target switches, but healers probably don't want an extra special warning for it.
local specWarnGTFO				= mod:NewSpecialWarningGTFO(80161, nil, nil, nil, 1, 8)

local timerNextActivate			= mod:NewNextTimer(45, 78740, nil, nil, nil, 1)				--Activations are every 90 (60sec heroic) seconds but encounter staggers them in an alternating fassion so 45 (30 heroic) seconds between add switches
local timerNefAbilityCD			= mod:NewTimer(30, "timerNefAblity", 92048, nil, nil, 3, DBM_COMMON_L.HEROIC_ICON)--Huge variation on this, but shortest CD i've observed is 30.

local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnActivated", 78740, false, 5, {8})
--Magmatron
mod:AddTimerLine(Magmatron)
local warnIncineration			= mod:NewCountAnnounce(79023, 2, nil, "Healer")
local warnBarrierSoon			= mod:NewPreWarnAnnounce(79582, 10, 3, nil, "-Healer")
local warnBarrier				= mod:NewSpellAnnounce(79582, 4)
local warnAcquiringTarget		= mod:NewTargetNoFilterAnnounce(79501, 4)

local specWarnBarrier			= mod:NewSpecialWarningReflect(79582, "-Healer", nil, nil, 1, 2)
local specWarnAcquiringTarget	= mod:NewSpecialWarningMoveAway(79501, nil, nil, nil, 1, 2)
local yellAcquiringTarget		= mod:NewYell(79501)
local specWarnEncasingShadows	= mod:NewSpecialWarningTarget(92023, nil, nil, nil, 1, 2, 3)--Heroic Ability
local yellEncasingShadows		= mod:NewYell(92023, L.YellTargetLock)

local timerAcquiringTarget		= mod:NewNextTimer(40, 79501, nil, nil, nil, 3)
local timerBarrier				= mod:NewBuffActiveTimer(11.5, 79582, nil, false, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)	-- 10 + 1.5 cast time
local timerIncinerationCD   	= mod:NewNextTimer(26.5, 79023, nil, "Healer", nil, 5, nil, DBM_COMMON_L.HEALER_ICON)--Timer Series, 10, 27, 32 (on normal) from activate til shutdown.

mod:AddSetIconOption("AcquiringTargetIcon", 79501, true, 0, {6, 7})
--Electron
mod:AddTimerLine(Electron)
local warnLightningConductor	= mod:NewTargetAnnounce(79888, 4)
local warnUnstableShieldSoon	= mod:NewPreWarnAnnounce(79900, 10, 3, nil, "-Healer")
local warnUnstableShield		= mod:NewSpellAnnounce(79900, 4)
local warnShadowConductorCast	= mod:NewPreWarnAnnounce(92053, 5, 4)--Heroic Ability

local specWarnUnstableShield	= mod:NewSpecialWarningTarget(79900, "-Healer", nil, nil, 1, 2)
local specWarnConductor			= mod:NewSpecialWarningMoveAway(79888, nil, nil, nil, 1, 2)
local yellLightConductor		= mod:NewYell(79888)
local specWarnShadowConductor	= mod:NewSpecialWarningTarget(92053, nil, nil, nil, 1, 2, 3)--Heroic Ability
local yellShadowConductor		= mod:NewYell(92053, nil, nil, nil, "YELL")

local timerLightningConductor	= mod:NewTargetTimer(10, 79888, nil, nil, nil, 5)
local timerLightningConductorCD	= mod:NewNextTimer(25, 79888, nil, nil, nil, 3)
local timerUnstableShield		= mod:NewBuffActiveTimer(11.5, 79900, nil, false, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)	-- 10 + 1.5 cast time
local timerShadowConductor		= mod:NewTargetTimer(10, 92053, nil, nil, nil, 5)						--Heroic Ability
local timerShadowConductorCast	= mod:NewTimer(5, "timerShadowConductorCast", 92048, nil, nil, 2, DBM_COMMON_L.HEROIC_ICON, nil, nil, nil, nil, nil, nil, 92048)--Heroic Ability

mod:AddSetIconOption("ConductorIcon", 79888, true, 0, {1})
mod:AddSetIconOption("ShadowConductorIcon", 92053, true, 0, {3})
--Toxitron
mod:AddTimerLine(Toxitron)
local warnPoisonProtocol		= mod:NewSpellAnnounce(80053, 3)
local warnFixate				= mod:NewTargetNoFilterAnnounce(80094, 4, nil, false)--Spammy, off by default. Raid leader can turn it on if they wanna yell at these people.
local warnChemicalBomb			= mod:NewTargetNoFilterAnnounce(80157, 3)
local warnShellSoon				= mod:NewPreWarnAnnounce(79835, 10, 2, nil, false)
local warnShell					= mod:NewSpellAnnounce(79835, 3)

local specWarnShell				= mod:NewSpecialWarningTarget(79835, "-Healer", nil, nil, 1, 2)
local specWarnBombTarget		= mod:NewSpecialWarningRun(80094, nil, nil, nil, 4, 2)
local yellFixate				= mod:NewYell(80094, nil, false)
local specWarnPoisonProtocol	= mod:NewSpecialWarningSpell(80053, "-Healer", nil, nil, 2, 2)
local yellChemicalCloud			= mod:NewYell(80161)--May Return false tank yells
local specWarnGrip				= mod:NewSpecialWarningSpell(91849, nil, nil, nil, 2, 13, 3)--Heroic Ability

local timerChemicalBomb			= mod:NewCDTimer(30, 80157, nil, nil, nil, 3)							--Timer Series, 11, 30, 36 (on normal) from activate til shutdown.
local timerShell				= mod:NewBuffActiveTimer(11.5, 79835, nil, false, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)	-- 10 + 1.5 cast time
local timerPoisonProtocolCD		= mod:NewNextTimer(45, 80053, nil, nil, nil, 1)
--Arcanotron
mod:AddTimerLine(Arcanotron)
local warnGenerator				= mod:NewSpellAnnounce(79624, 3)
local warnConversionSoon		= mod:NewPreWarnAnnounce(79729, 10, 3, nil, "-Healer")
local warnConversion			= mod:NewSpellAnnounce(79729, 4)

local specWarnConversion		= mod:NewSpecialWarningTarget(79729, "-Healer", nil, nil, 1, 2)
local specWarnGenerator			= mod:NewSpecialWarningMove(79624, "Tank", nil, nil, 1, 2)
local specWarnOverchargedGen	= mod:NewSpecialWarningDodge(91857, nil, nil, nil, 2, 2, 3)--Heroic Ability
local specWarnAnnihilator		= mod:NewSpecialWarningInterrupt(79710, "HasInterrupt", nil, nil, 1, 2)--On by default for melee now that there is a smart filterin place on whether or not they should be warned.

local timerGeneratorCD			= mod:NewNextTimer(30, 79624, nil, nil, nil, 5)
local timerConversion			= mod:NewBuffActiveTimer(11.5, 79729, nil, false, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)		--10 + 1.5 cast time
local timerArcaneLockout		= mod:NewTimer(3, "timerArcaneLockout", 79710, "HasInterrupt", nil, 4, DBM_COMMON_L.INTERRUPT_ICON, nil, nil, nil, nil, nil, nil, 79710)	--How long arcanotron is locked out from casting another Arcane Annihilator
local timerArcaneBlowback		= mod:NewTimer(8, "timerArcaneBlowbackCast", 91879, nil, nil, 3, DBM_COMMON_L.HEROIC_ICON, nil, nil, nil, nil, nil, nil, 91879)		--what happens after the overcharged power generator explodes. 8 seconds after overcharge cast.

local cloudSpam = 0--Uses custom resets, don't use prototype
local encasing = false
mod.vb.pulled = false
mod.vb.incinerateCast = 0

function mod:ChemicalBombTarget(targetname)
	if not targetname then return end
	warnChemicalBomb:Show(targetname)
	if targetname == UnitName("player") then
		yellChemicalCloud:Yell()
	end
end

local function bossActivate(self, cid)
	if cid == 42178 then
		self.vb.incinerateCast = 0
		timerAcquiringTarget:Start(20)--These are same on heroic and normal
		timerIncinerationCD:Start(10)
		if self:IsDifficulty("heroic10", "heroic25") then
			warnBarrierSoon:Schedule(34)
		else
			warnBarrierSoon:Schedule(40)
		end
	elseif cid == 42179 then
		if self:IsDifficulty("heroic10", "heroic25") then
			timerLightningConductorCD:Start(15)--Probably also has a variation if it's like normal. Needs more logs to verify.
			warnUnstableShieldSoon:Schedule(30)
		else
			timerLightningConductorCD:Start(11)--11-15 variation confirmed for normal, only boss ability with an actual variation on timer. Strange.
			warnUnstableShieldSoon:Schedule(40)
		end
	elseif cid == 42180 then
		if self:IsDifficulty("heroic10", "heroic25") then
			timerChemicalBomb:Start(25)
			timerPoisonProtocolCD:Start(15)
			warnShellSoon:Schedule(30)
		else
			timerChemicalBomb:Start(11)
			timerPoisonProtocolCD:Start(21)
			warnShellSoon:Schedule(40)
		end
	elseif cid == 42166 then
		timerGeneratorCD:Start(15)--These appear same on heroic and non heroic but will leave like this for now to await 25 man heroic confirmation.
		if self:IsDifficulty("heroic10", "heroic25") then
			warnConversionSoon:Schedule(30)
		else
			warnConversionSoon:Schedule(40)
		end
	end
end

local function bossInactive(cid)
	if cid == 42178 then
		timerAcquiringTarget:Cancel()
		timerIncinerationCD:Cancel()
	elseif cid == 42179 then
		timerLightningConductorCD:Cancel()
	elseif cid == 42180 then
		timerChemicalBomb:Cancel()
		timerPoisonProtocolCD:Cancel()
	elseif cid == 42166 then
		timerGeneratorCD:Cancel()
	end
end

local function CheckEncasing() -- prevent two yells at a time
	if encasing then
		yellEncasingShadows:Yell()
	else
		yellAcquiringTarget:Yell()
	end
	encasing = false
end

function mod:OnCombatStart(delay)
	cloudSpam = 0
	encasing = false
	self.vb.incinerateCast = 0
	if self:IsDifficulty("heroic10", "heroic25") then
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	self.vb.pulled = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 79023 then
		self.vb.incinerateCast = self.vb.incinerateCast + 1
		warnIncineration:Show(self.vb.incinerateCast)
		if self.vb.incinerateCast == 1 then--Only cast twice on heroic, 3 times on normal.
			timerIncinerationCD:Start()--second cast is after 27 seconds on heroic and normal.
		elseif self.vb.incinerateCast == 2 and self:IsDifficulty("normal10", "normal25") then
			timerIncinerationCD:Start(32)--3rd cast on normal is 32 seconds. 10 27 32 series.
		end
	elseif args.spellId == 79582 then
		timerBarrier:Start()
		if self:GetUnitCreatureId("target") == 42178 then
			specWarnBarrier:Show(args.sourceName)
			specWarnBarrier:Play("stopattack")
		else
			warnBarrier:Show()
		end
	elseif args.spellId == 79900 then
		timerUnstableShield:Start()
		if self:GetUnitCreatureId("target") == 42179 then
			specWarnUnstableShield:Show(args.sourceName)
			specWarnUnstableShield:Play("stopattack")
		else
			warnUnstableShield:Show()
		end
	elseif args.spellId == 79835 then
		timerShell:Start()
		if self:GetUnitCreatureId("target") == 42180 then
			specWarnShell:Show(args.sourceName)
			specWarnShell:Play("stopattack")
		else
			warnShell:Show()
		end
	elseif args.spellId == 79729 then
		timerConversion:Start()
		if self:GetUnitCreatureId("target") == 42166 then
			specWarnConversion:Show(args.sourceName)
			specWarnConversion:Play("stopattack")
		else
			warnConversion:Show()
		end
	elseif args.spellId == 91849 then--Grip
		specWarnGrip:Show()
		specWarnGrip:Play("pullin")
		timerNefAbilityCD:Start()
		cloudSpam = GetTime()
	elseif args.spellId == 79710 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnAnnihilator:Show(args.sourceName)
			specWarnAnnihilator:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 80157 then
		timerChemicalBomb:Start()--Appears same on heroic
		local uId = self:GetUnitIdFromGUID(args.sourceGUID, true)
		if uId then
			self:BossUnitTargetScanner(uId, "ChemicalBombTarget", 0.3, true)--Not yet tested, but should be more accurate than the legacy scanner was years ago
		end
	elseif args.spellId == 80053 then
		warnPoisonProtocol:Show()
		if self:GetUnitCreatureId("target") ~= 42180 then--You're not targeting toxitron
			specWarnPoisonProtocol:Show()
			specWarnPoisonProtocol:Play("specialsoon")--Not exactly a voice that says "exploding adds that fixate you"
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			timerPoisonProtocolCD:Start(25)
		else
			timerPoisonProtocolCD:Start()
		end
	elseif args.spellId == 79624 then
		warnGenerator:Show()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerGeneratorCD:Start(20)
		else
			timerGeneratorCD:Start()
		end
	elseif args.spellId == 91857 then
		specWarnOverchargedGen:Show()
		specWarnOverchargedGen:Play("watchstep")
		timerArcaneBlowback:Start()
		timerNefAbilityCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 78740 then--Ignore any activates that fire too close to eachother thanks to 4.1 screwing it up.
		local cid = self:GetCIDFromGUID(args.destGUID)
		bossActivate(self, cid)
		if self.vb.pulled then -- prevent show warning when first pulled.
			if self.Options.SpecWarn78740switch then
				specWarnActivated:Show()
				specWarnActivated:Play("targetchange")
			else
				warnActivated:Show(args.destName)
			end
		end
		if not self.vb.pulled then
			self.vb.pulled = true
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			timerNextActivate:Start(30)
		else
			timerNextActivate:Start()
		end
		if self.Options.SetIconOnActivated then
			for i = 1, 4 do
				if UnitName("boss"..i) == args.destName then
					self:SetIcon("boss"..i, 8)
					break
				end
			end
		end
	elseif args.spellId == 78726 then
		local cid = self:GetCIDFromGUID(args.destGUID)
		bossInactive(cid)
	elseif args.spellId == 79501 then
		warnAcquiringTarget:Show(args.destName)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerAcquiringTarget:Start(27)
		else
			timerAcquiringTarget:Start()
		end
		if args:IsPlayer() then
			specWarnAcquiringTarget:Show()
			specWarnAcquiringTarget:Play("runout")
			self:Schedule(1, CheckEncasing)
		end
		if self.Options.AcquiringTargetIcon then
			self:SetIcon(args.destName, 7, 8)
		end
	elseif args.spellId == 79888 then
		if args:IsPlayer() then
			specWarnConductor:Show()
			specWarnConductor:Play("runout")
			yellLightConductor:Yell()
		else
			warnLightningConductor:Show(args.destName)
		end
		if self.Options.ConductorIcon then
			self:SetIcon(args.destName, 1)
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			timerLightningConductor:Start(15, args.destName)
			timerLightningConductorCD:Start(20)
		else
			timerLightningConductor:Start(args.destName)
			timerLightningConductorCD:Start()
		end
	elseif args.spellId == 80094 then
		if args:IsPlayer() then
			specWarnBombTarget:Show()
			specWarnBombTarget:Play("justrun")
			yellFixate:Yell()
		else
			warnFixate:Show(args.destName)
		end
	elseif args.spellId == 80161 and args:IsPlayer() and GetTime() - cloudSpam > 4 then
		specWarnGTFO:Show(args.spellName)
		specWarnGTFO:Play("watchfeet")
		cloudSpam = GetTime()
	elseif args.spellId == 79629 and args:IsDestTypeHostile() then--Check if Generator buff is gained by a hostile.
		local targetCID = self:GetUnitCreatureId("target")--Get CID of current target
		if args:GetDestCreatureID() == targetCID and args:GetDestCreatureID() ~= 42897 then--If target gaining buff is target then not an ooze (only hostiles left filtering oozes is golems)
			specWarnGenerator:Show()--Show special warning to move him out of it.
			specWarnGenerator:Play("moveboss")
		end
	elseif args.spellId == 92048 then--Shadow Infusion, debuff 5 seconds before shadow conductor.
		timerNefAbilityCD:Start()
		warnShadowConductorCast:Show()
		timerShadowConductorCast:Start()
	elseif args.spellId == 92023 then
		if args:IsPlayer() then
			encasing = true
		end
		if self.Options.AcquiringTargetIcon then
			self:SetIcon(args.destName, 6, 8)
		end
		specWarnEncasingShadows:Show(args.destName)
		specWarnEncasingShadows:Play("runaway")
		timerNefAbilityCD:Start()
	elseif args.spellId == 92053 then
		specWarnShadowConductor:Show(args.destName)
		specWarnShadowConductor:Play("gathershare")
		timerShadowConductor:Show(args.destName)
		timerLightningConductor:Cancel()
		if self.Options.ShadowConductorIcon then
			self:SetIcon(args.destName, 3)
		end
		if args:IsPlayer() then
			yellShadowConductor:Yell()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 79888 then
		if self.Options.ConductorIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 92053 then
		timerShadowConductor:Cancel(args.destName)
		if self.Options.ShadowConductorIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if (type(args.extraSpellId) == "number" and args.extraSpellId == 79710) and self:AntiSpam(2, 2) then
		if args.spellId == 2139 then															--Counterspell
			timerArcaneLockout:Start(7.5)
		elseif args.spellId == 19647 then													--Shield Bash (will be removed in 4.1), Spell Lock (Fel Hunter)
			timerArcaneLockout:Start(6.5)--Shield bash verified, spell lock assumed since it's same lockout duration.
		elseif args:IsSpellID(96231, 6552, 47528, 1766, 80964, 80965) then	--Rebuke, Pummel, Mind Freeze, Kick, Skull Bash (feral and bear)
			timerArcaneLockout:Start(5)--4 out of 6 verified, skull bash needs logs to review for certainty.
		elseif args:IsSpellID(34490, 15487) then												--Silencing Shot, Silence
			timerArcaneLockout:Start(3.5)--Drycoded, needs verification for both spells.
		elseif args.spellId == 57994 then														--Wind Shear
			timerArcaneLockout:Start(2.5)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, _, _, _, spellId)
	if spellId == 79710 then--An interrupt failed (or wasn't cast)
		timerArcaneLockout:Cancel()--Cancel bar just in case one was started by a late SPELL_INTERRUPT event that showed in combat log while cast went off anyways.
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
