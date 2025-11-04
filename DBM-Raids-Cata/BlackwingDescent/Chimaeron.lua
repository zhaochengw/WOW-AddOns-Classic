local mod	= DBM:NewMod(172, "DBM-Raids-Cata", 5, 73)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241115112135")
mod:SetCreatureID(43296)
mod:SetEncounterID(1023)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetZone(669)
--mod:SetModelSound("Sound\\Creature\\Nefarian\\VO_BD_Nefarian_ChimaronIntro01.ogg", nil)
--Long: Ah, Chimaeron, truly a living testament to my scientific prowess. I reworked and twisted his form countless times over the years, and the final result is truly something to behold.
--Short: There isn't one

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 82848",
	"SPELL_CAST_SUCCESS 88872 82934",
	"SPELL_AURA_APPLIED 82881 88826 88853 82935",
	"SPELL_AURA_APPLIED_DOSE 82881",
	"SPELL_AURA_REFRESH 82881",
	"SPELL_AURA_REMOVED 88853 82881",
	"UNIT_HEALTH boss1"
)

local warnCausticSlime		= mod:NewTargetAnnounce(82935, 3)
local warnBreak				= mod:NewStackAnnounce(82881, 3, nil, "Tank|Healer")
local warnDoubleAttack		= mod:NewSpellAnnounce(88826, 4, nil, "Tank|Healer")
local warnFeud				= mod:NewSpellAnnounce(88872, 3)
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2, 3)
local warnPhase2			= mod:NewPhaseAnnounce(2)

local specWarnFailure		= mod:NewSpecialWarningCount(88853, nil, nil, nil, 3, 2)
local specWarnMassacre		= mod:NewSpecialWarningCount(82848, nil, nil, nil, 2, 2)
local specWarnDoubleAttack	= mod:NewSpecialWarningDefensive(88826, nil, nil, nil, 1, 2)

local timerBreak			= mod:NewTargetTimer(60, 82881, nil, nil, nil, 5)
local timerBreakCD			= mod:NewNextTimer(15, 82881, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON)--Also double attack CD
local timerMassacre			= mod:NewCastTimer(4, 82848, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerMassacreNext		= mod:NewNextTimer(30, 82848, nil, nil, nil, 2)
local timerCausticSlime		= mod:NewNextTimer(19, 82935, nil, nil, nil, 3)--always 19 seconds after massacre.
local timerFailure			= mod:NewBuffActiveTimer(26, 88853, nil, nil, nil, 6)
local timerFailureNext		= mod:NewNextCountTimer(25, 88853, nil, nil, nil, 6, nil, DBM_COMMON_L.DEADLY_ICON)

local berserkTimer			= mod:NewBerserkTimer(450)--Heroic

mod:AddSetIconOption("SetIconOnSlime", 82935, false, 7, {1, 2, 3, 4, 5, 6, 7, 8})
mod:AddInfoFrameOption(nil, "Healer")

mod.vb.prewarnedPhase2 = false
mod.vb.botOffline = false
mod.vb.massacreCast = 0
mod.vb.failureCount = 0

-- Chimaeron bots goes offline after massacre 2~3 cast. after 2 massacre casts if not bot goes offline, 3rd massacre cast 100% bot goes offline, this timer supports this.
local function failureCheck(self)
	if not self.vb.botOffline and self.vb.massacreCast >= 2 then
		timerFailureNext:Start(nil, self.vb.failureCount+1)
	end
end

function mod:OnCombatStart(delay)
	timerMassacreNext:Start(26-delay, 1)
	timerBreakCD:Start(4.5-delay)
	self.vb.prewarnedPhase2 = false
	self.vb.botOffline = false
	self.vb.massacreCast = 0
	self.vb.failureCount = 0
	self:SetStage(1)
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.HealthInfo)
		DBM.InfoFrame:Show(5, "health", 10000)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 82848 then
		self.vb.massacreCast = self.vb.massacreCast + 1
		specWarnMassacre:Show(self.vb.massacreCast)
		specWarnMassacre:Play("aesoon")
		timerMassacre:Start()
		timerMassacreNext:Start()
		timerCausticSlime:Start()--Always 19 seconds after massacre.
		timerBreakCD:Start(14)--Massacre resets break timer, although  usualy the CDs line up anyways, they won't for 3rd break.
		self:Schedule(5, failureCheck, self)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 88872 then
		warnFeud:Show()
	elseif args.spellId == 82934 then
		self:SetStage(2)
		warnPhase2:Show()
		timerCausticSlime:Cancel()
		timerMassacreNext:Cancel()
		timerFailureNext:Cancel()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 82881 then
		if self:GetStage(1) then
			warnBreak:Show(args.destName, args.amount or 1)
			timerBreak:Start(args.destName)
			timerBreakCD:Start()
		end
	elseif args.spellId == 88826 then
		if self:IsTanking("player", nil, nil, nil, args.destGUID) then--Basically, HAS to be bosses current target
			specWarnDoubleAttack:Show()
			specWarnDoubleAttack:Play("defensive")
		else
			warnDoubleAttack:Show()
		end
	elseif args.spellId == 88853 then
		self.vb.botOffline = true
		self.vb.massacreCast = 0
		self.vb.failureCount = self.vb.failureCount + 1
		specWarnFailure:Show(self.vb.failureCount)
		specWarnFailure:Play("stilldanger")
		timerFailure:Start()
	elseif not self.vb.botOffline and args.spellId == 82935 and args:IsDestTypePlayer() then
		warnCausticSlime:CombinedShow(0.5, args.destName)
		if self.Options.SetIconOnSlime then
			self:SetSortedIcon("roster", 0.5, args.destName, 1, 8)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REFRESH(args)
	if args.spellId == 82881 then--Once a tank is at 4 stacks, it just spell aura refreshes instead. Track this so we can keep an accurate CD and debuff timer.
		timerBreak:Start(args.destName)
		timerBreakCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 88853 then
		self.vb.botOffline = false
	elseif args.spellId == 82881 then
		timerBreak:Cancel(args.destName)
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 43296 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 40 and self.vb.prewarnedPhase2 then
			self.vb.prewarnedPhase2 = false
		elseif h > 22 and h < 25 and not self.vb.prewarnedPhase2 then
			self.vb.prewarnedPhase2 = true
			warnPhase2Soon:Show()
		end
	end
end
