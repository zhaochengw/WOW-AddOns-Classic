local mod	= DBM:NewMod("BPCouncil", "DBM-Raids-WoTLK", 2)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25,heroic,heroic25"

mod:SetRevision("20241103133102")
mod:SetCreatureID(37970, 37972, 37973)
mod:SetEncounterID(not mod:IsPostCata() and 852 or 1095)
mod:DisableEEKillDetection()--IEEU fires for this boss.
mod:SetModelID(30858)
mod:SetUsedIcons(7, 8)
mod:SetBossHPInfoToHighest()
mod:SetZone(631)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 72037 72039 71718 72040",
	"SPELL_AURA_APPLIED 70952 70981 70982 72999 71807",
	"SPELL_AURA_APPLIED_DOSE 72999",
	"SPELL_SUMMON 71943",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--Known issue, using a weak aura key for 70952 in announce object would not know difference between soon and now, so use timer object if you're a dev
--TODO, initial timerKineticBombCD timer missing, needs fixing
local warnTargetSwitch			= mod:NewAnnounce("WarnTargetSwitch", 3, 70952, nil, nil, nil, 70952)
local warnTargetSwitchSoon		= mod:NewAnnounce("WarnTargetSwitchSoon", 2, 70952, nil, nil, nil, 70952)
local warnConjureFlames			= mod:NewCastAnnounce(71718, 2)
local warnEmpoweredFlamesCast	= mod:NewCastAnnounce(72040, 3)
local warnEmpoweredFlames		= mod:NewTargetNoFilterAnnounce(72040, 4)
local warnGliteringSparks		= mod:NewTargetAnnounce(71807, 2, nil, false)
local warnKineticBomb			= mod:NewCountAnnounce(72053, 3, nil, "Ranged")
local warnDarkNucleus			= mod:NewSpellAnnounce(71943, 1, nil, false)	-- instant cast
local warnShockVortex			= mod:NewTargetAnnounce(72037, 3)				-- 1,5sec cast

local specWarnVortex			= mod:NewSpecialWarningYou(72037, nil, nil, nil, 1, 2)
local yellVortex				= mod:NewYell(72037)
local specWarnVortexNear		= mod:NewSpecialWarningClose(72037, nil, nil, nil, 1, 2)
local specWarnEmpoweredShockV	= mod:NewSpecialWarningMoveAway(72039, nil, nil, nil, 1, 2)
local specWarnEmpoweredFlames	= mod:NewSpecialWarningRun(72040, nil, nil, nil, 4, 2)
local specWarnShadowPrison		= mod:NewSpecialWarningStack(72999, nil, 6, nil, nil, 1, 6)

local timerTargetSwitch			= mod:NewTimer(47, "TimerTargetSwitch", 70952, nil, nil, 5, DBM_COMMON_L.DAMAGE_ICON, nil, nil, nil, nil, nil, nil, 70952)	-- every 46-47seconds
local timerDarkNucleusCD		= mod:NewCDTimer(10, 71943, nil, false, nil, 5)	-- usually every 10 seconds but sometimes more
local timerConjureFlamesCD		= mod:NewCDTimer(20, 71718, nil, nil, nil, 3)				-- every 20-30 seconds but never more often than every 20sec
local timerGlitteringSparksCD	= mod:NewCDTimer(20, 71807, nil, nil, nil, 2)				-- This is pretty nasty on heroic
local timerShockVortex			= mod:NewCDTimer(16.5, 72037, nil, nil, nil, 3)			-- Seen a range from 16,8 - 21,6
local timerKineticBombCD		= mod:NewCDCountTimer(18, 72053, nil, "Ranged", nil, 1)				-- Might need tweaking
local timerShadowPrison			= mod:NewBuffFadesTimer(10, 72999, nil, nil, nil, 5)		-- Hard mode debuff

local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddSetIconOption("EmpoweredFlameIcon", 72040, true, 0, {7})
mod:AddSetIconOption("ActivePrinceIcon", nil, false, 5, {8}, nil, 70952)
mod:AddRangeFrameOption(13, 72037)

mod.vb.kineticCount = 0

local glitteringSparksTargets	= {}

local function warnGlitteringSparksTargets()
	warnGliteringSparks:Show(table.concat(glitteringSparksTargets, "<, >"))
	table.wipe(glitteringSparksTargets)
	timerGlitteringSparksCD:Start()
end

