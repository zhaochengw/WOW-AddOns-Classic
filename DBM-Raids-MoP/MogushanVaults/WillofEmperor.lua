local mod	= DBM:NewMod(677, "DBM-Raids-MoP", 5, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103134004")
mod:SetCreatureID(60399, 60400)--60396 (Rage), 60397 (Strength), 60398 (Courage), 60480 (Titan Spark), 60399 (Qin-xi), 60400 (Jan-xi)
mod:SetEncounterID(1407)
mod:SetZone(1008)

mod:RegisterCombat("emote", L.Pull)
mod:SetMinCombatTime(25)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 116525 116778 116829",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 target focus",--Target and focus needed for Focused smash used by the big adds
	"UNIT_POWER_UPDATE boss1 boss2"
)

mod:RegisterEvents(
	"RAID_BOSS_EMOTE"
)

--Rage
local warnRageActivated			= mod:NewCountAnnounce(-5678, 3, 116525)
--Strength
local warnStrengthActivated		= mod:NewCountAnnounce(-5677, 3, 116550)
local warnEnergizingSmash		= mod:NewSpellAnnounce(116550, 3, nil, "Melee")--Also might be spammy
--Courage
local warnCourageActivated		= mod:NewCountAnnounce(-5676, 3, 116778)
local warnFocusedDefense		= mod:NewTargetAnnounce(116778, 4)
--Jan-xi and Qin-xi
local warnBossesActivatedSoon	= mod:NewPreWarnAnnounce(-5726, 10, 3, 116815)
local warnBossesActivated		= mod:NewSpellAnnounce(-5726, 3, 116815)
local warnArcLeft				= mod:NewCountAnnounce(116968, 4, 89570)--This is a pre warn, gives you time to move
local warnArcRight				= mod:NewCountAnnounce(116971, 4, 87219)--This is a pre warn, gives you time to move
local warnArcCenter				= mod:NewCountAnnounce(116972, 4, 74922)--This is a pre warn, gives you time to move
local warnStomp					= mod:NewCountAnnounce(116969, 4)--This is NOT a pre warn, only fires when stomp ends cast. :(
local warnTitanGas				= mod:NewCountAnnounce(116779, 3)

--Rage
local specWarnFocusedAssault	= mod:NewSpecialWarningYou(116525, false, nil, nil, 1, 2)--off by default do to sheer number of these mobs
--Strength
local specWarnStrengthActivated	= mod:NewSpecialWarningCount(-5677, "Tank", nil, nil, 1, 2)--These still need to be tanked. so give tanks special warning when these spawn, and dps can enable it too depending on dps strat.
--Courage
local specWarnCourageActivated	= mod:NewSpecialWarningSwitchCount(-5676, "Dps", nil, nil, 1, 2)--These really need to die asap. If they reach the tank, you will have a dead tank on hands very soon after.
local specWarnFocusedDefense	= mod:NewSpecialWarningYou(116778, nil, nil, nil, 1, 2)--On by default since less of these and they are stronger
--Sparks (Heroic Only)
local specWarnFocusedEnergy		= mod:NewSpecialWarningYou(116829, nil, nil, nil, 1, 2, 3)
--Jan-xi and Qin-xi
local specWarnBossesActivated	= mod:NewSpecialWarningSwitch(-5726, "Tank", nil, nil, 1, 2)
local specWarnCombo				= mod:NewSpecialWarningTarget(-5672, nil, nil, nil, 2, 2)

--Rage
local timerRageActivates		= mod:NewNextCountTimer(30, -5678, nil, nil, nil, 1, 116525)
--Strength
local timerStrengthActivates	= mod:NewNextCountTimer(50, -5677, nil, nil, nil, 1, 116550, DBM_COMMON_L.TANK_ICON)--It's actually 50-55 variation but 50 is good enough.
--Courage
local timerCourageActivates		= mod:NewNextCountTimer(100, -5676, nil, nil, nil, 1, 116778, DBM_COMMON_L.DAMAGE_ICON)
--Jan-xi and Qin-xi
local timerBossesActivates		= mod:NewNextTimer(107, -5726, nil, nil, nil, 1, 116815)--Might be a little funny sounding "Next Jan-xi and Qin-xi" May just localize it later.
local timerTitanGas				= mod:NewBuffActiveTimer(30, 116779, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON..DBM_COMMON_L.TANK_ICON)
local timerTitanGasCD			= mod:NewNextCountTimer(150, 116779, nil, nil, nil, 6)
local timerComboCD				= mod:NewNextTimer(20, -5672, nil, nil, nil, 3)

local berserkTimer				= mod:NewBerserkTimer(780)

mod:AddBoolOption("CountOutCombo")
mod:AddInfoFrameOption(116525, false)
mod:AddBoolOption("ArrowOnCombo", "Tank")--Very accurate for tank, everyone else not so much (tanks always in front, and boss always faces tank, so if he spins around on you, you expect it, melee on other hand have backwards arrows if you spun him around.

--Upvales, don't need variables
local focusedAssault = DBM:GetSpellName(116525)
local UnitIsUnit = UnitIsUnit
--Important, needs recover
mod.vb.boss1ComboCount = 0
mod.vb.boss2ComboCount = 0
mod.vb.titanGasCast = 0
mod.vb.courageCount = 0
mod.vb.strengthCount = 0
mod.vb.rageCount = 0
mod.vb.prevBoss1Power = 0
mod.vb.prevBoss2Power = 0

--NOTE, spawns are altered when they are rapidly killed on retail
--[[local rageTimers = {
	[0] = 15.6,--Varies from heroic vs normal, number here doesn't matter though, we don't start this on pull we start it off first yell (which does always happen).
	[1] = 33,
	[2] = 33,
	[3] = 24.3,--Confirmed lower than rest for some reason, seen it multiple times now
	[4] = 33,
	[5] = 33,
	[6] = 83,
	[7] = 33,--15.5?
	[8] = 33,
	[9] = 83,
	[10]= 33,
	[11]= 33,
	[12]= 83,
--Rest are all 33
--timers variate slightly so never will be perfect but trying to get as close as possible. seem same in all modes.
}--]]

local function addsDelay(self, add)
	if add == "Courage" then
		self.vb.courageCount = self.vb.courageCount + 1
		if self.Options[specWarnCourageActivated.option] then
			specWarnCourageActivated:Show(self.vb.courageCount)
			specWarnCourageActivated:Play("killmob")
		else
			warnCourageActivated:Show(self.vb.courageCount)
		end
		--Titan gases delay spawns by 50 seconds, even on heroic (even though there is no actual gas phase, the timing stays same on heroic)
		if self.vb.courageCount >= 2 then
			timerCourageActivates:Start(145.6, self.vb.courageCount+1)
		else
			timerCourageActivates:Start(100, self.vb.courageCount+1)
		end
	elseif add == "Strength" then
		self.vb.strengthCount = self.vb.strengthCount + 1
		if self.Options[specWarnStrengthActivated.option] then
			specWarnStrengthActivated:Show(self.vb.strengthCount)
			specWarnStrengthActivated:Play("targetchange")
		else
			warnStrengthActivated:Show(self.vb.strengthCount)
		end
		--Titan gases delay spawns by 50 seconds, even on heroic (even though there is no actual gas phase, the timing stays same on heroic)
		if self.vb.strengthCount == 4 or self.vb.strengthCount == 6 or self.vb.strengthCount == 8 then--Unverified
			timerStrengthActivates:Start(95.7, self.vb.strengthCount+1)
		else
			timerStrengthActivates:Start(48.8, self.vb.strengthCount+1)
		end
	elseif add == "Rage" then
		self.vb.rageCount = self.vb.rageCount + 1
		warnRageActivated:Show(self.vb.rageCount)
		--Titan gas delay has funny interaction with these and causes 30 or 60 second delays. Pretty much have to use a table.
--		local timer = rageTimers[self.vb.rageCount] or 33
--		timerRageActivates:Start(timer, self.vb.rageCount+1)
--		self:Schedule(timer, addsDelay, self, "Rage")--Because he doesn't always yell, schedule next one here as a failsafe
	elseif add == "Boss" then
		if self.Options[specWarnBossesActivated.option] then
			specWarnBossesActivated:Show()
			specWarnBossesActivated:Play("targetchange")
		else
			warnBossesActivated:Show()
		end
		timerComboCD:Start()
		if not self:IsHeroic() then
			timerTitanGasCD:Start(113, 1)
		end
	end
end


function mod:OnCombatStart(delay)
	self.vb.boss1ComboCount = 0
	self.vb.boss2ComboCount = 0
	self.vb.titanGasCast = 0
	self.vb.rageCount = 0
	self.vb.strengthCount = 0
	self.vb.courageCount = 0
	self.vb.prevBoss1Power = 0
	self.vb.prevBoss2Power = 0
	if self:IsHeroic() then--Heroic trigger is shorter, everything comes about 6 seconds earlier
		timerStrengthActivates:Start(35-delay, 1)
		timerCourageActivates:Start(69-delay, 1)
		timerBossesActivates:Start(101-delay)
	else
		timerStrengthActivates:Start(41.4-delay, 1)
		timerCourageActivates:Start(75-delay, 1)
		timerBossesActivates:Start(-delay)
	end
	berserkTimer:Start(-delay)
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(focusedAssault)
		DBM.InfoFrame:Show(10, "playerbaddebuff", focusedAssault)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.ArrowOnCombo then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 116525 then
		if args:IsPlayer() then
			specWarnFocusedAssault:Show()
			specWarnFocusedAssault:Play("targetyou")
		end
	elseif spellId == 116778 then
		if args:IsPlayer() then
			specWarnFocusedDefense:Show()
			specWarnFocusedDefense:Play("targetyou")
		else
			warnFocusedDefense:Show(args.destName)
		end
	elseif spellId == 116829 then
--		warnFocusedEnergy:Show(args.destName)
		if args:IsPlayer() then
			specWarnFocusedEnergy:Show()
			specWarnFocusedEnergy:Play("targetyou")
		end
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Rage or msg:find(L.Rage) then--Apparently boss only yells sometimes, so this isn't completely reliable
		self:Unschedule(addsDelay, self, "Rage")--Unschedule any failsafes that triggered and resync to yell
		self:Schedule(14, addsDelay, self, "Rage")
		timerRageActivates:Start(14, self.vb.rageCount+1)
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Strength or msg:find(L.Strength) then
		self:Unschedule(addsDelay, self, "Strength")
		self:Schedule(9, addsDelay, self, "Strength")
	elseif msg == L.Courage or msg:find(L.Courage) then
		self:Unschedule(addsDelay, self, "Courage")
		self:Schedule(10, addsDelay, self, "Courage")
	elseif msg == L.Boss or msg:find(L.Boss) then
		warnBossesActivatedSoon:Show()
		self:Schedule(10, addsDelay, self, "Boss")
	elseif msg:find("spell:116779") then
		if self:IsHeroic() then--On heroic the boss activates this perminantly on pull and it's always present
			if not self:IsInCombat() then
				DBM:StartCombat(self, 0)
			end
		else--Normal/LFR
			self.vb.titanGasCast = self.vb.titanGasCast + 1
			warnTitanGas:Show(self.vb.titanGasCast)
			if self.vb.titanGasCast < 4 then -- after Titan Gas casted 4 times, Titan Gas lasts permanently. (soft enrage)
				timerTitanGas:Start()
				timerTitanGasCD:Start(150, self.vb.titanGasCast+1)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	--This event needs to scan focus and target
	if spellId == 116556 and self:AntiSpam(3, 1) then
		warnEnergizingSmash:Show()
	--This event we only want boss1 and boss2
	elseif (uId == "boss1" or uId == "boss2") and (spellId == 116968 or spellId == 116971 or spellId == 116972 or spellId == 116969 or spellId == 132425) then
		local warnPlayer, warnedCount = false, 0
		--Caster is players current target, or current target's target (ie healer healing someone on that target)
		if UnitIsUnit(uId, "target") or UnitIsUnit(uId, "targettarget") then
			warnPlayer = true
		end
		if uId == "boss1" then
			self.vb.boss1ComboCount = self.vb.boss1ComboCount + 1
			if warnPlayer then
				warnedCount = self.vb.boss1ComboCount
				if self.Options.CountOutCombo and self.vb.boss1ComboCount < 11 then
					DBM:PlayCountSound(self.vb.boss1ComboCount)
				end
			end
		else
			self.vb.boss2ComboCount = self.vb.boss2ComboCount + 1
			if warnPlayer then
				warnedCount = self.vb.boss2ComboCount
				if self.Options.CountOutCombo and self.vb.boss2ComboCount < 11 then
					DBM:PlayCountSound(self.vb.boss2ComboCount)
				end
			end
		end
		if warnPlayer then
			if spellId == 116968 then--Arc Left
				warnArcLeft:Show(warnedCount)
				if self.Options.ArrowOnCombo then
					if self:IsTank() then--Assume tank is in front of the boss
						DBM.Arrow:ShowStatic(90, 3)
					else--Assume anyone else is behind the boss
						DBM.Arrow:ShowStatic(270, 3)
					end
				end
			elseif spellId == 116971 then--Arc Right
				warnArcRight:Show(warnedCount)
				if self.Options.ArrowOnCombo then
					if self:IsTank() then--Assume tank is in front of the boss
						DBM.Arrow:ShowStatic(270, 3)
					else--Assume anyone else is behind the boss
						DBM.Arrow:ShowStatic(90, 3)
					end
				end
			elseif spellId == 116972 then--Arc Center
				warnArcCenter:Show(warnedCount)
				if self.Options.ArrowOnCombo then
					if self:IsTank() then--Assume tank is in front of the boss
						DBM.Arrow:ShowStatic(0, 3)
					end
				end
			elseif spellId == 116969 or spellId == 132425 then--Stomp
				warnStomp:Show(warnedCount)
			end
		end
	end
end

do
	--On 10.2.7 it seems to be 100 based power now not 20 based like OG mop or 2 based like bugged 10.2.6 and previous.
	--"<141.70 23:20:55> [UNIT_POWER_UPDATE] boss2#Jan-xi#TYPE:ENERGY/3#MAIN:0/100#ALT:0/0",
	--"<162.94 23:21:16> [UNIT_POWER_UPDATE] boss2#Jan-xi#TYPE:ENERGY/3#MAIN:100/100#ALT:0/0",
	local warned = {}
	function mod:UNIT_POWER_UPDATE(uId)
		local powerLevel = UnitPower(uId)
		if UnitIsUnit(uId, "target") or UnitIsUnit(uId, "targettarget") then
			if not warned[uId] and powerLevel >= 85 then--Give more than 1 second to find comboMob
				warned[uId] = true
				specWarnCombo:Show(UnitName(uId))
				specWarnCombo:Play("specialsoon")
			end
		end
		if warned[uId] and powerLevel < 10 then
			warned[uId] = false
			timerComboCD:Start()
			if uId == "boss1" then
				self.vb.boss1ComboCount = 0
			else
				self.vb.boss2ComboCount = 0
			end
		end
	end
end
