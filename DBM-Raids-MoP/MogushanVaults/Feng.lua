local mod	= DBM:NewMod(689, "DBM-Raids-MoP", 5, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103134004")
mod:SetCreatureID(60009)--60781 Soul Fragment
mod:SetEncounterID(1390)
mod:SetUsedIcons(1, 2, 3, 4, 7)
mod:SetZone(1008)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 131788 116942 131790 131792 118302 116784 116711 116821 116417 116364",
	"SPELL_AURA_APPLIED_DOSE 131788 116942 131790 131792 116821",
	"SPELL_AURA_REMOVED 131788 116942 131790 131792 118302 116018 116711 116417 116364 116784",
	"SPELL_CAST_START 116018 116157 116295",
	"SPELL_CAST_SUCCESS 118783 115817 116417",
	"SPELL_DAMAGE 116793",
	"SPELL_MISSED 116793",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_SPELLCAST_STOP boss1",
	"UNIT_SPELLCAST_CHANNEL_STOP boss1"
)
--Phase order is controlled by players. it is only pre determined order in LFR and LFR only. (it may be fixed order in pandaria event too)
--Heroic a player can do ANY phase first. It even says this in encounter journal.
--on normal, it lets you choose nature or fire first but it will not allow arcane first.
--none the less, the player can still control it on normal, just not to degree of heroic. The EJ says it's random on normal but it's not.
--NOTE: many timers probably need updating but it's hard to do solo since there is no way to do only SOME damage to boss to see all stages
local warnPhase						= mod:NewAnnounce("WarnPhase", 1, "136116")
--Nature/Fist
local warnLightningLash				= mod:NewStackAnnounce(131788, 3, nil, "Tank")
local warnLightningFists			= mod:NewSpellAnnounce(116157, 3)
--Fire/Spear
local warnFlamingSpear				= mod:NewStackAnnounce(116942, 3, nil, "Tank")
local warnWildSpark					= mod:NewTargetCountAnnounce(116784, 4)
local yellWildSpark					= mod:NewYell(116784)
local warnWildfireInfusion			= mod:NewStackAnnounce(116821, 3, nil, "Healer")
--Arcane/Staff
local warnArcaneShock				= mod:NewStackAnnounce(131790, 3, nil, "Tank")
local warnArcaneResonance			= mod:NewTargetAnnounce(116417, 4)
--Shadow/Shield (Heroic Only)
local warnShadowBurn				= mod:NewStackAnnounce(131792, 3, nil, "Tank")
local warnChainsOfShadow			= mod:NewSpellAnnounce(118783, 2, nil, false)
--Tank Abilities
local warnReversalLightningFists	= mod:NewTargetNoFilterAnnounce(118302, 2)--this spell can interrupt Epicenter, so needs to warn.

--Nature/Fist
local specWarnLightningLash			= mod:NewSpecialWarningStack(131788, nil, 2, nil, nil, 1, 6)
local specWarnLightningLashOther	= mod:NewSpecialWarningTaunt(131788, nil, nil, nil, 1, 2)
local specWarnEpicenter				= mod:NewSpecialWarningCount(116018, nil, nil, nil, 2, 2)
--Fire/Spear
local specWarnFlamingSpear			= mod:NewSpecialWarningStack(116942, nil, 2, nil, nil, 1, 6)
local specWarnFlamingSpearOther		= mod:NewSpecialWarningTaunt(116942, nil, nil, nil, 1, 2)
local specWarnWildSpark				= mod:NewSpecialWarningMoveAway(116784, nil, nil, nil, 1, 2)
local specWarnWildfire				= mod:NewSpecialWarningGTFO(116793, nil, nil, nil, 1, 8)
local specWarnDrawFlame				= mod:NewSpecialWarningCount(116711, nil, nil, nil, 2, 2)
--Arcane/Staff
local specWarnArcaneShock			= mod:NewSpecialWarningStack(131790, nil, 2, nil, nil, 1, 6)
local specWarnArcaneShockOther		= mod:NewSpecialWarningTaunt(131790, nil, nil, nil, 1, 2)
local specWarnArcaneResonance		= mod:NewSpecialWarningMoveAway(116417, nil, nil, nil, 1, 2)
local yellArcaneResonance			= mod:NewYell(116417)
local specWarnArcaneVelocity		= mod:NewSpecialWarningCount(116364, nil, nil, nil, 2, 2)
--Shadow/Shield (Heroic Only)
local specWarnShadowBurn			= mod:NewSpecialWarningStack(131792, nil, 2, nil, nil, 1, 6)
local specWarnShadowBurnOther		= mod:NewSpecialWarningTaunt(131792, nil, nil, nil, 1, 2)
local specWarnSiphoningShield		= mod:NewSpecialWarningCount(117209, nil, nil, nil, 1, 2)
--Tank Abilities
local specWarnBarrierNow			= mod:NewSpecialWarning("specWarnBarrierNow", nil, nil, nil, 1, 12)--Because i'm so damn tired of tanks not having a clue how/when to use this in LFR
local specWarnNullBarrier			= mod:NewSpecialWarningSpell(115817, nil, nil, nil, 1, 2) -- Null Barrier is important all members, espcially Earth and Arcane Phase.

