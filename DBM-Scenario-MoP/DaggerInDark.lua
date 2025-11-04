local mod	= DBM:NewMod("d616", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal"

mod:SetRevision("20241118070307")
mod:SetZone(1095)

mod:RegisterCombat("scenario", 1095)

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_SAY",
	"SPELL_CAST_START 133121 133804",
	"SPELL_CAST_SUCCESS 132984",
	"SPELL_PERIODIC_DAMAGE 133001",
	"SPELL_PERIODIC_MISSED 133001",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

--Darkhatched Lizard-Lord
local warnWaterJets			= mod:NewCastAnnounce(133121, 2, 3)
--Rak'gor Bloodrazor
local warnFixate			= mod:NewSpellAnnounce(132984, 3)

--Broodmaster Noshi
local specWarnDeathNova		= mod:NewSpecialWarningSpell(133804, nil, nil, nil, 2, 2)
--Rak'gor Bloodrazor
local specWarnGasBomb		= mod:NewSpecialWarningGTFO(133001, nil, nil, nil, 1, 8)

--Darkhatched Lizard-Lord
local timerAddsCD			= mod:NewTimer(60, "timerAddsCD", 2457, nil, nil, 1)
--Broodmaster Noshi
local timerDeathNova		= mod:NewCastTimer(20, 133804, nil, nil, nil, 2)
--Rak'gor Bloodrazor
local timerFixateCD			= mod:NewNextTimer(20, 132984, nil, nil, nil, 3)

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.LizardLord or msg:find(L.LizardLord) then
		self:SendSync("LizardPulled")
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 133121 then
		warnWaterJets:Show()
	elseif args.spellId == 133804 then
		specWarnDeathNova:Show()
		specWarnDeathNova:Play("specialsoon")
		timerDeathNova:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 132984 then
		warnFixate:Show()
		timerFixateCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 133001 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnGasBomb:Show(spellName)
		specWarnGasBomb:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 67263 then--Darkhatched Lizard-Lord
		timerAddsCD:Cancel()
	elseif cid == 67264 then--Broodmaster Noshi
		timerDeathNova:Cancel()
	elseif cid == 67266 then--Rak'gor Bloodrazor
		timerFixateCD:Cancel()
	end
end

--"<78.3 22:22:54> [CHAT_MSG_RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE#The Darkhatched Lizard-Lord calls for help!#Darkhatched Lizard-Lord#####0#0##0#987#nil#0#false#false"]
--"<78.3 22:22:54> [UNIT_SPELLCAST_SUCCEEDED] Darkhatched Lizard-Lord [[target:Summon Adds Dummy::0:133091]]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 133091 and self:AntiSpam() then
		self:SendSync("LizardAdds")
	end
end

function mod:OnSync(msg)
	if msg == "LizardPulled" then
		timerAddsCD:Start(5)
	elseif msg == "LizardAdds" then
		timerAddsCD:Start()
	end
end
