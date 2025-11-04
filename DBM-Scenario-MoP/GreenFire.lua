if select(2, UnitClass("player")) ~= "WARLOCK" then return end
local mod	= DBM:NewMod("d594", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal"

mod:SetRevision("20250805083731")
mod:SetZone(1112)

mod:RegisterCombat("scenario", 1112)
mod:RegisterZoneCombat(1112)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

--Essence of Order

--Kanrethad Ebonlocke
local warnSummonPitLord			= mod:NewCastAnnounce(138789, 4, 10)
local warnSummonImpSwarm		= mod:NewCastAnnounce(138685, 3, 10)
local warnSummonDoomlord		= mod:NewCastAnnounce(138755, 3, 10)
local warnSummonFelhunter		= mod:NewCastAnnounce(138751, 3, 10)

--Essence of Order
local specWarnSpellFlame		= mod:NewSpecialWarningDodge(134234, nil, nil, nil, 2, 2)
local specWarnHellfire			= mod:NewSpecialWarningInterrupt(134225, nil, nil, nil, 1, 2)
local specWarnLostSouls			= mod:NewSpecialWarning("specWarnLostSouls", nil, nil, nil, 1, 2)
--Kanrethad Ebonlocke
local specWarnEnslavePitLord	= mod:NewSpecialWarning("specWarnEnslavePitLord", nil, nil, nil, 1, 2)
local specWarnCataclysm			= mod:NewSpecialWarningInterrupt(138564, nil, nil, nil, 1, 2)
local specWarnRainOfFire		= mod:NewSpecialWarningGTFO(138561, nil, nil, nil, 1, 8)
local specWarnChaosBolt			= mod:NewSpecialWarningInterrupt(138559, nil, nil, nil, 3, 2)

--Essence of Order
--Todo, maybe register zone combat scanner and cids for initial combat start timers
local timerSpellFlameCD			= mod:NewNextTimer(11, 134234, nil, nil, nil, 3)--(6 seconds after engage)
local timerHellfireCD			= mod:NewNextTimer(33, 134225, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--(15 after engage)
local timerLostSoulsCD			= mod:NewTimer(43, "timerLostSoulsCD", 51788, nil, nil, 1)--43-50 second variation. (engage is same as cd, 43)
--Kanrethad Ebonlocke
local timerCombatStarts			= mod:NewCombatTimer(33)
local timerPitLordCast			= mod:NewCastTimer(10, 138789, nil, nil, nil, 1)
local timerSummonImpSwarmCast 	= mod:NewCastTimer(10, 138685, nil, nil, nil, 1)
local timerSummonFelhunterCast	= mod:NewCastTimer(9, 138751, nil, nil, nil, 1)
local timerSummonDoomlordCast	= mod:NewCastTimer(10, 138755, nil, nil, nil, 1)
local timerEnslaveDemon			= mod:NewTargetTimer(300, 1098, nil, nil, nil, 5)
local timerDoom					= mod:NewBuffFadesTimer(419, 138558, nil, nil, nil, 5, nil, nil, nil, 1, 10)

local kanrathadAlive = true--So we don't warn to enslave pit lord when he dies and enslave fades.

function mod:SPELL_CAST_START(args)
	if args.spellId == 134234 then
		specWarnSpellFlame:Show()
		specWarnSpellFlame:Play("watchstep")
		timerSpellFlameCD:Start()
	elseif args.spellId == 134225 then
		specWarnHellfire:Show(args.sourceName)
		specWarnHellfire:Play("kickcast")
		timerHellfireCD:Start()
	elseif args.spellId == 138559 then
		specWarnChaosBolt:Show(args.sourceName)
		specWarnChaosBolt:Play("kickcast")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 138680 then
		timerCombatStarts:Start()
		kanrathadAlive = true--Reset this here
	elseif args.spellId == 138789 then
		warnSummonPitLord:Show()
		timerPitLordCast:Start()
		specWarnEnslavePitLord:Schedule(10)
		specWarnEnslavePitLord:ScheduleVoice(10, "bigmob")
	elseif args.spellId == 138685 then
		warnSummonImpSwarm:Show()
		timerSummonImpSwarmCast:Start()
	elseif args.spellId == 138755 then
		warnSummonDoomlord:Show()
		timerSummonDoomlordCast:Start()
	elseif args.spellId == 138751 then
		warnSummonFelhunter:Show()
		timerSummonFelhunterCast:Start()
	elseif args.spellId == 138564 then
		specWarnCataclysm:Show(args.sourceName)
		specWarnCataclysm:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 1098 and args:GetDestCreatureID() == 70075 then
		timerEnslaveDemon:Start(args.destName)
	elseif args.spellId == 138558 then
		timerDoom:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 1098 and args:GetDestCreatureID() == 70075 and kanrathadAlive then
		timerEnslaveDemon:Cancel(args.destName)
		specWarnEnslavePitLord:Show()
		specWarnEnslavePitLord:Play("bigmob")
	elseif args.spellId == 138558 then
		timerDoom:Cancel()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 138561 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnRainOfFire:Show()
		specWarnRainOfFire:Play("watchfeet")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.LostSouls then
		specWarnLostSouls:Show()
		specWarnLostSouls:Play("killmob")
		timerLostSoulsCD:Start()
	end
end

function mod:UNIT_DIED(args)
	if args.destGUID == UnitGUID("player") then--Solo scenario, a player death is a wipe
		self:Stop()
	end
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 68151 then--Essence of Order
		timerSpellFlameCD:Cancel()
		timerHellfireCD:Cancel()
		timerLostSoulsCD:Cancel()
	elseif cid == 69964 then--Kanrethad Ebonlocke
		timerEnslaveDemon:Cancel()
		kanrathadAlive = false
	end
end

--All timers subject to a ~0.5 second clipping due to ScanEngagedUnits
function mod:StartEngageTimers(guid, cid, delay)
	if cid == 68151 then--Essence of Order

	elseif cid == 69964 then--Kanrethad Ebonlocke

	end
end

--Abort timers when all players out of combat, so NP timers clear on a wipe
--Caveat, it won't call stop with GUIDs, so while it might terminate bar objects, it may leave lingering nameplate icons
function mod:LeavingZoneCombat()
	self:Stop(true)
end
