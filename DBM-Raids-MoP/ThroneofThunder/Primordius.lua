local mod	= DBM:NewMod(820, "DBM-Raids-MoP", 2, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20260126031700")
mod:SetCreatureID(69017)--69070 Viscous Horror, 69069 good ooze, 70579 bad ooze (patched out of game, :\)
mod:SetEncounterID(1574)
mod:SetUsedIcons(8, 7, 6, 5)--Although if you have 4 viscous horrors up, you are probably doing fight wrong.
mod:SetZone(1098)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 136216",
	"SPELL_CAST_SUCCESS 136037",
	"SPELL_AURA_APPLIED 136050 137000 136215 136246 136225 136228 136245 140546 136210",
	"SPELL_AURA_APPLIED_DOSE 136050 137000",
	"SPELL_AURA_REMOVED 136050 136215 136225 136245 140546",
	"UNIT_AURA player",
	"UNIT_DIED"
)

local warnDebuffCount				= mod:NewAnnounce("warnDebuffCount", 1, 140546)
local warnMalformedBlood			= mod:NewStackAnnounce(136050, 2, nil, "Tank|Healer")--No cd bars for this because it's HIGHLY variable (lowest priority spell so varies wildly depending on bosses 3 buffs)
local warnPrimordialStrike			= mod:NewSpellAnnounce(136037, 3, nil, "Tank|Healer")
local warnGasBladder				= mod:NewTargetNoFilterAnnounce(136215, 4)--Stack up in front for (but not too close or cleave will get you)
local warnEruptingPustules			= mod:NewTargetNoFilterAnnounce(136246, 4)--Useful?
local warnPathogenGlands			= mod:NewTargetNoFilterAnnounce(136225, 3)
local warnVolatilePathogen			= mod:NewTargetNoFilterAnnounce(136228, 4, nil, "Healer", 2)
local warnMetabolicBoost			= mod:NewTargetNoFilterAnnounce(136245, 3)--Makes Malformed Blood, Primordial Strike and melee 50% more often
local warnVentralSacs				= mod:NewTargetNoFilterAnnounce(136210, 2)--This one is a joke, if you get it, be happy.
--local warnAcidicSpines			= mod:NewTargetAnnounce(136218, 3)
local warnBlackBlood				= mod:NewStackAnnounce(137000, 2, nil, "Tank|Healer")

local specWarnFullyMutated			= mod:NewSpecialWarningYou(140546, nil, nil, nil, 1, 16)
local specWarnFullyMutatedFaded		= mod:NewSpecialWarningFades(140546, nil, nil, nil, 1, 18)
local specWarnCausticGas			= mod:NewSpecialWarningSpell(136216, nil, nil, nil, 2, 2)--All must be in front for this.
local specWarnVolatilePathogen		= mod:NewSpecialWarningYou(136228, false, nil, 2, 1, 17)
local specWarnViscousHorror			= mod:NewSpecialWarningCount(-6969, "Tank", nil, nil, 1, 2)

local timerFullyMutated				= mod:NewBuffFadesTimer(120, 140546, nil, nil, nil, 5)
local timerMalformedBlood			= mod:NewTargetTimer(60, 136050, nil, "Tank|Healer", nil, 5)
local timerPrimordialStrikeCD		= mod:NewCDTimer(21.1, 136037)--Used to be 24?
local timerCausticGasCD				= mod:NewCDTimer(14, 136216, nil, nil, nil, 2)
local timerVolatilePathogenCD		= mod:NewCDTimer(27, 136228, nil, nil, nil, 3)
local timerBlackBlood				= mod:NewTargetTimer(60, 137000, nil, "Tank|Healer")
local timerViscousHorrorCD			= mod:NewNextCountTimer(30, -6969, nil, nil, nil, 1, 137000)

local berserkTimer					= mod:NewBerserkTimer(480)

mod:AddSetIconOption("SetIconOnBigOoze", -6969, true, 5, {8, 7, 6, 5})

local goodCount = 0
local badCount = 0
local usedMarks, bigOozeGUIDS = {}, {}
mod.vb.metabolicBoost = false
mod.vb.bigOozeCount = 0

