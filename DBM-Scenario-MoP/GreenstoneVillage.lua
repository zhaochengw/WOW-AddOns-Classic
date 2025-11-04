local mod	= DBM:NewMod("d492", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal"

mod:SetRevision("20241118070307")
mod:SetZone(1024)

mod:RegisterCombat("scenario", 1024)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 131143 119364",
	"SPELL_CAST_START 117664",
--	"SPELL_CAST_SUCCESS",
	"UNIT_DIED"
)

--Beast of Jade
local warnJadeStatue			= mod:NewSpellAnnounce(119364, 4)
--Vengeful Hui
local warnSummonSeedlings		= mod:NewSpellAnnounce(117664, 2)

--Cursed Brew
local specWarnBrewBubble		= mod:NewSpecialWarningSwitch(131143, "Dps", nil, nil, 1, 2)
--Beast of Jade
local specWarnJadeStatue		= mod:NewSpecialWarningInterrupt(119364, "HasInterrupt", nil, nil, 1, 2)

--Cursed Brew
local timerBrewBubbleCD			= mod:NewCDTimer(15, 131143, nil, nil, nil, 3)
--Beast of Jade
local timerJadeStatueCD			= mod:NewCDTimer(18, 119364, nil, nil, nil, 4, nil, DBM_COMMON_L.INTERRUPT_ICON)--Small sample size. May be incorrect.
--Vengeful Hui
local timerSummonSeedlingsCD	= mod:NewNextTimer(14.4, 117664, nil, nil, nil, 1)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 131143 then
		timerBrewBubbleCD:Start()
		if not args:IsPlayer() then--Only those not trapped in bubble can help
			specWarnBrewBubble:Show()
			specWarnBrewBubble:Play("targetchange")
		end
	elseif args.spellId == 119364 then
		if self.Options.SpecWarn119364interrupt and self:CheckInterruptFilter(args.sourceGUID, nil, true) then
			specWarnJadeStatue:Show(args.sourceName)
			specWarnJadeStatue:Play("kickcast")
		else
			warnJadeStatue:Show()
		end
		timerJadeStatueCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 117664 then
		warnSummonSeedlings:Show()
		timerSummonSeedlingsCD:Start()
	end
end

--[[
--TODO, verify consistency in this
"<214.6 21:21:15> [CLEU] SPELL_CAST_SUCCESS#false#0xF13104D400005C84#Beast of Jade#2632#0#0x0400000001D0EE70#Moonianna#1298#0#131209#Jade Pounce#1", -- [1924]
"<229.2 21:21:30> [CLEU] SPELL_AURA_APPLIED#false#0xF13104D400005C84#Beast of Jade#68168#0#0xF13104D400005C84#Beast of Jade#68168#0#119364#Jade Statue#8#BUFF#10#10000000", -- [2082]
function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 131209 then

	end
end
--]]

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 62637 then--Cursed Brew
		timerBrewBubbleCD:Cancel()
	elseif cid == 66772 then--Beast of Jade
		timerJadeStatueCD:Cancel()
	elseif cid == 61156 then--Vengeful Hui
		timerSummonSeedlingsCD:Cancel()
	end
end
