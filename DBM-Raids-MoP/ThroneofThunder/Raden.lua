local mod	= DBM:NewMod(831, "DBM-Raids-MoP", 2, 362)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "heroic,heroic25"

mod:SetRevision("20260126031700")
mod:SetCreatureID(69473)--69888
mod:SetEncounterID(1580, 1581)
mod:SetUsedIcons(1)
mod:SetZone(1098)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 138338 138339 138321",
	"SPELL_CAST_SUCCESS 138333 138334",
	"SPELL_AURA_APPLIED 138331 138332 139318 138372 138288 138297 138308 138295",
	"SPELL_AURA_REMOVED 138297 138308 138288 138295",
	"SPELL_DAMAGE 138296",
	"SPELL_MISSED 138296",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_POWER_UPDATE boss1",
	"CHAT_MSG_MONSTER_YELL"
)

--Anima
local warnAnima					= mod:NewSpellAnnounce(138331, 2)--Switched to anima phase
local warnUnstableAnima			= mod:NewTargetNoFilterAnnounce(138288)--May range frame needed. 138295/138296 is damage ids, 138288 is debuff cast.
local warnSanguineHorror		= mod:NewCountAnnounce(138338, 3, nil, "-Healer")--Adds
--Vita
local warnVita					= mod:NewSpellAnnounce(138332, 2)--Switched to vita phase
local warnUnstableVita			= mod:NewTargetNoFilterAnnounce(138297, 4)
--General
local warnPhase2				= mod:NewPhaseAnnounce(2, 2)

--Anima
local specWarnMurderousStrike	= mod:NewSpecialWarningDefensive(138333, "Tank", nil, nil, 3, 2)
local specWarnSanguineHorror	= mod:NewSpecialWarningSwitch(138338, "Ranged|Tank", nil, nil, 1, 2)
local specWarnAninaSensitive	= mod:NewSpecialWarningYou(139318, nil, nil, nil, 1, 2)
local specWarnUnstableAnima		= mod:NewSpecialWarningYou(138288, nil, nil, nil, 3, 2)
local yellUnstableAnima			= mod:NewYell(138288, nil, false)
--Vita
local specWarnFatalStrike		= mod:NewSpecialWarningDefensive(138334, "Tank", nil, nil, 3, 2)
local specWarnCracklingStalker	= mod:NewSpecialWarningSwitchCount(138339, "-Healer")
local specWarnVitaSensitive		= mod:NewSpecialWarningYou(138372, nil, nil, nil, 1, 2)
local specWarnUnstablVita		= mod:NewSpecialWarningYou(138297, nil, nil, nil, 3, 17)
local specWarnUnstablVitaJump	= mod:NewSpecialWarning("specWarnUnstablVitaJump", nil, nil, nil, 1, 17)
local yellUnstableVita			= mod:NewYell(138297, nil, false)
--General
local specWarnCreation			= mod:NewSpecialWarningCount(138321, "-Healer")--No idea what to do with voice pack support so none added
local specWarnCallEssence		= mod:NewSpecialWarningSpell(139040, "-Healer")--No idea what to do with voice pack support so none added

--Anima
local timerMurderousStrikeCD	= mod:NewCDTimer(33, 138333, nil, "Tank", nil, 5, nil, nil, nil, 3, 4)--Gains 3 power per second roughly and uses special at 100 Poewr
local timerSanguineHorrorCD		= mod:NewCDCountTimer(41, 138338, nil, nil, nil, 1)--CD not known. No one fights him in anima phase for more than like 1-2 seconds.
local timerAnimaExplosion		= mod:NewNextTimer(15, 138295, nil, nil, nil, 3, nil, nil, nil, 2, 4)
--Vita
local timerFatalStrikeCD		= mod:NewCDTimer(10, 138334, nil, "Tank", nil, 5, nil, nil, nil, 3, 4)--Gains 10 power per second roughly and uses special at 100 Poewr
local timerUnstableVita			= mod:NewTargetTimer(12, 138297, nil, nil, nil, 3)
local timerCracklingStalkerCD	= mod:NewCDCountTimer(41, 138339, nil, nil, nil, 1)
--General
local timerCreationCD			= mod:NewCDCountTimer(32.5, 138321, nil, nil, nil, 1, nil, nil, nil, 1, 4)--32.5-35second variation
local timerCallEssenceCD		= mod:NewNextTimer(15.5, 139040, nil, nil, nil, 1)

mod:AddSetIconOption("SetIconsOnVita", 138297, false, 0, {1})

mod.vb.creationCount = 0
mod.vb.stalkerCount = 0
mod.vb.horrorCount = 0
mod.vb.lastStalker = 0
local vitaName, animaName = DBM:GetSpellName(138332), DBM:GetSpellName(138331)

function mod:OnCombatStart(delay)
	self.vb.creationCount = 0
	self.vb.stalkerCount = 0
	self.vb.horrorCount = 0
	timerCreationCD:Start(11-delay, 1)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 138338 then
		self.vb.horrorCount = self.vb.horrorCount + 1
		if self.Options.SpecWarn138338switch then
			specWarnSanguineHorror:Show()
			specWarnSanguineHorror:Play("killbigmob")
		else
			warnSanguineHorror:Show(self.vb.horrorCount)
		end
