local mod	= DBM:NewMod(158, "DBM-Raids-Cata", 4, 72)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241115112135")
mod:SetCreatureID(43686, 43687, 43688, 43689, 43735)
mod:SetEncounterID(1028)
mod:SetUsedIcons(3, 4, 5, 6, 7, 8)
mod:SetZone(671)
--mod:SetModelSound("Sound\\Creature\\Chogall\\VO_BT_Chogall_BotEvent14.ogg", "Sound\\Creature\\Terrastra\\VO_BT_Terrastra_Event02.ogg")
--Long: Brothers of Twilight! The Hammer calls to you! Fire, water, earth, air! Leave your mortal shell behind! Fire, water, earth, air! Embrace your new forms, for here and ever after... Burn and drown and crush and sufficate!...and use your gifts to destroy the unbelievers! Burn and drown and crush and sufficate!
--Short: We will handle them!

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Kill)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 82746 82752 82699 83675 83718 83565 83087 83070 83067 84913 92212",
	"SPELL_CAST_SUCCESS 82636 82665 82660",
	"SPELL_AURA_APPLIED 82772 82665 82660 83099 82777 82631 82762 84948 92307 92067 92075",
	"SPELL_AURA_REFRESH 82772 83099 82777 82631 82762 84948 92307 92067 92075",--burning blood/heart of ice must be excluded from here
	"SPELL_AURA_REMOVED 82665 82660 82772 83099 84948 92307 92067 92075 82631",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4",
	"UNIT_HEALTH boss1 boss2 boss3 boss4"
)

--General
local specWarnBossLow		= mod:NewSpecialWarning("specWarnBossLow")

mod:AddInfoFrameOption(nil, true)
--Feludius
mod:AddTimerLine(DBM:EJ_GetSectionInfo(3110))
local warnHeartIce			= mod:NewTargetAnnounce(82665, 3, nil, false)
local warnGlaciate			= mod:NewSpellAnnounce(82746, 3, nil, "Melee")
local warnWaterBomb			= mod:NewSpellAnnounce(82699, 3)
local warnFrozen			= mod:NewTargetNoFilterAnnounce(82772, 3, nil, "Healer")
local warnFrostBeacon		= mod:NewTargetNoFilterAnnounce(92307, 4)--Heroic Phase 2 ablity

local specWarnHeartIce		= mod:NewSpecialWarningYou(82665, false, nil, nil, 1, 2)
local specWarnGlaciate		= mod:NewSpecialWarningRun(82746, "Melee", nil, nil, 4, 2)
local specWarnWaterLogged	= mod:NewSpecialWarningYou(82762, nil, nil, nil, 1, 2)--beter voice than defensive?
local specWarnHydroLance	= mod:NewSpecialWarningInterrupt(82752, "HasInterrupt", nil, nil, 1, 2)
local specWarnFrostBeacon	= mod:NewSpecialWarningMoveAway(92307, nil, nil, nil, 3, 2)--Heroic
local yellFrostbeacon		= mod:NewYell(92307)
local yellScrewed			= mod:NewYell(92307, L.blizzHatesMe, true, "yellScrewed", "YELL")--Amusing but effective.

