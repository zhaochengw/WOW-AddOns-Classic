local mod	= DBM:NewMod("d499", "DBM-Scenario-MoP")
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal"

mod:SetRevision("20241118070307")
mod:SetZone(1048)

mod:RegisterCombat("scenario", 1048)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 121934",
	"UNIT_SPELLCAST_SUCCEEDED target focus",
	"SCENARIO_UPDATE"
)

--Captain Ook
local warnOrange		= mod:NewSpellAnnounce(121895, 3)

--Captain Ook
--local timerOrangeCD		= mod:NewCDTimer(45, 121895)--Not good sample size, could be inaccurate

local timerKegRunner		= mod:NewAchievementTimer(240, 7232)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 121934 and self:AntiSpam(3, 1) then
		self:SendSync("Phase3")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 121895 and self:AntiSpam(3, 2) then
		self:SendSync("Orange")
	end
end

function mod:OnSync(msg)
	if msg == "Phase3" then
		timerKegRunner:Cancel()
--		timerOrangeCD:Start()
	elseif msg == "Orange" then
		warnOrange:Show()
	end
end

function mod:SCENARIO_UPDATE(newStep)
	local _, currentStage = C_Scenario.GetInfo()
	if currentStage == 2 then
		timerKegRunner:Start()
	end
end
