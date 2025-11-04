local mod	= DBM:NewMod("d652", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241118070307")
mod:SetZone(1099)

mod:RegisterCombat("scenario", 1099)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 141438 141327 141187 136473",
	"SPELL_CAST_SUCCESS 141438",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

--Lieutenant Fizzel
local warnThrowBomb				= mod:NewSpellAnnounce(132995, 3, nil, false)

--Lieutenant Drak'on
local specWarnSwashbuckling		= mod:NewSpecialWarningDefensive(141438, nil, nil, nil, 1, 2)
--Lieutenant Fizzel
local specWarnVolatileConcoction= mod:NewSpecialWarningRun(141327, nil, nil, nil, 4, 2)
--Admiral Hagman
local specWarnVerticalSlash		= mod:NewSpecialWarningDefensive(141187, nil, nil, nil, 1, 12)
local specWarnCounterShot		= mod:NewSpecialWarningCast(136473, "SpellCaster", nil, nil, 1, 2)

--Lieutenant Drak'on
local timerSwashbucklingCD		= mod:NewCDTimer(16, 141438, nil, nil, nil, 5)
--Lieutenant Fizzel
local timerThrowBombCD			= mod:NewCDTimer(6, 132995, nil, false, nil, 3)
--Admiral Hagman
local timerVerticalSlashCD		= mod:NewCDTimer(18, 141187, nil, nil, nil, 5)--18-20 second variation
local timerCounterShot			= mod:NewCastTimer(1.5, 136473, nil, nil, nil, 2)

function mod:SPELL_CAST_START(args)
	if args.spellId == 141438 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnSwashbuckling:Show()
			specWarnSwashbuckling:Play("defensive")
		end
	elseif args.spellId == 141327 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnVolatileConcoction:Show()
			specWarnVolatileConcoction:Play("justrun")
		end
	elseif args.spellId == 141187 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnVerticalSlash:Show()
			specWarnVerticalSlash:Play("useextraaction")
		end
		timerVerticalSlashCD:Start()
	elseif args.spellId == 136473 then
		specWarnCounterShot:Show()
		specWarnCounterShot:Play("stopcast")
		timerCounterShot:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 141438 then
		timerSwashbucklingCD:Start(15)--Only goes on CD if cast finishes, stun interrupts don't initiate CD
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 70963 then--Lieutenant Fizzel
		timerThrowBombCD:Cancel()
	elseif cid == 67391 then--Lieutenant Drak'on
		timerSwashbucklingCD:Cancel()
	elseif cid == 67426 then--Admiral Hagman
		timerVerticalSlashCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 132995 and self:AntiSpam() then
		self:SendSync("ThrowBomb")
	end
end

function mod:OnSync(msg)
	if msg == "ThrowBomb" then
		warnThrowBomb:Show()
		timerThrowBombCD:Start()
	end
end