local function BigOoze()
	mod.vb.bigOozeCount = mod.vb.bigOozeCount + 1
	specWarnViscousHorror:Show(mod.vb.bigOozeCount)
	specWarnViscousHorror:Play("bigmob")
	timerViscousHorrorCD:Start(30, mod.vb.bigOozeCount+1)
	mod:Schedule(30, BigOoze)
	--This is a means to try and do it without using lots of cpu on an already cpu bad fight. If it's not fast enough or doesn't work well (ie people with assist aren't doing this fast enough). may still have to scan all targets
	if DBM:GetRaidRank() > 0 and mod.Options.SetIconOnBigOoze then--Only register event if option is turned on, otherwise no waste cpu
		mod:RegisterShortTermEvents(
			"PLAYER_TARGET_CHANGED",
			"UPDATE_MOUSEOVER_UNIT"
		)
	end
end

function mod:PLAYER_TARGET_CHANGED()
	local guid = UnitGUID("target")
	if guid and self:IsCreatureGUID(guid) then
		local cId = self:GetCIDFromGUID(guid)
		if cId == 69070 and not bigOozeGUIDS[guid] and not UnitIsDead("target") then
			for i = 8, 4, -1 do
				if not usedMarks[i] and not bigOozeGUIDS[guid] then
					bigOozeGUIDS[guid] = i
					usedMarks[i] = guid
					if self.Options.SetIconOnBigOoze then
						self:ScanForMobs(guid, 2, i, 1, nil, 12, "SetIconOnBigOoze")
					end
					return
				end
			end
			self:UnregisterShortTermEvents()--Add is marked, unregister events until next ooze spawns
			self:SendSync("BigOozeGUID", guid)--Make sure we keep everynoes ooze guid ignore list/counts up to date.
		end
	end
end

function mod:UPDATE_MOUSEOVER_UNIT()
	local guid = UnitGUID("mouseover")
	if guid and self:IsCreatureGUID(guid) then
		local cId = self:GetCIDFromGUID(guid)
		if cId == 69070 and not bigOozeGUIDS[guid] and not UnitIsDead("mouseover") then
			for i = 8, 4, -1 do
				if not usedMarks[i] and not bigOozeGUIDS[guid] then
					bigOozeGUIDS[guid] = i
					usedMarks[i] = guid
					if self.Options.SetIconOnBigOoze then
						self:ScanForMobs(guid, 2, i, 1, nil, 12, "SetIconOnBigOoze")
					end
					return
				end
			end
			self:UnregisterShortTermEvents()--Add is marked, unregister events until next ooze spawns
			self:SendSync("BigOozeGUID", guid)
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.metabolicBoost = false
	goodCount = 0
	badCount = 0
	self.vb.bigOozeCount = 0
	table.wipe(bigOozeGUIDS)
	berserkTimer:Start(-delay)
	if self:IsHeroic() then
		timerViscousHorrorCD:Start(11.5-delay, 1)
		self:Schedule(11.5, BigOoze)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 136216 then
		specWarnCausticGas:Show()
		specWarnCausticGas:Play("gathershare")
		timerCausticGasCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 136037 then
		warnPrimordialStrike:Show()
		if self.vb.metabolicBoost then--Only issue is updating current bar when he gains buff in between CDs, it does seem to affect it to a degree
			timerPrimordialStrikeCD:Start(20)
		else
			timerPrimordialStrikeCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 136050 then
		warnMalformedBlood:Show(args.destName, args.amount or 1)
		timerMalformedBlood:Start(args.destName)
	elseif spellId == 137000 then
		warnBlackBlood:Show(args.destName, args.amount or 1)
		timerBlackBlood:Start(args.destName)
	elseif spellId == 136215 then
		warnGasBladder:Show(args.destName)
	elseif spellId == 136246 then
		warnEruptingPustules:Show(args.destName)
	elseif spellId == 136225 then
		warnPathogenGlands:Show(args.destName)
	elseif spellId == 136228 then
		warnVolatilePathogen:Show(args.destName)
		timerVolatilePathogenCD:Start()
		if args:IsPlayer() then
			specWarnVolatilePathogen:Show()
			specWarnVolatilePathogen:Play("debuffyou")
		end
	elseif spellId == 136245 then
		self.vb.metabolicBoost = true
		warnMetabolicBoost:Show(args.destName)
	elseif spellId == 136210 then
		warnVentralSacs:Show(args.destName)
	elseif spellId == 140546 and args:IsPlayer() then
		specWarnFullyMutated:Show()
		specWarnFullyMutated:Play("dpsmore")
		local _, _, _, _, _, expires = DBM:UnitDebuff("player", args.spellName)
		timerFullyMutated:Start(expires-GetTime())
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 136050 then
		timerMalformedBlood:Cancel(args.destName)
	elseif spellId == 136215 then
		timerCausticGasCD:Cancel()
	elseif spellId == 136225 then
		timerVolatilePathogenCD:Cancel()
	elseif spellId == 136245 then
		self.vb.metabolicBoost = false
	elseif spellId == 140546 and args:IsPlayer() and self:IsInCombat() then
		timerFullyMutated:Cancel()--Can be dispeled
		specWarnFullyMutatedFaded:Show()
		specWarnFullyMutatedFaded:Play("screwup")
	end
end

do
	local good1, good2, good3, good4 = DBM:GetSpellName(136180), DBM:GetSpellName(136182), DBM:GetSpellName(136184), DBM:GetSpellName(136186)
	local bad1, bad2, bad3, bad4 = DBM:GetSpellName(136181), DBM:GetSpellName(136183), DBM:GetSpellName(136185), DBM:GetSpellName(136187)
	function mod:UNIT_AURA()
		local gcnt, gcnt1, gcnt2, gcnt3, gcnt4, bcnt, bcnt1, bcnt2, bcnt3, bcnt4
		gcnt1 = select(3, DBM:UnitDebuff("player", good1)) or 0
		gcnt2 = select(3, DBM:UnitDebuff("player", good2)) or 0
		gcnt3 = select(3, DBM:UnitDebuff("player", good3)) or 0
		gcnt4 = select(3, DBM:UnitDebuff("player", good4)) or 0
		bcnt1 = select(3, DBM:UnitDebuff("player", bad1)) or 0
		bcnt2 = select(3, DBM:UnitDebuff("player", bad2)) or 0
		bcnt3 = select(3, DBM:UnitDebuff("player", bad3)) or 0
		bcnt4 = select(3, DBM:UnitDebuff("player", bad4)) or 0
		gcnt = gcnt1 + gcnt2 + gcnt3 + gcnt4
		bcnt = bcnt1 + bcnt2 + bcnt3 + bcnt4
		if goodCount ~= gcnt or badCount ~= bcnt then
			goodCount = gcnt
			badCount = bcnt
			warnDebuffCount:Show(goodCount, badCount)
		end
	end
end

function mod:UNIT_DIED(args)
	if bigOozeGUIDS[args.destGUID] then
		bigOozeGUIDS[args.destGUID] = nil
	end
end

function mod:OnSync(msg, guid)
	if msg == "BigOozeGUID" and guid then
		bigOozeGUIDS[guid] = true
		self:UnregisterShortTermEvents()
	end
end
