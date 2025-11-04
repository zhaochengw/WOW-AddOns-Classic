local mod	= DBM:NewMod(857, "DBM-Pandaria", nil, 322, 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240412041201")
mod:SetCreatureID(71952)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors

mod:RegisterCombat("combat_yell", L.Pull)
mod:RegisterKill("yell", L.Victory)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 144468 144471 144470 144473 144461",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

local warnFirestorm				= mod:NewSpellAnnounce(144461, 2, nil, false)

local specWarnInspiringSong		= mod:NewSpecialWarningInterrupt(144468, nil, nil, nil, 1, 2)
local specWarnBeaconOfHope		= mod:NewSpecialWarningMoveTo(144473, nil, nil, nil, 1, 2)
local specWarnBlazingSong		= mod:NewSpecialWarningSpell(144471, nil, nil, nil, 3, 2)
local specWarnCraneRush			= mod:NewSpecialWarningDodge(144470, nil, nil, nil, 2, 2)

local timerInspiringSongCD		= mod:NewCDTimer(30, 144468, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--30-50sec variation?
local timerBlazingSong			= mod:NewBuffActiveTimer(15, 144471, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON)

mod:AddReadyCheckOption(33117, false, 90)

function mod:BeaconTarget(targetname, uId)
	if not targetname then return end
	specWarnBeaconOfHope:Show(targetname)
	specWarnBeaconOfHope:Play("findshelter")
end

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then--We know for sure this is an actual pull and not diving into in progress
		timerInspiringSongCD:Start(20-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 144468 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnInspiringSong:Show(args.sourceName)
			specWarnInspiringSong:Play("kickcast")
		end
		timerInspiringSongCD:Start()
	elseif spellId == 144471 then
		specWarnBlazingSong:Show()
		specWarnBlazingSong:Play("aesoon")
		timerBlazingSong:Start()
	elseif spellId == 144470 then
		specWarnCraneRush:Show()
		specWarnCraneRush:Play("watchstep")
	elseif spellId == 144473 then
		self:BossTargetScanner(args.sourceGUID, "BeaconTarget", 0.1, 20, nil, nil, nil, nil, true)--Only announce non tanks
	elseif spellId == 144461 then
		warnFirestorm:Show()
	end
end

--This method works without local and doesn't fail with curse of tongues. However, it requires at least ONE person in raid targeting boss to be running dbm (which SHOULD be most of the time)
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 148318 or spellId == 148317 or spellId == 149304 and self:AntiSpam(3, 2) then--use all 3 because i'm not sure which ones fire on repeat kills
		self:SendSync("Victory")
	end
end

function mod:OnSync(msg)
	if msg == "Victory" and self:IsInCombat() then
		DBM:EndCombat(self)
	end
end
