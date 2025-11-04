local mod	= DBM:NewMod(726, "DBM-Raids-MoP", 5, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103134004")
mod:SetCreatureID(60410)--Energy Charge (60913), Emphyreal Focus (60776), Cosmic Spark (62618), Celestial Protector (60793)
mod:SetEncounterID(1500)
mod:DisableESCombatDetection()--TODO, see if 10.2.7 fixes this
mod:SetUsedIcons(8, 7, 6, 5, 4, 3)
mod:SetZone(1008)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 116598 132265",
	"SPELL_CAST_START 117960 117954 117945 129711 117949 119358",
	"SPELL_AURA_APPLIED 124967 116994 117878 119389 118310 132226 132222 119387",
	"SPELL_AURA_APPLIED_DOSE 117878",
	"SPELL_AURA_REMOVED 116994 132226 132222"
)

local warnPhase						= mod:NewPhaseChangeAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnBreath					= mod:NewSpellAnnounce(117960, 3)
local warnArcingEnergy				= mod:NewSpellAnnounce(117945, 2)--Cast randomly at 2 players, it is avoidable.
local warnClosedCircuit				= mod:NewTargetNoFilterAnnounce(117949, 3, nil, "RemoveMagic")--what happens if you fail to avoid the above
local warnStunned					= mod:NewTargetNoFilterAnnounce(132222, 3, nil, "Healer")--Heroic / 132222 is stun debuff, 132226 is 2 min debuff.
local warnDrawPower					= mod:NewCountAnnounce(117960, 3)

local specWarnOvercharged			= mod:NewSpecialWarningStack(117878, nil, 6, nil, nil, 1, 6)
local specWarnTotalAnnihilation		= mod:NewSpecialWarningSpell(129711, nil, nil, nil, 2, 2)
local specWarnProtector				= mod:NewSpecialWarningSwitchCount(117954, "-Healer", nil, nil, 1, 2)
local specWarnDrawPower				= mod:NewSpecialWarningCount(119387, nil, nil, nil, 1, 2)
local specWarnDespawnFloor			= mod:NewSpecialWarning("specWarnDespawnFloor", nil, nil, nil, 3, 7)
local specWarnRadiatingEnergies		= mod:NewSpecialWarningSpell(118310, nil, nil, nil, 2, 2)