local timerHeartIce			= mod:NewTargetTimer(60, 82665, nil, false, nil, 5)
local timerHeartIceCD		= mod:NewCDTimer(22, 82665, nil, false, nil, 3)--22-24 seconds
local timerGlaciate			= mod:NewCDTimer(33, 82746, nil, "Melee", nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)--33-35 seconds
local timerWaterBomb		= mod:NewCDTimer(33, 82699, nil, nil, nil, 3)--33-35 seconds
local timerFrozen			= mod:NewBuffFadesTimer(10, 82772, nil, "Healer", nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerHydroLanceCD		= mod:NewCDTimer(12, 82752, nil, "HasInterrupt", 2, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--12 second cd but lowest cast priority
local timerFrostBeaconCD	= mod:NewNextTimer(20, 92307, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)--Heroic Phase 2 ablity

mod:AddSetIconOption("HeartIceIcon", 82665, true, 0, {6})
mod:AddSetIconOption("FrostBeaconIcon", 92307, true, 0, {3})
--Ignacious
mod:AddTimerLine(DBM:EJ_GetSectionInfo(3118))
local warnBurningBlood		= mod:NewTargetAnnounce(82660, 3, nil, false)
local warnFlameTorrent		= mod:NewSpellAnnounce(82777, 2, nil, "Tank|Healer")--Not too useful to announce but will leave for now. CD timer useless.
local warnFlameStrike		= mod:NewCastAnnounce(92212, 3) --Heroic Phase 2 ablity

local specWarnBurningBlood	= mod:NewSpecialWarningYou(82660, false, nil, nil, 1, 2)
local specWarnAegisFlame	= mod:NewSpecialWarningSwitch(82631, nil, nil, nil, 1, 2)
local specWarnRisingFlames	= mod:NewSpecialWarningInterrupt(82636, "HasInterrupt", nil, nil, 1, 2)

local timerBurningBlood		= mod:NewTargetTimer(60, 82660, nil, false, nil, 5)
local timerBurningBloodCD	= mod:NewCDTimer(22, 82660, nil, false, nil, 3)--22-33 seconds, even worth having a timer?
local timerAegisFlame		= mod:NewNextTimer(60, 82631, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerFlameStrikeCD	= mod:NewNextTimer(20, 92212, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)--Heroic Phase 2 ablity

mod:AddSetIconOption("BurningBloodIcon", 82660, true, 0, {7})
--Terrastra
mod:AddTimerLine(DBM:EJ_GetSectionInfo(3135))
local warnEruption			= mod:NewSpellAnnounce(83675, 2, nil, "Melee")
local warnHardenSkin		= mod:NewSpellAnnounce(83718, 3, nil, "Tank")
local warnQuakeSoon			= mod:NewPreWarnAnnounce(83565, 10, 3)
local warnQuake				= mod:NewSpellAnnounce(83565, 4)
local warnGravityCore		= mod:NewTargetNoFilterAnnounce(92075, 4)--Heroic Phase 1 ablity

local specWarnEruption		= mod:NewSpecialWarningDodge(83675, false, nil, nil, 2, 2)
local specWarnSearingWinds	= mod:NewSpecialWarning("SpecWarnSearingWinds")--No decent custom voice
local specWarnHardenedSkin	= mod:NewSpecialWarningInterrupt(83718, "HasInterrupt", nil, nil, 1, 2)
local specWarnGravityCore	= mod:NewSpecialWarningYou(92075, nil, nil, nil, 1, 2)--Heroic
local yellGravityCore		= mod:NewYell(92075)

local timerEruptionCD		= mod:NewNextTimer(15, 83675, nil, "Melee", nil, 3)
local timerHardenSkinCD		= mod:NewCDTimer(42, 83718, nil, "HasInterrupt", 2, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--This one is iffy, it isn't as consistent as other ability timers
local timerQuakeCD			= mod:NewNextTimer(33, 83565, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerQuakeCast		= mod:NewCastTimer(3, 83565, nil, nil, nil, 5)
local timerGravityCoreCD	= mod:NewNextTimer(20, 92075, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)--Heroic Phase 1 ablity

mod:AddSetIconOption("GravityCoreIcon", 92075, true, 0, {5})
--Arion
mod:AddTimerLine(DBM:EJ_GetSectionInfo(3128))
local warnLightningRod		= mod:NewTargetNoFilterAnnounce(83099, 3)
local warnDisperse			= mod:NewSpellAnnounce(83087, 3, nil, "Tank")
local warnLightningBlast	= mod:NewCastAnnounce(83070, 3, nil, nil, "Tank")
local warnThundershockSoon	= mod:NewPreWarnAnnounce(83067, 10, 3)
local warnThundershock		= mod:NewSpellAnnounce(83067, 4)
local warnStaticOverload	= mod:NewTargetNoFilterAnnounce(92067, 4)--Heroic Phase 1 ablity

local specWarnGrounded		= mod:NewSpecialWarning("SpecWarnGrounded")--No decent custom voice
local specWarnLightningBlast= mod:NewSpecialWarningInterrupt(83070, false, nil, nil, 1, 2)
local specWarnLightningRod	= mod:NewSpecialWarningMoveAway(83099, nil, nil, nil, 1, 2)
local yellLightningRod		= mod:NewYell(83099)
local specWarnStaticOverload= mod:NewSpecialWarningYou(92067, nil, nil, nil, 1, 2)--Heroic
local yellStaticOverload	= mod:NewYell(92067)

local timerLightningRod		= mod:NewBuffFadesTimer(15, 83099, nil, nil, nil, 5)
local timerDisperse			= mod:NewCDTimer(30, 83087, nil, nil, nil, 6)
local timerLightningBlast	= mod:NewCastTimer(4, 83070, nil, false, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)
local timerThundershockCD	= mod:NewNextTimer(33, 83067, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)
local timerThundershockCast	= mod:NewCastTimer(3, 83067, nil, nil, nil, 5)
local timerStaticOverloadCD	= mod:NewNextTimer(20, 92067, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)--Heroic Phase 1 ablity

mod:AddSetIconOption("LightningRodIcon", 83099, true, 0, {1, 2, 3})
mod:AddSetIconOption("StaticOverloadIcon", 92067, true, 0, {4})
--Elementium Monstrosity
mod:AddTimerLine(DBM:EJ_GetSectionInfo(3145))
local warnLavaSeed			= mod:NewSpellAnnounce(84913, 4)
local warnGravityCrush		= mod:NewTargetNoFilterAnnounce(84948, 3)

local timerTransition		= mod:NewTimer(16.7, "timerTransition", 84918, nil, nil, 6)
local timerLavaSeedCD		= mod:NewCDTimer(23, 84913, nil, nil, nil, 2)
local timerGravityCrush		= mod:NewBuffActiveTimer(10, 84948, nil, nil, nil, 5)
local timerGravityCrushCD	= mod:NewCDTimer(24, 84948, nil, nil, nil, 3)--24-28sec cd, decent varation

mod:AddSetIconOption("GravityCrushIcon", 84948, true, 0, {1, 2, 3})

mod.vb.lightningRodIcon = 1
mod.vb.gravityCrushIcon = 1
mod.vb.frozenCount = 0
local frozenTargets = {}
local lightningRodTargets = {}
local gravityCrushTargets = {}
local sentLowHP = {}
local warnedLowHP = {}
local isBeacon = false
local isRod = false
local infoFrameUpdated = false
local groundedName, searingName = DBM:GetSpellName(83581), DBM:GetSpellName(83500)

local shieldHealth = {
	["heroic25"] = 2000000,
	["heroic10"] = 700000,
	["normal25"] = 1500000,
	["normal10"] = 500000
}

local function showFrozenWarning()
	warnFrozen:Show(table.concat(frozenTargets, "<, >"))
	timerFrozen:Start()
	table.wipe(frozenTargets)
end

local function showLightningRodWarning(self)
	warnLightningRod:Show(table.concat(lightningRodTargets, "<, >"))
	timerLightningRod:Start()
	table.wipe(lightningRodTargets)
	self.vb.lightningRodIcon = 1
end

local function showGravityCrushWarning(self)
	warnGravityCrush:Show(table.concat(gravityCrushTargets, "<, >"))
	timerGravityCrush:Start()
	table.wipe(gravityCrushTargets)
	self.vb.gravityCrushIcon = 1
end

local function checkGrounded(self)
	if not DBM:UnitDebuff("player", groundedName) and not UnitIsDeadOrGhost("player") then
		specWarnGrounded:Show()
	end
	if self.Options.InfoFrame and not infoFrameUpdated then
		infoFrameUpdated = true
		DBM.InfoFrame:SetHeader(L.WrongDebuff:format(groundedName))
		DBM.InfoFrame:Show(5, "playergooddebuff", groundedName)
	end
end

local function checkSearingWinds(self)
	if not DBM:UnitDebuff("player", searingName) and not UnitIsDeadOrGhost("player") then
		specWarnSearingWinds:Show()
	end
	if self.Options.InfoFrame and not infoFrameUpdated then
		infoFrameUpdated = true
		DBM.InfoFrame:SetHeader(L.WrongDebuff:format(searingName))
		DBM.InfoFrame:Show(5, "playergooddebuff", searingName)
	end
end

function mod:OnCombatStart(delay)
	local botTrash = DBM:GetModByName("BoTrash")
	botTrash:SetFlamestrike(true)
	self:SetStage(1)
	self.vb.lightningRodIcon = 1
	self.vb.gravityCrushIcon = 1
	self.vb.frozenCount = 0
	table.wipe(frozenTargets)
	table.wipe(lightningRodTargets)
	table.wipe(gravityCrushTargets)
	table.wipe(sentLowHP)
	table.wipe(warnedLowHP)
	isBeacon = false
	isRod = false
	infoFrameUpdated = false
	timerGlaciate:Start(30-delay)
	timerWaterBomb:Start(15-delay)
	timerHeartIceCD:Start(18-delay)--could be just as flakey as it is in combat though.
	timerBurningBloodCD:Start(28-delay)--could be just as flakey as it is in combat though.
	timerAegisFlame:Start(31-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerGravityCoreCD:Start(25-delay)
		timerStaticOverloadCD:Start(20-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 82746 then
		timerGlaciate:Start()
		if self:GetUnitCreatureId("target") == 43687 then--Only warn if targeting/tanking this boss.
			specWarnGlaciate:Show()
			specWarnGlaciate:Play("justrun")
		else
			warnGlaciate:Show()
		end
	elseif args.spellId == 82752 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHydroLance:Show(args.sourceName)--Only warn for melee targeting him or exclicidly put him on focus, else warn regardless if he's your target/focus or not if you aren't a melee
			specWarnHydroLance:Play("kickcast")
		end
		timerHydroLanceCD:Show()
	elseif args.spellId == 82699 then
		warnWaterBomb:Show()
		timerWaterBomb:Start()
	elseif args.spellId == 83675 then
		if self.Options.SpecWarn83675dodge then
			specWarnEruption:Show()
			specWarnEruption:Play("watchstep")
		else
			warnEruption:Show()
		end
		timerEruptionCD:Start()
	elseif args.spellId == 83718 then
		warnHardenSkin:Show()
		timerHardenSkinCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnHardenedSkin:Show(args.sourceName)--Only warn for melee targeting him or exclicidly put him on focus, else warn regardless if he's your target/focus or not if you aren't a melee
			specWarnHardenedSkin:Play("kickcast")
		end
	elseif args.spellId == 83565 then
		infoFrameUpdated = false
		warnQuake:Show()
		timerQuakeCD:Cancel()
		timerQuakeCast:Start()
		timerThundershockCD:Start()
		self:Schedule(5, checkGrounded, self)
	elseif args.spellId == 83087 then
		warnDisperse:Show()
		timerDisperse:Start()
	elseif args.spellId == 83070 then
		timerLightningBlast:Start()
		if self.Options.SpecWarn83070interrupt and self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnLightningBlast:Show(args.sourceName)
			specWarnLightningBlast:Play("kickcast")
		else
			warnLightningBlast:Show()
		end
	elseif args.spellId == 83067 then
		infoFrameUpdated = false
		warnThundershock:Show()
		timerThundershockCD:Cancel()
		timerThundershockCast:Start()
		timerQuakeCD:Start()
		self:Schedule(5, checkSearingWinds, self)
	elseif args.spellId == 84913 then
		warnLavaSeed:Show()
		timerLavaSeedCD:Start()
	elseif args.spellId == 92212 then
		warnFlameStrike:Show()
		timerFlameStrikeCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 82636 then
		timerAegisFlame:Start()
	elseif args.spellId == 82665 then
		timerHeartIceCD:Start()
	elseif args.spellId == 82660 then
		timerBurningBloodCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 82772 then
		self.vb.frozenCount = self.vb.frozenCount + 1
		frozenTargets[#frozenTargets + 1] = args.destName
		self:Unschedule(showFrozenWarning)
		self:Schedule(0.3, showFrozenWarning)
	elseif args.spellId == 82665 then--Dont use REFRESH
		warnHeartIce:Show(args.destName)
		timerHeartIce:Start(args.destName)
		if args:IsPlayer() then
			specWarnHeartIce:Show()
			specWarnHeartIce:Play("targetyou")
		end
		if self.Options.HeartIceIcon then
			self:SetIcon(args.destName, 6)
		end
	elseif args.spellId == 82660 then--Dont use REFRESH
		warnBurningBlood:Show(args.destName)
		timerBurningBlood:Start(args.destName)
		if args:IsPlayer() then
			specWarnBurningBlood:Show()
			specWarnBurningBlood:Play("targetyou")
		end
		if self.Options.BurningBloodIcon then
			self:SetIcon(args.destName, 7)
		end
	elseif args.spellId == 83099 then
		lightningRodTargets[#lightningRodTargets + 1] = args.destName
		if args:IsPlayer() then
			isRod = true
			specWarnLightningRod:Show()
			specWarnLightningRod:Play("runout")
			if isBeacon then--You have lighting rod and frost beacon at same time.
				yellScrewed:Yell()
			else--You only have rod so do normal yell
				yellLightningRod:Yell()
			end
		end
		if self.Options.LightningRodIcon then
			self:SetIcon(args.destName, self.vb.lightningRodIcon)
		end
		self.vb.lightningRodIcon = self.vb.lightningRodIcon + 1
		self:Unschedule(showLightningRodWarning)
		if (self:IsDifficulty("normal25", "heroic25") and #lightningRodTargets >= 3) or (self:IsDifficulty("normal10", "heroic10") and #lightningRodTargets >= 1) then
			showLightningRodWarning(self)
		else
			self:Schedule(0.3, showLightningRodWarning, self)
		end
	elseif args.spellId == 82777 then
		if self:GetUnitCreatureId("target") == 43686 or self:GetBossTarget(43686) == DBM:GetUnitFullName("target") then--Warn if the boss casting it is your target, OR your target is the person its being cast on.
			warnFlameTorrent:Show()
		end
	elseif args.spellId == 82631 then--Aegis of Flame
		specWarnAegisFlame:Show()
		specWarnAegisFlame:Play("targetchange")
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(2, "enemyabsorb", nil, shieldHealth[(DBM:GetCurrentInstanceDifficulty())], args.spellId)
		end
	elseif args.spellId == 82762 and args:IsPlayer() then
		specWarnWaterLogged:Show()
		specWarnWaterLogged:Play("defensive")
	elseif args.spellId == 84948 then
		gravityCrushTargets[#gravityCrushTargets + 1] = args.destName
		timerGravityCrushCD:Start()
		if self.Options.GravityCrushIcon then
			self:SetIcon(args.destName, self.vb.gravityCrushIcon)
		end
		self.vb.gravityCrushIcon = self.vb.gravityCrushIcon + 1
		self:Unschedule(showGravityCrushWarning)
		if (self:IsDifficulty("normal25", "heroic25") and #gravityCrushTargets >= 3) or (self:IsDifficulty("normal10", "heroic10") and #gravityCrushTargets >= 1) then
			showGravityCrushWarning(self)
		else
			self:Schedule(0.3, showGravityCrushWarning, self)
		end
	elseif args.spellId == 92307 then
		if args:IsPlayer() then
			isBeacon = true
			specWarnFrostBeacon:Show()
			specWarnFrostBeacon:Play("runout")
			if isRod then--You have lighting rod and frost beacon at same time.
				yellScrewed:Yell()
			else--You only have beacon so do normal yell
				yellFrostbeacon:Yell()
			end
		else
			warnFrostBeacon:Show(args.destName)
		end
		if self.Options.FrostBeaconIcon then
			self:SetIcon(args.destName, 3)
		end
		if self:AntiSpam(18, 1) then -- sometimes Frost Beacon change targets, show only new Frost orbs.
			timerFrostBeaconCD:Start()
		end
	elseif args.spellId == 92067 then--All other spell IDs are jump spellids, do not add them in or we'll have to scan source target and filter them.
		timerStaticOverloadCD:Start()
		if self.Options.StaticOverloadIcon then
			self:SetIcon(args.destName, 4)
		end
		if args:IsPlayer() then
			specWarnStaticOverload:Show()
			specWarnStaticOverload:Play("targetyou")
			yellStaticOverload:Yell()
		else
			warnStaticOverload:Show(args.destName)
		end
	elseif args.spellId == 92075 then
		timerGravityCoreCD:Start()
		if self.Options.GravityCoreIcon then
			self:SetIcon(args.destName, 5)
		end
		if args:IsPlayer() then
			specWarnGravityCore:Show()
			specWarnGravityCore:Play("targetyou")
			yellGravityCore:Yell()
		else
			warnGravityCore:Show(args.destName)
		end
	end
end
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 82665 then
		timerHeartIce:Cancel(args.destName)
		if self.Options.HeartIceIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 82660 then
		timerBurningBlood:Cancel(args.destName)
		if self.Options.BurningBloodIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 82772 then
		self.vb.frozenCount = self.vb.frozenCount - 1
		if self.vb.frozenCount == 0 then
			timerFrozen:Cancel()
		end
	elseif args.spellId == 83099 then
		timerLightningRod:Cancel(args.destName)
		if args:IsPlayer() then
			isRod = false
		end
		if self.Options.LightningRodIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 84948 then
		timerGravityCrush:Cancel(args.destName)
		if self.Options.GravityCrushIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 92307 then
		if args:IsPlayer() then
			isBeacon = false
		end
		if self.Options.FrostBeacondIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 92067 then
		if self.Options.StaticOverloadIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 92075 then
		if self.Options.GravityCoreIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 82631 then	-- Shield Removed
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnRisingFlames:Show(args.sourceName)--Only warn for melee targeting him or exclicidly put him on focus, else warn regardless if he's your target/focus or not if you aren't a melee
			specWarnRisingFlames:Play("kickcast")
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if (msg == L.Quake or msg:find(L.Quake)) and self:GetStage(2) then
		timerQuakeCD:Update(23, 33)
		warnQuakeSoon:Show()
		checkSearingWinds(self)
		if self:IsDifficulty("heroic10", "heroic25") then
			self:Schedule(3.3, checkSearingWinds, self)
			self:Schedule(6.6, checkSearingWinds, self)
		end
	elseif (msg == L.Thundershock or msg:find(L.Thundershock)) and self:GetStage(2) then
		timerThundershockCD:Update(23, 33)
		warnThundershockSoon:Show()
		checkGrounded(self)
		if self:IsDifficulty("heroic10", "heroic25") then
			self:Schedule(3.3, checkGrounded, self)
			self:Schedule(6.6, checkGrounded, self)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
--	"<60.5> Feludius:Possible Target<nil>:boss1:Frost Xplosion (DND)::0:94739"
	if spellId == 94739 and self:AntiSpam(2, 2) then -- Frost Xplosion (Phase 2 starts)
		self:SendSync("Phase2")
--	"<105.3> Terrastra:Possible Target<Omegal>:boss3:Elemental Stasis::0:82285"
	elseif spellId == 82285 and self:AntiSpam(2, 2)  then -- Elemental Stasis (Phase 3 Transition)
		self:SendSync("PhaseTransition")
--	"<122.0> Elementium Monstrosity:Possible Target<nil>:boss1:Electric Instability::0:84526"
	elseif spellId == 84526 and self:AntiSpam(2, 2) then -- Electric Instability (Phase 3 Actually started)
		self:SendSync("Phase3")
	end
end

function mod:UNIT_HEALTH(uId)
	if (uId == "boss1" or uId == "boss2" or uId == "boss3" or uId == "boss4") and self:IsInCombat() then
		if UnitHealth(uId)/UnitHealthMax(uId) <= 0.30 then
			local cid = self:GetUnitCreatureId(uId)
			if (cid == 43686 or cid == 43687 or cid == 43688 or cid == 43689) and not sentLowHP[cid] then
				sentLowHP[cid] = true
				self:SendSync("lowhealth", UnitName(uId))
			end
		end
	end
end

function mod:OnSync(msg, boss)
	if not self:IsInCombat() then return end
	if msg == "lowhealth" and boss and not warnedLowHP[boss] then
		warnedLowHP[boss] = true
		specWarnBossLow:Show(boss)
	elseif msg == "Phase2" then
		self:SetStage(2)
		timerWaterBomb:Cancel()
		timerGlaciate:Cancel()
		timerAegisFlame:Cancel()
		timerBurningBloodCD:Cancel()
		timerHeartIceCD:Cancel()
		timerGravityCoreCD:Cancel()
		timerStaticOverloadCD:Cancel()
		timerHydroLanceCD:Cancel()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerFrostBeaconCD:Start(25)
			timerFlameStrikeCD:Start(28)
		end
		timerQuakeCD:Start()
		self:Schedule(3, checkSearingWinds, self)
	elseif msg == "PhaseTransition" then
		self:Unschedule(checkSearingWinds)
		self:Unschedule(checkGrounded)
		timerQuakeCD:Cancel()
		timerThundershockCD:Cancel()
		timerHardenSkinCD:Cancel()
		timerEruptionCD:Cancel()
		timerDisperse:Cancel()
		timerFlameStrikeCD:Cancel()
		timerTransition:Start()
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	elseif msg == "Phase3" then
		self:SetStage(3)
		timerFrostBeaconCD:Cancel()--Cancel here to avoid problems with orbs that spawn during the transition.
		timerLavaSeedCD:Start(18)
		timerGravityCrushCD:Start(28)
	end
end
