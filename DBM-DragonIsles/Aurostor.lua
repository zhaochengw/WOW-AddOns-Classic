local mod	= DBM:NewMod(2562, "DBM-DragonIsles", nil, 1205)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240119065317")
mod:SetCreatureID(209574)
mod:SetEncounterID(2828)
mod:SetReCombatTime(30)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors
mod:SetHotfixNoticeRev(20240119000000)
mod:SetMinSyncRevision(20240119000000)

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_yell", L.Pull)
mod:RegisterKill("yell", L.Win)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 420895 420925 421260 421059",
	"SPELL_CAST_SUCCESS 421006",
	"SPELL_AURA_APPLIED 421260 181089"
)

local warnCrankyTantrum				= mod:NewCountAnnounce(421059, 3)

local specWarnGroggyBash				= mod:NewSpecialWarningYou(420895, nil, nil, nil, 1, 2)
local specWarnPulverizingOutburst		= mod:NewSpecialWarningDodge(420925, nil, nil, nil, 1, 2)
local specWarnRoarDebuff				= mod:NewSpecialWarningJump(421260, nil, nil, nil, 1, 6)

local timerGroggyBashCD					= mod:NewCDTimer(32.7, 420895, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)
--local timerPulverizingOutburstCD		= mod:NewAITimer(15.7, 420925, nil, nil, nil, 3)--15-59 is too much variation, would need spell queuing and cast priority to be sorted out
local timerSlumberingRoarCD				= mod:NewCDTimer(70.9, 421260, nil, nil, nil, 2)--Small sample
local timerCrankyTantrumCD				= mod:NewCDTimer(27.9, 421059, nil, nil, nil, 3)--27.9-43.8

mod.vb.tantrumCount = 0

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 420895 then
		timerGroggyBashCD:Start()
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnGroggyBash:Show()
			specWarnGroggyBash:Play("carefly")
		end
	elseif spellId == 420925 then
		specWarnPulverizingOutburst:Show()
		specWarnPulverizingOutburst:Play("chargemove")
--		timerPulverizingOutburstCD:Start()
	elseif spellId == 421260 then
		timerSlumberingRoarCD:Start()
	elseif spellId == 421059 then
		self.vb.tantrumCount = self.vb.tantrumCount + 1
		warnCrankyTantrum:Show(self.vb.tantrumCount)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 421006 then
		self.vb.tantrumCount = 0
		timerCrankyTantrumCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 421260 and args:IsPlayer() then
		specWarnRoarDebuff:Show()
		specWarnRoarDebuff:Play("keepjump")
	elseif spellId == 181089 then--Encounter Event
		DBM:EndCombat(self)
	end
end