--		timerSanguineHorrorCD:Start(nil, horrorCount+1)
	elseif spellId == 138339 then
		self.vb.lastStalker = GetTime()
		self.vb.stalkerCount = self.vb.stalkerCount + 1
		specWarnCracklingStalker:Show(self.vb.stalkerCount)
		timerCracklingStalkerCD:Start(nil, self.vb.stalkerCount+1)
	elseif spellId == 138321 then
		self.vb.creationCount = self.vb.creationCount + 1
		specWarnCreation:Show(self.vb.creationCount)
		timerCreationCD:Start(nil, self.vb.creationCount+1)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 138333 then
		timerMurderousStrikeCD:Start()
	elseif spellId == 138334 then
		timerFatalStrikeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 138331 then--Anima Phase
		local radenPower = UnitPower("boss1")
		radenPower = radenPower / 3
		self.vb.horrorCount = 0
		timerFatalStrikeCD:Cancel()
		timerCracklingStalkerCD:Cancel()
		timerMurderousStrikeCD:Start(33-radenPower)
		timerSanguineHorrorCD:Start(8, 1)
		warnAnima:Show()
	elseif spellId == 138332 then--Vita Phase
		local radenPower = UnitPower("boss1")
		radenPower = radenPower / 10
		local stalkerupdate = nil
		if GetTime() - self.vb.lastStalker < 32 then--Check if it's been at least 32 seconds since last stalker
			stalkerupdate = 40 - (GetTime() - self.vb.lastStalker)--if not, find out how much time is left on internal stalker cd (cause CD doesn't actually reset when you reset vita, it just extends to 8-9 seconds if less than 8-9 seconds remaining)
		else
			stalkerupdate = 8
		end
		self.vb.stalkerCount = 0
		warnVita:Show()
		timerMurderousStrikeCD:Cancel()
		timerSanguineHorrorCD:Cancel()
		timerCracklingStalkerCD:Start(stalkerupdate, 1)
		timerFatalStrikeCD:Start(10-radenPower)
	elseif spellId == 139318 then--Anima Sensitivity
		if args:IsPlayer() then
			specWarnAninaSensitive:Show()
			specWarnAninaSensitive:Play("stilldanger")
		end
	elseif spellId == 138372 then--Vita Sensitivity
		if args:IsPlayer() then
			specWarnVitaSensitive:Show()
			specWarnVitaSensitive:Play("stilldanger")
		end
	elseif spellId == 138288 or spellId == 138295 then--Unstable Anima
		warnUnstableAnima:Show(args.destName)
		if args:IsPlayer() then
			specWarnUnstableAnima:Show()
			specWarnUnstableAnima:Play("gathershare")
			yellUnstableAnima:Yell()
			if spellId == 138295 then--10 seconds
				timerAnimaExplosion:Start(10)
			else--15
				timerAnimaExplosion:Start(15)
			end
		end
	elseif args:IsSpellID(138297, 138308) then--Unstable Vita (138297 cast, 138308 jump)
		if self.Options.SetIconsOnVita then
			self:SetIcon(args.destName, 1)
		end
		warnUnstableVita:Show(args.destName)
		if self:IsDifficulty("heroic25") then
			timerUnstableVita:Start(5, args.destName)
		else
			timerUnstableVita:Start(args.destName)
		end
		if args:IsPlayer() then
			if spellId == 138297 then
				specWarnUnstablVita:Show()
				specWarnUnstablVita:Play("debuffyou")
			else
				specWarnUnstablVitaJump:Show()
				specWarnUnstablVitaJump:Play("debuffyou")
			end
			yellUnstableVita:Yell()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if args:IsSpellID(138297, 138308) and self.Options.SetIconsOnVita then--Unstable Vita
		self:SetIcon(args.destName, 0)
	elseif spellId == 138288 or spellId == 138295 then
		timerAnimaExplosion:Cancel()
	end
end

function mod:SPELL_DAMAGE(_, sourceName, _, _, destGUID, destName, _, _, spellId, spellName)
	if spellId == 138296 and self:AntiSpam(5, 4) and sourceName == UnitName("player") then--Solo Soak
		timerAnimaExplosion:Start(15)
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 139040 then--Call Essence
		specWarnCallEssence:Show()
		timerCallEssenceCD:Start()
	elseif spellId == 139073 then--Phase 2 (the Ruin Trigger)
		warnPhase2:Show()
		timerCracklingStalkerCD:Cancel()
		timerSanguineHorrorCD:Cancel()
		timerMurderousStrikeCD:Cancel()
		timerFatalStrikeCD:Cancel()
		timerCreationCD:Cancel()
		timerCallEssenceCD:Start()
	end
end

function mod:UNIT_POWER_UPDATE(uId)
	local power = UnitPower(uId)
	if power >= 80 and DBM:UnitBuff(uId, vitaName) and self:AntiSpam(4, 1) then
		specWarnFatalStrike:Show()
		specWarnFatalStrike:Play("defensive")
	elseif power >= 93 and DBM:UnitBuff(uId, animaName) and self:AntiSpam(10, 2) then
		specWarnMurderousStrike:Show()
		specWarnMurderousStrike:Play("defensive")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Defeat or msg:find(L.Defeat) then
		DBM:EndCombat(self)
	end
end