--Nature/Fist
local timerLightningLash			= mod:NewTargetTimer(20, 131788, nil, false, 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerLightningLashCD			= mod:NewCDTimer(7.3, 131788, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--7.3-20 second variation.
local timerLightningFistsCD			= mod:NewCDTimer(13.3, 116157, nil, nil, nil, 3, nil, DBM_COMMON_L.TANK_ICON)
local timerEpicenterCD				= mod:NewCDCountTimer(27.9, 116018, nil, nil, nil, 2)
local timerEpicenter				= mod:NewBuffActiveTimer(10, 116018, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)
--Fire/Spear
local timerFlamingSpear				= mod:NewTargetTimer(20, 116942, nil, false, 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFlamingSpearCD			= mod:NewCDTimer(8, 116942, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--8-11second variation, usually 10 though.
local timerWildSpark				= mod:NewTargetTimer(5, 116784, nil, false, 2, 5)
local timerDrawFlame				= mod:NewBuffActiveTimer(6, 116711, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON..DBM_COMMON_L.HEALER_ICON)
local timerDrawFlameCD				= mod:NewNextCountTimer(30, 116711, nil, nil, nil, 2)--30 seconds after last ended.
--Arcane/Staff
local timerArcaneShock				= mod:NewTargetTimer(20, 131790, nil, false, 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerArcaneShockCD			= mod:NewCDTimer(9, 131790, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--not comfirmed
local timerArcaneResonanceCD		= mod:NewCDTimer(15.5, 116417, nil, nil, nil, 3)
local timerArcaneVelocityCD			= mod:NewCDCountTimer(18, 116364, nil, nil, nil, 2)--18 seconds after last ended.
local timerArcaneVelocity			= mod:NewBuffActiveTimer(8, 116364, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)--typically the tank doesn't use barrier or fist on this one, holding for other abilities instead, this one is easily healed
--Shadow/Shield (Heroic Only)
local timerShadowBurn				= mod:NewTargetTimer(20, 131792, nil, false, 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerShadowBurnCD				= mod:NewCDTimer(9, 131792, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerChainsOfShadowCD			= mod:NewCDTimer(6, 118783, nil, false, nil, 3)--6-10sec variation noted
local timerSiphoningShieldCD		= mod:NewCDCountTimer(35, 117209, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)--35-38sec variation noted
--Tank Abilities
local timerReversalLightningFists	= mod:NewBuffFadesTimer(20, 118302, nil, nil, nil, 5)
local timerNullBarrier				= mod:NewBuffFadesTimer(6, 115817, nil, nil, nil, 5)
local timerNullBarrierCD			= mod:NewCDTimer(55, 115817, nil, nil, nil, 5)

mod:AddSetIconOption("SetIconOnWS", 116784, false, 0, {7})
mod:AddSetIconOption("SetIconOnAR", 116417, false, 0, {1, 2, 3, 4})--Not sure number of targets so incorrect icon usage count for now
mod:AddRangeFrameOption(8, nil, "Ranged")

mod.vb.arIcon = 1
mod.vb.wildfireCount = 0
mod.vb.sparkCount = 0
mod.vb.fragmentCount = 5
mod.vb.specialCount = 0
local arcaneResonanceTargets = {}
local nullBarrier = DBM:GetSpellName(115811)

local function warnWildfire(self)
	warnWildfireInfusion:Cancel()
	warnWildfireInfusion:Schedule(1, L.name, self.vb.wildfireCount)
end

local function warnArcaneResonanceTargets()
	warnArcaneResonance:Show(table.concat(arcaneResonanceTargets, "<, >"))
	table.wipe(arcaneResonanceTargets)
end

function mod:OnCombatStart(delay)
	self.vb.phase = 0--Only time this is force set manually instead of APi
	self.vb.arIcon = 1
	self.vb.wildfireCount = 0
	self.vb.sparkCount = 0
	self.vb.specialCount = 0
	table.wipe(arcaneResonanceTargets)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 131788 then
		warnLightningLash:Show(args.destName, 1)
		timerLightningLash:Start(args.destName)
		timerLightningLashCD:Start()
	elseif spellId == 116942 then
		warnFlamingSpear:Show(args.destName, 1)
		timerFlamingSpear:Start(args.destName)
		timerFlamingSpearCD:Start()
	elseif spellId == 131790 then
		warnArcaneShock:Show(args.destName, 1)
		timerArcaneShock:Start(args.destName)
		timerArcaneShockCD:Start()
	elseif spellId == 131792 then
		warnShadowBurn:Show(args.destName, 1)
		timerShadowBurn:Start(args.destName)
		timerShadowBurnCD:Start()
	elseif spellId == 118302 then
		warnReversalLightningFists:Show(args.destName)
		timerReversalLightningFists:Start()
	elseif spellId == 116784 then
		self.vb.sparkCount = self.vb.sparkCount + 1
		timerWildSpark:Start(args.destName)
		if self.Options.SetIconOnWS then
			self:SetIcon(args.destName, 7, 5)
		end
		if args:IsPlayer() then
			specWarnWildSpark:Show()
			specWarnWildSpark:Play("runout")
			yellWildSpark:Yell()
		else
			warnWildSpark:Show(self.vb.sparkCount, args.destName)
		end
	elseif spellId == 116711 then
		self.vb.sparkCount = 0
		self.vb.specialCount = self.vb.specialCount + 1
		timerDrawFlame:Start()
		specWarnDrawFlame:Show(self.vb.specialCount)
		specWarnDrawFlame:Play("specialsoon")
		if DBM:UnitBuff("player", nullBarrier) and self:IsDifficulty("lfr25") then
			specWarnBarrierNow:Show()
			specWarnBarrierNow:Play("useextraaction")
		end
	elseif spellId == 116821 then
		self.vb.wildfireCount = 1
		warnWildfire(self)
	elseif spellId == 116417 then
		arcaneResonanceTargets[#arcaneResonanceTargets + 1] = args.destName
		if self.Options.SetIconOnAR then
			self:SetIcon(args.destName, self.vb.arIcon)
		end
		self.vb.arIcon = self.vb.arIcon + 1
		self:Unschedule(warnArcaneResonanceTargets)
		self:Schedule(0.3, warnArcaneResonanceTargets)
		if args:IsPlayer() then
			specWarnArcaneResonance:Show()
			specWarnArcaneResonance:Play("runout")
			yellArcaneResonance:Yell()
		end
	elseif spellId == 116364 then
		self.vb.specialCount = self.vb.specialCount + 1
		specWarnArcaneVelocity:Show(self.vb.specialCount)
		specWarnArcaneVelocity:Play("runin")--A mechanic that does less damage closer to boss you are
		timerArcaneVelocity:Start()
		if DBM:UnitBuff("player", nullBarrier) and self:IsDifficulty("lfr25") then
			specWarnBarrierNow:Show()
			specWarnBarrierNow:Play("useextraaction")
		end
	end
end

-- split Flaming Spear (Arcane Resonance also uses SPELL_AURA_APPLIED_DOSE, buggy)
function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	local amount = args.amount or 1
	if spellId == 131788 then
		warnLightningLash:Show(args.destName, amount)
		timerLightningLash:Start(args.destName)
		timerLightningLashCD:Start()
		if args:IsPlayer() and amount >= 2 then
			specWarnLightningLash:Show(amount)
			specWarnLightningLash:Play("stackhigh")
		else
			if amount >= 2 and not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", args.spellName) then
				specWarnLightningLashOther:Show(args.destName)
				specWarnLightningLashOther:Play("tauntboss")
			end
		end
	elseif spellId == 116942 then
		warnFlamingSpear:Show(args.destName, amount)
		timerFlamingSpear:Start(args.destName)
		timerFlamingSpearCD:Start()
		if args:IsPlayer() and amount >= 2 then
			specWarnFlamingSpear:Show(amount)
			specWarnFlamingSpear:Play("stackhigh")
		else
			if amount >= 2 and not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", args.spellName) then
				specWarnFlamingSpearOther:Show(args.destName)
				specWarnFlamingSpearOther:Play("tauntboss")
			end
		end
	elseif spellId == 131790 then
		warnArcaneShock:Show(args.destName, amount)
		timerArcaneShock:Start(args.destName)
		timerArcaneShockCD:Start()
		if args:IsPlayer() and amount >= 2 then
			specWarnArcaneShock:Show(amount)
			specWarnArcaneShock:Play("stackhigh")
		else
			if amount >= 2 and not UnitIsDeadOrGhost("player") or not DBM:UnitDebuff("player", args.spellName) then
				specWarnArcaneShockOther:Show(args.destName)
				specWarnArcaneShockOther:Play("tauntboss")
			end
		end
	elseif spellId == 131792 then
		warnShadowBurn:Show(args.destName, amount)
		timerShadowBurn:Start(args.destName)
		timerShadowBurnCD:Start()
		if args:IsPlayer() and amount >= 2 then
			specWarnShadowBurn:Show(amount)
			specWarnShadowBurn:Play("stackhigh")
		else
			if amount >= 2 and not UnitIsDeadOrGhost("player") and not DBM:UnitDebuff("player", args.spellName) then
				specWarnShadowBurnOther:Show(args.destName)
				specWarnShadowBurnOther:Play("tauntboss")
			end
		end
	elseif spellId == 116821 then
		self.vb.wildfireCount = amount
		warnWildfire(self)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 131788 then
		timerLightningLash:Cancel(args.destName)
	elseif spellId == 116942 then
		timerFlamingSpear:Cancel(args.destName)
	elseif spellId == 131790 then
		timerArcaneShock:Cancel(args.destName)
	elseif spellId == 131792 then
		timerShadowBurn:Cancel(args.destName)
	elseif spellId == 118302 then
		timerReversalLightningFists:Cancel()
	elseif spellId == 116018 then
		timerEpicenter:Cancel()--Epicenter can be removed by Lightning Fists (tank can steal). So added remove stuff.
	elseif spellId == 116784 then
		timerWildSpark:Cancel(args.destName)
	elseif spellId == 116711 then
		timerDrawFlameCD:Start(nil, self.vb.specialCount + 1)
	elseif spellId == 116417 then
		if self.Options.SetIconOnAR then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 116364 then
		timerArcaneVelocity:Cancel()
		timerArcaneVelocityCD:Start(nil, self.vb.specialCount + 1)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 116018 then
		self.vb.specialCount = self.vb.specialCount + 1
		specWarnEpicenter:Show(self.vb.specialCount)
		specWarnEpicenter:Play("aesoon")
		timerEpicenter:Start()
		timerEpicenterCD:Start(nil, self.vb.specialCount + 1)
		if DBM:UnitBuff("player", nullBarrier) and self:IsDifficulty("lfr25") then
			specWarnBarrierNow:Schedule(2)
			specWarnBarrierNow:ScheduleVoice(2, "useextraaction")
		end
	elseif args:IsSpellID(116157, 116295) then
		warnLightningFists:Show()
		timerLightningFistsCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 118783 then
		warnChainsOfShadow:Show()
		timerChainsOfShadowCD:Start()
	elseif spellId == 115817 then
		specWarnNullBarrier:Show()
		specWarnNullBarrier:Play("findshield")
		timerNullBarrier:Start()
		if self:IsDifficulty("lfr25") then
			timerNullBarrierCD:Start(25)
		else
			timerNullBarrierCD:Start()
		end
	elseif spellId == 116417 then
		self.vb.arIcon = 1
		timerArcaneResonanceCD:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 116793 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnWildfire:Show(spellName)
		specWarnWildfire:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Nature or msg:find(L.Nature) then
		self:SendSync("Earth")
	elseif msg == L.Fire or msg:find(L.Fire) then
		self:SendSync("Flame")
	elseif msg == L.Arcane or msg:find(L.Arcane) then
		self:SendSync("Purple")
	elseif msg == L.Shadow or msg:find(L.Shadow) then
		self:SendSync("Dark")
	end
end

function mod:OnSync(msg)
	if msg == "Earth" then
		self:SetStage(0)
		warnPhase:Show(self.vb.phase)
		timerEpicenterCD:Start(3.3, 1)--Seems much shorter now
		timerLightningFistsCD:Start(5)
		timerLightningLashCD:Start(7)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif msg == "Flame" then
		self:SetStage(0)
		warnPhase:Show(self.vb.phase)
		timerFlamingSpearCD:Start(5.5)
		timerDrawFlameCD:Start(9.3, 1)--No variation, or not enough logs of fire phase. (was 35 prior to 10.2.7, so remember this if they make classic MoP)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif msg == "Purple" then
		self:SetStage(0)
		warnPhase:Show(self.vb.phase)
		timerArcaneShockCD:Start(7)
		-- 10/13 01:11:24.437  YELL: Oh sage of the ages! Instill to me your arcane wisdom!
		-- 10/13 01:11:36.671  SPELL_CAST_SUCCESS,0xF150EA690000478E,"",0x10a48,0x0,0x0000000000000000,nil,0x80000000,0x80000000,116417,"",0x40
		timerArcaneResonanceCD:Start(12)
		timerArcaneVelocityCD:Start(8.8, 1)--It's either this, or this +10. Not yet sure what causes the +10 (14.5 old timer)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)
		end
	elseif msg == "Dark" then
		self:SetStage(0)
		warnPhase:Show(self.vb.phase)
		timerSiphoningShieldCD:Start(4, 1)--either this, or this +5. Not yet sure what causes the +5
		timerChainsOfShadowCD:Start(6)
		timerShadowBurnCD:Start(9)--9-11 variation
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 117203 then--Siphoning Shield
		self.vb.specialCount = self.vb.specialCount + 1
		specWarnSiphoningShield:Show(self.vb.specialCount)
		specWarnSiphoningShield:Play("targetchange")
		timerSiphoningShieldCD:Start(nil, self.vb.specialCount + 1)
	elseif spellId == 121631 and self:AntiSpam(2, 2) then--Draw Essence.
		--Best place to cancel timers, vs duplicating cancel code in all 4 yells above.
		self.vb.specialCount = 0
		timerFlamingSpearCD:Cancel()
		timerDrawFlameCD:Cancel()
		timerArcaneShockCD:Cancel()
		timerArcaneResonanceCD:Cancel()
		timerArcaneVelocityCD:Cancel()
		timerLightningLashCD:Cancel()
		timerLightningFistsCD:Cancel()
		timerEpicenterCD:Cancel()
		timerShadowBurnCD:Cancel()
		timerSiphoningShieldCD:Cancel()
		timerChainsOfShadowCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_STOP(uId, _, spellId)
	if spellId == 116018 then
		timerEpicenter:Cancel()
	end
end
mod.UNIT_SPELLCAST_CHANNEL_STOP = mod.UNIT_SPELLCAST_STOP