function mod:OnCombatStart(delay)
	self.vb.kineticCount = 0
	berserkTimer:Start(-delay)
	warnTargetSwitchSoon:Schedule(42-delay)
	timerTargetSwitch:Start(-delay)
	table.wipe(glitteringSparksTargets)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(13)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:ShockVortexTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnVortex:Show()
		specWarnVortex:Play("watchstep")
		yellVortex:Yell()
	elseif self:IsClassic() and self:CheckNearby(10, targetname) then
		specWarnVortexNear:Show(targetname)
		specWarnVortexNear:Play("watchstep")
	else
		warnShockVortex:Show(targetname)
	end
end

function mod:HideRange()
	DBM.RangeCheck:Hide()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 72037 then		-- Shock Vortex
		timerShockVortex:Start()
		self:BossTargetScanner(args.sourceGUID, "ShockVortexTarget", 0.05, 6)
	elseif args.spellId == 72039 then
		specWarnEmpoweredShockV:Show()
		specWarnEmpoweredShockV:Play("scatter")
		timerShockVortex:Start()
	elseif args.spellId == 71718 then	-- Conjure Flames
		warnConjureFlames:Show()
		timerConjureFlamesCD:Start()
	elseif args.spellId == 72040 then	-- Conjure Empowered Flames
		warnEmpoweredFlamesCast:Show()
		timerConjureFlamesCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 70952 then
		if self:IsInCombat() then
			warnTargetSwitch:Show(L.Valanar)
			warnTargetSwitchSoon:Schedule(42)
			timerTargetSwitch:Start()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(13)
			end
		end
		if self.Options.ActivePrinceIcon then
			self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "ActivePrinceIcon")
		end
	elseif args.spellId == 70981 then
		warnTargetSwitch:Show(L.Keleseth)
		warnTargetSwitchSoon:Schedule(42)
		timerTargetSwitch:Start()
		if self.Options.RangeFrame then
			self:ScheduleMethod(4.5, "HideRange")--delay hiding range frame for a few seconds after change incase valanaar got a last second vortex cast off
		end
		if self.Options.ActivePrinceIcon then
			self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "ActivePrinceIcon")
		end
	elseif args.spellId == 70982 and self:IsInCombat() then
		warnTargetSwitch:Show(L.Taldaram)
		warnTargetSwitchSoon:Schedule(42)
		timerTargetSwitch:Start()
		if self.Options.RangeFrame then
			self:ScheduleMethod(4.5, "HideRange")--delay hiding range frame for a few seconds after change incase valanaar got a last second vortex cast off
		end
		if self.Options.ActivePrinceIcon then
			self:ScanForMobs(args.destGUID, 2, 8, 1, nil, 12, "ActivePrinceIcon")
		end
	elseif args.spellId == 72999 and not self:IsTrivial() then	--Shadow Prison (hard mode)
		if args:IsPlayer() then
			timerShadowPrison:Start()
			local amount = args.amount or 1
			if (amount % 3 == 0) and amount >= 6 then	--Placeholder right now, might use a different value
				specWarnShadowPrison:Show(args.amount)
				specWarnShadowPrison:Play("stackhigh")
			end
		end
	elseif args.spellId == 71807 and args:IsDestTypePlayer() then	-- Glittering Sparks(Dot/slow, dangerous on heroic during valanaar)
		glitteringSparksTargets[#glitteringSparksTargets + 1] = args.destName
		self:Unschedule(warnGlitteringSparksTargets)
		self:Schedule(1, warnGlitteringSparksTargets)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_SUMMON(args)
	if args.spellId == 71943 then
		warnDarkNucleus:Show()
		timerDarkNucleusCD:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:match(L.EmpoweredFlames) and target then
		if self:IsTrivial() then return end
		target = DBM:GetUnitFullName(target) or target
		if target == UnitName("player") then
			specWarnEmpoweredFlames:Show()
			specWarnEmpoweredFlames:Play("justrun")
		else
			warnEmpoweredFlames:Show(target)
		end
		if target and self.Options.EmpoweredFlameIcon then
			self:SetIcon(target, 7, 10)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 72080 then--Verify spellIDs
		self:SendSync("Bomb")
	end
end

function mod:OnSync(msg, arg)
	if msg == "Bomb" and self:IsInCombat() then
		self.vb.kineticCount = self.vb.kineticCount + 1
		warnKineticBomb:Show(self.vb.kineticCount)
		if self:IsDifficulty("normal10", "heroic10") then
			timerKineticBombCD:Start(27, self.vb.kineticCount+1)
		else
			timerKineticBombCD:Start(nil, self.vb.kineticCount+1)
		end
	end
end
