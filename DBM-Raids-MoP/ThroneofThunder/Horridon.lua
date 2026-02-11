local mod	= DBM:NewMod(819, "DBM-Raids-MoP", 2, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20260126031700")
mod:SetCreatureID(68476)
mod:SetEncounterID(1575)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 1)
mod:SetZone(1098)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 136741 136770 137458 136587",
	"SPELL_CAST_SUCCESS 136797",
	"SPELL_AURA_APPLIED 136767 136817 138621 137327 137240 136840 136465 140946 136512 136821 137237 136480",
	"SPELL_AURA_APPLIED_DOSE 136767 136817 137240",
	"SPELL_AURA_REMOVED 136767",
	"SPELL_DAMAGE 136723 136646 136573 136490",
	"SPELL_MISSED 136723 136646 136573 136490",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

--[[
TODO: See if this has some target scanning. On heroic these can one shot non tanks
"<431.7 15:32:55> [CLEU] SPELL_CAST_SUCCESS#false#0xF1310E38000020EE#Amani'shi Beast Shaman#2632#128##Unknown#-2147483648#-2147483648#136487#Lightning Nova Totem#1", -- [67956]
"<431.7 15:32:55> [CLEU] SPELL_SUMMON#false#0xF1310E38000020EE#Amani'shi Beast Shaman#2632#128#0xF1310E5F00002779#Lightning Nova Totem#2600#0#136487#Lightning Nova Totem#1", -- [67957]
--]]
local warnCharge				= mod:NewTargetNoFilterAnnounce(136769, 4)
local warnPuncture				= mod:NewStackAnnounce(136767, 2, nil, "Tank|Healer")
local warnAdds					= mod:NewAnnounce("warnAdds", 2, 43712)--Some random troll icon
local warnOrbofControl			= mod:NewAnnounce("warnOrbofControl", 4, "134333")
local warnCrackedShell			= mod:NewStackAnnounce(137240, 2)
local warnBestialCry			= mod:NewStackAnnounce(136817, 3)
local warnRampage				= mod:NewTargetNoFilterAnnounce(136821, 4, nil, "Tank|Healer")
local warnDireFixate			= mod:NewTargetAnnounce(140946, 4)

local specWarnCharge			= mod:NewSpecialWarningYou(136769, nil, nil, nil, 1, 2)--Maybe add a near warning later. person does have 3.4 seconds to react though and just move out of group.
local yellCharge				= mod:NewShortYell(136769)
local specWarnDoubleSwipe		= mod:NewSpecialWarningDodge(136741, nil, nil, nil, 2, 2)
local specWarnPuncture			= mod:NewSpecialWarningStack(136767, nil, 9, nil, nil, 1, 6)--9 seems like a good number, we'll start with that. Timing wise the swap typically comes when switching gates though.
local specWarnPunctureOther		= mod:NewSpecialWarningTaunt(136767, nil, nil, nil, 1, 2)
local specWarnGTFO				= mod:NewSpecialWarningGTFO(136723, nil, nil, nil, 1, 8)
local specWarnDino				= mod:NewSpecialWarningSwitch(-7086, "-Healer", nil, nil, 1, 2)
local specWarnMending			= mod:NewSpecialWarningInterrupt(136797, "-Healer", nil, nil, 1, 2)--High priority interrupt. All dps needs warning because boss heals 1% per second it's not interrupted.
local specWarnOrbofControl		= mod:NewSpecialWarning("specWarnOrbofControl", false, nil, nil, 1, 17)--Usually an assigned role for 1-2 people. Do not want someone assigned to interrupts for example hear this and think it's interrupt time. This should be turned on by orb person
local specWarnVenomBolt			= mod:NewSpecialWarningInterrupt(136587, nil, nil, nil, 1, 2)--Can be on for all since it only triggers off target/focus
local specWarnChainLightning	= mod:NewSpecialWarningInterrupt(136480, nil, nil, nil, 1, 2)--Can be on for all since it only triggers off target/focus
local specWarnFireball			= mod:NewSpecialWarningInterrupt(136465, nil, nil, nil, 1, 2)--Can be on for all since it only triggers off target/focus
local specWarnHex				= mod:NewSpecialWarningYou(136512, nil, nil, nil, 1, 17)
local specWarnJalak				= mod:NewSpecialWarningSwitch(-7087, "Tank", nil, nil, 1, 2)--To pick him up (and maybe dps to switch, depending on strat)
local specWarnDireCall			= mod:NewSpecialWarningCount(137458, nil, nil, nil, 2, 2, 3)--Heroic
local specWarnDireFixate		= mod:NewSpecialWarningRun(140946, nil, nil, nil, 4, 2, 3)--Heroic

