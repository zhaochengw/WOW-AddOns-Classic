local mod	= DBM:NewMod(170, "DBM-Raids-Cata", 5, 73)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241115112135")
mod:SetCreatureID(41570)
mod:SetEncounterID(1024) --no ES fires this boss.
mod:SetZone(669)
--mod:SetModelSound("Sound\\Creature\\Nefarian\\VO_BD_Nefarian_MagmawIntro01.ogg", nil)
--Long: I found this fascinating specimen in the lava underneath this very room. Magmaw should provide an adequate challenge for your pathetic little band.
--Short: There isn't one

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 77690 92177",
	"SPELL_SUMMON 92154",
	"SPELL_AURA_APPLIED 78006 78403 89773",
	"SPELL_AURA_REMOVED 89773",
	"SPELL_DAMAGE 92128",
	"SPELL_MISSED 92128",
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_EMOTE",
	"UNIT_HEALTH boss1",
	"UNIT_DIED"
)

local warnLavaSpew			= mod:NewSpellAnnounce(77689, 3, nil, "Healer")
local warnMoltenTantrum		= mod:NewSpellAnnounce(78403, 4)
local warnInferno			= mod:NewSpellAnnounce(92154, 4)
local warnMangle			= mod:NewTargetNoFilterAnnounce(89773, 3, nil, "Tank|Healer")
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2, 3)--heroic
local warnPhase2			= mod:NewPhaseAnnounce(2, 4)--heroic

local specWarnPillar		= mod:NewSpecialWarningSwitch(-3312, "Ranged", nil, nil, 1, 2)
local specWarnIgnition		= mod:NewSpecialWarningGTFO(92128, nil, nil, nil, 1, 8)
local specWarnInfernoSoon   = mod:NewSpecialWarning("SpecWarnInferno", nil, nil, nil, 1, 2)
local specWarnArmageddon	= mod:NewSpecialWarningRun(92177, nil, nil, nil, 4, 2)

local timerLavaSpew			= mod:NewCDTimer(22, 77689, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerPillarFlame		= mod:NewCDTimer(32.5, 78006, nil, nil, nil, 1)--This timer is a CD timer. 30-40 seconds. Use your judgement.
local timerMangle			= mod:NewTargetTimer(30, 89773, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerExposed			= mod:NewBuffActiveTimer(30, 79011, nil, nil, nil, 5, nil, DBM_COMMON_L.DAMAGE_ICON)
local timerMangleCD			= mod:NewCDTimer(95, 89773, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerInferno			= mod:NewNextTimer(35, 92154, nil, nil, nil, 1, nil, DBM_COMMON_L.HEROIC_ICON)
local timerArmageddon		= mod:NewCastTimer(8, 92177, nil, nil, nil, 3)

local berserkTimer			= mod:NewBerserkTimer(600)

mod.vb.prewarnedPhase2 = false

function mod:OnCombatStart(delay)
	self.vb.prewarnedPhase2 = false
	timerPillarFlame:Start(30-delay)
	timerMangleCD:Start(90-delay)
	berserkTimer:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerInferno:Start(30-delay)
		specWarnInfernoSoon:Schedule(26-delay)
		specWarnInfernoSoon:ScheduleVoice(26-delay, "bigmobsoon")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 77690 and self:AntiSpam(5, 1) then
		warnLavaSpew:Show()
		timerLavaSpew:Start()
	elseif args.spellId == 92177 then
		specWarnArmageddon:Show()
		specWarnArmageddon:Play("justrun")
		timerArmageddon:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 92154 then
		warnInferno:Show()
		specWarnInfernoSoon:Schedule(31)
		specWarnInfernoSoon:ScheduleVoice(31, "bigmobsoon")
		timerInferno:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 78006 then--More than one spellid?
		specWarnPillar:Show()
		specWarnPillar:Play("killmob")
		timerPillarFlame:Start()
	elseif args.spellId == 78403 then
		warnMoltenTantrum:Show()
	elseif args.spellId == 89773 then
		warnMangle:Show(args.destName)
		timerMangle:Start(args.destName)
		timerMangleCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 89773 then
		timerMangle:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 92128 and destGUID == UnitGUID("player") and self:AntiSpam(4, 2) then
		specWarnIgnition:Show(spellName)
		specWarnIgnition:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

-- heroic phase 2
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		timerInferno:Cancel()
		specWarnInfernoSoon:Cancel()
		specWarnInfernoSoon:CancelVoice()
		warnPhase2:Show()
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Slump or msg:find(L.Slump) then
		timerPillarFlame:Start(15)--Resets to 15. If you don't get his head down by then he gives you new adds to mess with. (theory, don't have a lot of logs with chain screwups yet)
	elseif msg == L.HeadExposed or msg:find(L.HeadExposed) then
		timerExposed:Start()
		timerPillarFlame:Start(40)
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 41570 and self:IsDifficulty("heroic10", "heroic25") then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 40 and self.vb.prewarnedPhase2 then
			self.vb.prewarnedPhase2 = false
		elseif h > 29 and h < 34 and not self.vb.prewarnedPhase2 then
			self.vb.prewarnedPhase2 = true
			warnPhase2Soon:Show()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 49416 then--Blazing Bone Construct
		timerArmageddon:Stop(args.destGUID)
	end
end