local timerBreathCD					= mod:NewCDTimer(18, 117960, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerProtectorCD				= mod:NewCDCountTimer(41, 117954, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerArcingEnergyCD			= mod:NewCDTimer(11.5, 117945, nil, nil, nil, 3)
local timerTotalAnnihilation		= mod:NewCastTimer(4, 129711, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerDestabilized				= mod:NewBuffFadesTimer(120, 132226, nil, nil, nil, 5)
local timerFocusPower				= mod:NewCastTimer(16, 119358, nil, nil, nil, 6, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerDespawnFloor				= mod:NewTimer(6.5, "timerDespawnFloor", 116994, nil, nil, 3, DBM_COMMON_L.DEADLY_ICON)--6.5-7.5 variation. 6.5 is safed to use so you don't fall and die.

local berserkTimer					= mod:NewBerserkTimer(570)

mod:AddSetIconOption("SetIconOnDestabilized", 132226, false, 0)--ALso don't know how many icons are used
mod:AddSetIconOption("SetIconOnCreature", -6193, false, 5)--TODO, how many adds are spawned, so we can put icons here

mod.vb.phase2Started = false
mod.vb.protectorCount = 0
mod.vb.powerCount = 0
mod.vb.stunIcon = 1
mod.vb.focusActivated = 0
local closedCircuitTargets = {}
local stunTargets = {}

local function warnClosedCircuitTargets()
	warnClosedCircuit:Show(table.concat(closedCircuitTargets, "<, >"))
	table.wipe(closedCircuitTargets)
end

local function warnStunnedTargets()
	warnStunned:Show(table.concat(stunTargets, "<, >"))
	table.wipe(stunTargets)
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	self.vb.protectorCount = 0
	self.vb.stunIcon = 1
	self.vb.focusActivated = 0
	self.vb.powerCount = 0
	table.wipe(closedCircuitTargets)
	table.wipe(stunTargets)
--	timerBreathCD:Start(3.4-delay)--Will use instant on pull if tank range pulls it (which is most of time so disabling timer)
	timerProtectorCD:Start(10-delay, 1)
	berserkTimer:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 117960 then
		warnBreath:Show()
		timerBreathCD:Start()
	elseif spellId == 117954 then
		self.vb.protectorCount = self.vb.protectorCount + 1
		specWarnProtector:Show(self.vb.protectorCount)
		specWarnProtector:Play("bigmob")
		if self:IsHeroic() then
			timerProtectorCD:Start(26, self.vb.protectorCount+1)--26-28 variation on heroic
		else
			timerProtectorCD:Start(nil, self.vb.protectorCount+1)--35-37 on normal
		end
	elseif spellId == 117945 then
		warnArcingEnergy:Show()
		timerArcingEnergyCD:Start(args.sourceGUID)
	elseif spellId == 129711 then
		self.vb.stunIcon = 1
		specWarnTotalAnnihilation:Show()
		specWarnTotalAnnihilation:Play("aesoon")
		timerTotalAnnihilation:Start()
		timerArcingEnergyCD:Cancel(args.sourceGUID)--add is dying, so this add is done casting arcing Energy
	elseif spellId == 117949 then
		closedCircuitTargets[#closedCircuitTargets + 1] = args.destName
		self:Unschedule(warnClosedCircuitTargets)
		self:Schedule(0.3, warnClosedCircuitTargets)
	elseif spellId == 119358 then
		local _, _, _, startTime, endTime = UnitCastingInfo("boss1")
		local castTime
		if startTime and endTime then
			castTime = ((endTime or 0) - (startTime or 0)) / 1000
			timerFocusPower:Start(castTime)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(116598, 132265) then--Cast when these are activated
		self.vb.focusActivated = self.vb.focusActivated + 1
		if self.Options.SetIconOnCreature then
			self:ScanForMobs(args.sourceGUID, 0, 8, 6, nil, 10)
		end
		if self.vb.focusActivated == 6 then
			timerDespawnFloor:Start()
			specWarnDespawnFloor:Show()
			specWarnDespawnFloor:Play("runtoedge")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 124967 and not self.vb.phase2Started then--Phase 2 begin/Phase 1 end
		self:SetStage(2)
		self.vb.phase2Started = true--because if you aren't fucking up, you should get more then one draw power.
		self.vb.protectorCount = 0
		self.vb.powerCount = 0
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerBreathCD:Cancel()
		timerProtectorCD:Cancel()
	elseif spellId == 116994 then--Phase 3 begin/Phase 2 end
		self:SetStage(3)
		self.vb.focusActivated = 0
		self.vb.phase2Started = false
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
	elseif spellId == 117878 and args:IsPlayer() then
		local amount = args.amount or 1
		local badAmount = self:IsTrivial() and 30 or 6
		if (amount >= badAmount) and amount % 3 == 0 then--Warn every 3 stacks at 30/6 and above.
			specWarnOvercharged:Show(amount)
			specWarnOvercharged:Play("stackhigh")
		end
	elseif spellId == 119387 then -- do not add other spellids.
		self.vb.powerCount = self.vb.powerCount + 1
		if self.vb.powerCount == 1 then--Special announce first one
			specWarnDrawPower:Show(self.vb.powerCount)
			specWarnDrawPower:Play("phasechange")
		else--Each additional count
			warnDrawPower:Show(self.vb.powerCount)
		end
		timerFocusPower:Cancel()
	elseif spellId == 118310 then--Below 50% health
		specWarnRadiatingEnergies:Show()--Give a good warning so people standing outside barrior don't die.
		specWarnRadiatingEnergies:Play("movecenter")
	elseif spellId == 132226 and args:IsPlayer() then
		timerDestabilized:Start()
	elseif spellId == 132222 then
		stunTargets[#stunTargets + 1] = args.destName
		if self.Options.SetIconOnDestabilized then
			self:SetIcon(args.destName, self.vb.stunIcon)
		end
		self.vb.stunIcon = self.vb.stunIcon + 1
		self:Unschedule(warnStunnedTargets)
		self:Schedule(0.3, warnStunnedTargets)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 116994 then--phase 3 end
		self:SetStage(1)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(1))
		warnPhase:Play("pone")
	elseif spellId == 132226 then
		if args:IsPlayer() then
			timerDestabilized:Cancel()
		end
	elseif spellId == 132222 then
		if self.Options.SetIconOnDestabilized then
			self:SetIcon(args.destName, 0)
		end
	end
end