local timerDoor					= mod:NewTimer(113.5, "timerDoor", 2457, nil, nil, 6)
local timerAdds					= mod:NewTimer(18.91, "timerAdds", 43712, nil, nil, 1)
local timerDinoCD				= mod:NewNextTimer(18.9, -7086, nil, nil, nil, 1, 137237)
local timerCharge				= mod:NewCastTimer(3.4, 136769)
local timerChargeCD				= mod:NewCDTimer(50, 136769, nil, nil, nil, 3)--50-60 second depending on i he's casting other stuff or stunned
local timerDoubleSwipeCD		= mod:NewCDTimer(16.5, 136741)--16.5 second cd unless delayed by a charge triggered double swipe, then it's extended by failsafe code
local timerPuncture				= mod:NewTargetTimer(90, 136767, nil, false, 2)
local timerPunctureCD			= mod:NewCDTimer(10.5, 136767, nil, "Tank|Healer", nil, 5)
local timerJalakCD				= mod:NewNextTimer(10, -7087, nil, nil, nil, 1, 2457)--Maybe it's time for a better worded spawn timer than "Next mobname". Maybe NewSpawnTimer with "mobname activates" or something.
local timerBestialCryCD			= mod:NewNextCountTimer(10, 136817, nil, nil, nil, 2)
local timerDireCallCD			= mod:NewCDCountTimer(60.4, 137458, nil, nil, nil, 2)--Heroic (every 60.4-70 seconds)

local berserkTimer				= mod:NewBerserkTimer(720)

mod:AddSetIconOption("SetIconOnCharge", 136769, true, 0, {1})
mod:AddSetIconOption("SetIconOnAdds", nil, true, 5, {8, 7, 6, 5, 4, 3})

--local shamandead = 0
mod.vb.doorNumber = 0
mod.vb.direNumber = 0
mod.vb.jalakEngaged = false
local Farraki	= DBM:EJ_GetSectionInfo(7098)
local Gurubashi	= DBM:EJ_GetSectionInfo(7100)
local Drakkari	= DBM:EJ_GetSectionInfo(7103)
local Amani		= DBM:EJ_GetSectionInfo(7106)
local balcMobs = {
	[69164] = true,
	[69175] = true,
	[69176] = true,
	[69177] = true,
	[69178] = true,
	[69221] = 8,
}

function mod:OnCombatStart(delay)
--	shamandead = 0
	self.vb.doorNumber = 0
	self.vb.direNumber = 0
	self.vb.jalakEngaged = false
	timerPunctureCD:Start(10-delay)
	timerDoubleSwipeCD:Start(16-delay)--16-17 second variation
	timerDoor:Start(16.5-delay)
	timerChargeCD:Start(31-delay)--31-35sec variation
	berserkTimer:Start(-delay)
	if self:IsHeroic() then
		timerDireCallCD:Start(-delay, 1)
	end
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register here to prevent detecting first heads on pull before variables reset from first engage fire. We'll catch them on delayed engages fired couple seconds later
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

