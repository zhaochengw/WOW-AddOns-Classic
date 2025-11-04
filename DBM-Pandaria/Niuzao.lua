local mod	= DBM:NewMod(859, "DBM-Pandaria", nil, 322, 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20240714050536")
mod:SetCreatureID(71954)
mod:SetReCombatTime(20)
mod:EnableWBEngageSync()--Enable syncing engage in outdoors

mod:RegisterCombat("combat_yell", L.Pull)
mod:RegisterKill("yell", L.Victory, L.VictoryDem)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 144610 144611 144608",
	"SPELL_AURA_APPLIED 144606",
	"SPELL_AURA_APPLIED_DOSE 144606",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

local warnOxenFortitude		= mod:NewStackAnnounce(144606, 2, nil, false)--144607 player version, but better to just track boss and announce stacks

local specWarnHeadbutt		= mod:NewSpecialWarningDefensive(144610, nil, nil, nil, 1, 2)
local specWarnHeadbuttTaunt	= mod:NewSpecialWarningTaunt(144610, nil, nil, nil, 1, 2)
local specWarnMassiveQuake	= mod:NewSpecialWarningSpell(144611, nil, nil, nil, 2, 2)
local specWarnCharge		= mod:NewSpecialWarningDodge(144609, "Melee", nil, nil, 2, 2)--66 and 33%. Maybe add pre warns

local timerHeadbuttCD		= mod:NewCDTimer(47, 144610, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerMassiveQuake		= mod:NewBuffActiveTimer(13, 144611, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerMassiveQuakeCD	= mod:NewCDTimer(48, 144611, nil, nil, nil, 2)

mod:AddReadyCheckOption(33117, false, 90)

function mod:OnCombatStart(delay, yellTriggered)
	if yellTriggered then
		timerHeadbuttCD:Start(16-delay)
		timerMassiveQuakeCD:Start(45-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 144610 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnHeadbutt:Show()
			specWarnHeadbutt:Play("carefly")
		else
			local bossTarget, bossTargetUID = self:GetBossTarget(71954)
			if bossTargetUID then
				if self:IsTanking(bossTargetUID, nil, nil, true, args.sourceGUID) then
					specWarnHeadbuttTaunt:Show(bossTarget or DBM_COMMON_L.UNKNOWN)
					specWarnHeadbuttTaunt:Play("tauntboss")
				end
			end
		end
		timerHeadbuttCD:Start()
	elseif spellId == 144611 then
		specWarnMassiveQuake:Show()
		specWarnMassiveQuake:Play("aesoon")
		timerMassiveQuake:Start()
		timerMassiveQuakeCD:Start()
	elseif spellId == 144608 then
		specWarnCharge:Show()
		specWarnCharge:Play("chargemove")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 144606 then
		warnOxenFortitude:Show(args.destName, args.amount or 1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

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
