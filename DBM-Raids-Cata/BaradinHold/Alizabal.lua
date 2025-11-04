local mod	= DBM:NewMod(339, "DBM-Raids-Cata", 6, 74)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25"

mod:SetRevision("20250226220543")
mod:SetCreatureID(55869)
mod:SetEncounterID(1332)
--mod:SetModelSound("sound\\CREATURE\\ALIZABAL\\VO_BH_ALIZABAL_INTRO_01.OGG", "sound\\CREATURE\\ALIZABAL\\VO_BH_ALIZABAL_RESET_01.OGG")
mod:SetZone(757)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 104936 105067 105784",
	"SPELL_AURA_REMOVED 105784 104936"
)

local warnSeethingHate			= mod:NewTargetAnnounce(105067, 3)

local specWarnBladeDance		= mod:NewSpecialWarningRun(104995, nil, nil, nil, 4, 2)
local specWarnSkewer			= mod:NewSpecialWarningTaunt(104936, nil, nil, nil, 1, 2)
local specWarnSeethingHate		= mod:NewSpecialWarningSoak(105067, nil, nil, nil, 1, 2)

local timerBladeDance			= mod:NewBuffActiveTimer(15, 104995, nil, nil, nil, 6)
local timerBladeDanceCD			= mod:NewCDTimer(60, 104995, nil, nil, nil, 6)
local timerFirstSpecial			= mod:NewTimer(8, "TimerFirstSpecial", "136116")--Whether she casts skewer or seething after a blade dance is random. This generic timer just gives you a timer for whichever she'll do.
local timerSkewer				= mod:NewTargetTimer(8, 104936, nil, false, 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSkewerCD				= mod:NewNextTimer(20.5, 104936, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerSeethingHateCD		= mod:NewNextTimer(20.5, 105067, nil, nil, nil, 3)

local berserkTimer				= mod:NewBerserkTimer(300)

mod.vb.firstspecial = false
mod.vb.firstskewer = true
mod.vb.firstseething = true
mod.vb.bladeCasts = 0

function mod:OnCombatStart(delay)
	self.vb.firstspecial = false
	self.vb.firstskewer = true
	self.vb.firstseething = true
	self.vb.bladeCasts = 0
	timerFirstSpecial:Start(5.5-delay)
	timerBladeDanceCD:Start(26-delay) -- first blade dance variables 26~40 sec (sigh blizz sucks, it was always 35 on PTR)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 104936 then
		if not self.vb.firstspecial then--First special ability used after a blade dance, so the OTHER special is going to be cast in 8 seconds.
			timerFirstSpecial:Cancel()
			timerSeethingHateCD:Start(8)
			self.vb.firstspecial = true
		end
		if not self.vb.firstskewer then--First cast after blade dance, so there will be a 2nd cast in 20 seconds.
			timerSkewerCD:Start()
			self.vb.firstskewer = true
		end
		timerSkewer:Start(args.destName)
		if not args:IsPlayer() then
			specWarnSkewer:Show(args.destName)
			specWarnSkewer:Play("tauntboss")
		end
	elseif args.spellId == 105067 then--10m ID confirmed
		if not self.vb.firstspecial then--First special ability used after a blade dance, so the OTHER special is going to be cast in 8 seconds.
			timerFirstSpecial:Cancel()
			timerSkewerCD:Start(8)
			self.vb.firstspecial = true
		end
		if not self.vb.firstseething then--First cast after blade dance, so there will be a 2nd cast in 20 seconds.
			timerSeethingHateCD:Start()
			self.vb.firstseething = true
		end
		if args:IsPlayer() then
			specWarnSeethingHate:Show()
			specWarnSeethingHate:Play("gathershare")
		else
			warnSeethingHate:Show(args.destName)
		end
	elseif args.spellId == 105784 then--It seems the cast ID was disabled on live, so now gotta do this the dumb way.
		self.vb.bladeCasts = self.vb.bladeCasts + 1
		if self.vb.bladeCasts > 1 then return end
		specWarnBladeDance:Show()
		specWarnBladeDance:Play("justrun")
		timerBladeDance:Start()
		timerBladeDanceCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 105784 and self:IsInCombat() then
		if self.vb.bladeCasts < 3 then return end
		self.vb.firstspecial = false
		self.vb.firstskewer = false
		self.vb.firstseething = false
		self.vb.bladeCasts = 0
		timerBladeDance:Cancel()
		timerFirstSpecial:Start()
	elseif args.spellId == 104936 then
		timerSkewer:Cancel(args.destName)
	end
end