--[[
Back to backs, as expected
"<244.6 15:11:23> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [17383]
"<262.7 15:11:42> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [19036]
Delayed by Charge version
"<59.8 15:08:19> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [4747]
"<70.7 15:08:30> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136769#Charge#1", -- [5273]
"<74.8 15:08:34> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#68168#0##nil#-2147483648#-2147483648#136770#Double Swipe#1", -- [5452]
"<86.4 15:08:45> [CLEU] SPELL_CAST_START#false#0xF1310B7C0000383C#Horridon#2632#0##nil#-2147483648#-2147483648#136741#Double Swipe#1", -- [6003]
--]]
function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 136741 and self:AntiSpam(3, 5) then--Regular double swipe
		specWarnDoubleSwipe:Show()
		specWarnDoubleSwipe:Play("watchstep")
		--The only flaw is charge is sometimes delayed by unexpected events like using an orb, we may fail to start timer once in a while when it DOES come before a charge.
		if timerChargeCD:GetTime() < 32 then--Check if charge is less than 18 seconds away, if it is, double swipe is going to be delayed by quite a bit and we'll trigger timer after charge
			timerDoubleSwipeCD:Start()
		end
	elseif spellId == 136770 and self:AntiSpam(3, 5) then--Double swipe that follows a charge (136769)
		specWarnDoubleSwipe:Show()
		specWarnDoubleSwipe:Play("watchstep")
		timerDoubleSwipeCD:Start(6.2)--Hard coded failsafe. 136741 version is always 11 seconds after 136770 version (was 10.6)
	elseif spellId == 137458 then
		self.vb.direNumber = self.vb.direNumber + 1
		specWarnDireCall:Show(self.vb.direNumber)
		specWarnDireCall:Play("aesoon")
		timerDireCallCD:Start(nil, self.vb.direNumber+1)--CD still reset when he breaks a door?
	elseif spellId == 136587 then
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnVenomBolt:Show(args.sourceName)
			specWarnVenomBolt:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 136797 then
		specWarnMending:Show(args.sourceName)
		specWarnMending:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 136767 then
		local amount = args.amount or 1
		local threatamount = self:IsTrivial() and 21 or 9
		warnPuncture:Show(args.destName, amount)
		timerPuncture:Start(args.destName)
		timerPunctureCD:Start()
		if args:IsPlayer() then
			if amount >= threatamount then
				specWarnPuncture:Show(amount)
				specWarnPuncture:Play("stackhigh")
			end
		else
			if amount >= threatamount and not DBM:UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then--Other tank has at least one stack and you have none
				specWarnPunctureOther:Show(args.destName)--So nudge you to taunt it off other tank already.
				specWarnPunctureOther:Play("tauntboss")
			end
		end
	--"<317.2 15:12:36> [CLEU] SPELL_AURA_APPLIED_DOSE#false#0xF1310B7C0000383C#Horridon#68168#0#0xF1310B7C0000383C#Horridon#68168#0#137240#Cracked Shell#1#BUFF#4", -- [21950]
	--"<327.0 15:12:46> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Horridon#0xF1310B7C0000383C#elite#261178058#1#1#War-God Jalak <--War-God Jalak jumps down
	--He jumps down 10 seconds after 4th door is smashed, or when Horridon reaches 30%
	elseif spellId == 136817 then
		local amount = args.amount or 1
		warnBestialCry:Show(args.destName, amount)
		timerBestialCryCD:Start(10, amount+1)
	elseif spellId == 136821 then
		warnRampage:Show(args.destName)
	elseif spellId == 137237 then
		if self.Options.specWarnOrbofControl then
			specWarnOrbofControl:Show()
			specWarnOrbofControl:Play("useitem")
		else
			warnOrbofControl:Show()
		end
	elseif spellId == 137240 then
		warnCrackedShell:Show(args.destName, args.amount or 1)
	elseif spellId == 136480 then
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnChainLightning:Show(args.sourceName)
			specWarnChainLightning:Play("kickcast")
		end
	elseif spellId == 136465 then
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			specWarnFireball:Show(args.sourceName)
			specWarnFireball:Play("kickcast")
		end
	elseif spellId == 140946 then
		warnDireFixate:CombinedShow(1.0, args.destName)
		if args:IsPlayer() then
			specWarnDireFixate:Show()
			specWarnDireFixate:Play("justrun")
		end
	elseif spellId == 136512 and args:IsPlayer() then
		specWarnHex:Show()
		specWarnHex:Play("debuffyou")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 136767 then
		timerPuncture:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 136723 or spellId == 136646 or spellId == 136573 or spellId == 136490) and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE


--"<372.2 21:39:53> [RAID_BOSS_EMOTE] RAID_BOSS_EMOTE#Amani forces pour from the Amani Tribal Door!#War-God Jalak#0#false", -- [77469]
--"<515.3 21:42:16> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Horridon#0xF1310B7C0000467C#elite#522686397#1#1#War-God Jalak
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event)
	if UnitExists("boss2") and self:GetCIDFromGUID(UnitGUID("boss2")) == 69374 and not self.vb.jalakEngaged then--Jalak is jumping down
		self.vb.jalakEngaged = true--Set this so we know not to concern with 4th door anymore (plus so we don't fire extra warnings when we wipe and ENGAGE fires more)
		timerJalakCD:Cancel()
		specWarnJalak:Show()
		specWarnJalak:Play("bigmob")
		timerBestialCryCD:Start(5, 1)
		self:UnregisterShortTermEvents()--TODO, maybe add unit health checks to warn dog is close to 40% if we aren't done with doors yet. If it's added, we can unregister health here as well
	end
end

local function addsDelay(addsType)
	timerAdds:Start(18.9, addsType)
	warnAdds:Schedule(18.9, addsType)
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find(L.chargeTarget) then
		self:SendSync("ChargeTo", target)
	elseif msg:find(L.newForces, 1, true) then
		self:SendSync("Door")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 69374 then
		timerBestialCryCD:Cancel()
--	elseif cid == 69176 then--shaman
--		shamandead = shamandead + 1
--		if shamandead == 3 then
--		end
	end
end

function mod:OnSync(msg, targetname)
	if msg == "ChargeTo" and targetname and self:AntiSpam(5, 4) then
		local target = DBM:GetUnitFullName(targetname)
		if target then
			timerDoubleSwipeCD:Cancel()
			timerCharge:Start()
			timerChargeCD:Start()
			if target == UnitName("player") then
				specWarnCharge:Show()
				specWarnCharge:Play("chargemove")
				yellCharge:Yell()
			else
				warnCharge:Show(target)
			end
			if UnitExists(target) and self.Options.SetIconOnCharge then
				self:SetIcon(target, 1, 5)--star
			end
		end
	elseif msg == "Door" and self:AntiSpam(15, 3) then--prevent bad doorNumber increase if very late sync received. (60 too high, breaks first door warnings after a quick wipe recovery since antispam carries over from previous pull)
	--Doors spawn every 131.5 seconds
	--Halfway through it (literlaly exact center) Dinomancers spawn at 56.75
	--Then, before the dinomancer, lesser adds spawn twice splitting that timer into 3rds
	--So it goes, door, 18.91 seconds later, 1 add jumps down. 18.91 seconds later, next 2 drop down. 18.91 seconds later, dinomancer drops down, then 56.75 seconds later, next door starts.
		self.vb.doorNumber = self.vb.doorNumber + 1
		timerDinoCD:Schedule(37.8)
		specWarnDino:Schedule(56.75)
		specWarnDino:ScheduleVoice(56.75, "killmob")
		if self.Options.SetIconOnAdds then
			self:ScanForMobs(69221, 0, 7, 6, balcMobs, 64)
		end
		if self.vb.doorNumber == 1 then
			timerAdds:Start(18.9, Farraki)
			warnAdds:Schedule(18.9, Farraki)
			self:Schedule(18.9, addsDelay, Farraki)
		elseif self.vb.doorNumber == 2 then
			timerAdds:Start(18.9, Gurubashi)
			warnAdds:Schedule(18.9, Gurubashi)
			self:Schedule(18.9, addsDelay, Gurubashi)
		elseif self.vb.doorNumber == 3 then
			timerAdds:Start(18.91, Drakkari)
			warnAdds:Schedule(18.9, Drakkari)
			self:Schedule(18.9, addsDelay, Drakkari)
		elseif self.vb.doorNumber == 4 then
			timerAdds:Start(18.9, Amani)
			warnAdds:Schedule(18.9, Amani)
			self:Schedule(18.9, addsDelay, Amani)
		end
		if self.vb.doorNumber < 4 then
			timerDoor:Start()
		else
			if not self.vb.jalakEngaged then
				timerJalakCD:Start(143)
			end
		end
	end
end
