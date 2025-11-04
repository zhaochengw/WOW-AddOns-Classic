local mod	= DBM:NewMod(687, "DBM-Raids-MoP", 5, 317)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103134004")
mod:SetCreatureID(60701, 60708, 60709, 60710)--Adds: 60731 Undying Shadow, 60958 Pinning Arrow
mod:SetEncounterID(1436)
mod:SetBossHPInfoToHighest()
mod:SetZone(1008)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 118162 117506 117628 117697 117833 117708 117948 117961",
	"SPELL_CAST_SUCCESS 117685 117506 117910",
	"SPELL_AURA_APPLIED 117539 117837 117756 117737 117697 118303 118135",
	"SPELL_AURA_REMOVED 118303",
	"SPELL_DAMAGE 117558 117921",
	"SPELL_MISSED 117558 117921",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL"
)

--on heroic 2 will be up at same time, so most announces are "target" type for source distinction.
--Unless it's a spell that doesn't directly affect the boss (ie summoning an add isn't applied to boss, it's a new mob).
local Zian = DBM:EJ_GetSectionInfo(5852)
local Meng = DBM:EJ_GetSectionInfo(5835)
local Qiang = DBM:EJ_GetSectionInfo(5841)
local Subetai = DBM:EJ_GetSectionInfo(5846)
--All
local warnActivated				= mod:NewTargetNoFilterAnnounce(118212, 3, 78740)
--Zian
mod:AddTimerLine(Zian)
local warnChargedShadows		= mod:NewTargetNoFilterAnnounce(117685, 2)
local warnUndyingShadows		= mod:NewSpellAnnounce(117506, 3)--Target scanning?
local warnFixate				= mod:NewTargetAnnounce(118303, 4)--Maybe spammy late fight, if zian is first boss you get? (adds are immortal, could be many up)
local warnShieldOfDarknessSoon	= mod:NewAnnounce("DarknessSoon", 4, 117697, nil, nil, true, 117697)

local specWarnFixate			= mod:NewSpecialWarningRun(118303, nil, nil, nil, 4, 2)
local yellFixate				= mod:NewYell(118303)
local specWarnCoalescingShadows	= mod:NewSpecialWarningGTFO(117558, nil, nil, nil, 1, 8)
local specWarnShadowBlast		= mod:NewSpecialWarningInterrupt(117628, "HasInterrupt", nil, nil, 1, 2)--very spammy. better to optional use
local specWarnShieldOfDarkness	= mod:NewSpecialWarningReflect(117697, nil, nil, nil, 3, 2, 3)--Heroic Ability
local specWarnShieldOfDarknessD	= mod:NewSpecialWarningDispel(117697, "MagicDispeller", nil, nil, 1, 2, 3)--Heroic Ability

local timerChargingShadowsCD	= mod:NewCDTimer(12, 117685, nil, nil, nil, 3)
local timerUndyingShadowsCD		= mod:NewCDTimer(41.5, 117506, nil, nil, nil, 1)--For most part it's right, but i also think on normal he can only summon a limited amount cause he did seem to skip one? leaving a CD for now until know for sure.
local timerFixate			  	= mod:NewTargetTimer(20, 118303, nil, false, 2, 5)
local timerUSRevive				= mod:NewTimer(60, "timerUSRevive", 117539, nil, nil, 1, nil, nil, nil, nil, nil, nil, nil, 117506)
local timerShieldOfDarknessCD  	= mod:NewNextTimer(42.5, 117697, nil, nil, nil, 5, nil, DBM_COMMON_L.HEROIC_ICON..DBM_COMMON_L.DEADLY_ICON, nil, 3, 5)
--Meng
mod:AddTimerLine(Meng)
local warnCrazed				= mod:NewTargetNoFilterAnnounce(117737, 3)--Basically stance change
local warnCowardice				= mod:NewTargetNoFilterAnnounce(117756, 3)--^^

local specWarnMaddeningShout	= mod:NewSpecialWarningSpell(117708, nil, nil, nil, 2, 2)
local specWarnCrazyThought		= mod:NewSpecialWarningInterrupt(117833, "HasInterrupt", nil, nil, 1, 2)--At discretion of whoever to enable. depending on strat, you may NOT want to interrupt these (or at least not all of them)
local specWarnDelirious			= mod:NewSpecialWarningDispel(117837, "RemoveEnrage|Tank", nil, nil, 1, 2)--Heroic Ability

local timerMaddeningShoutCD		= mod:NewCDTimer(47, 117708, nil, nil, nil, 3)--47-50 sec variation. So a CD timer instead of next.
local timerDeliriousCD			= mod:NewCDTimer(20.5, 117837, nil, "RemoveEnrage", nil, 5, nil, DBM_COMMON_L.HEROIC_ICON..DBM_COMMON_L.ENRAGE_ICON)
--Qiang
mod:AddTimerLine(Qiang)
local warnImperviousShieldSoon	= mod:NewPreWarnAnnounce(117961, 5, 3)--Less dangerous than Shield of darkness, doesn't need as much spam

local specWarnAnnihilate		= mod:NewSpecialWarningDodge(117948, nil, nil, nil, 2, 2)--Maybe tweak options later or add a bool for it, cause on heroic, it's not likely ranged will be in front of Qiang if Zian or Subetai are up.
local specWarnFlankingOrders	= mod:NewSpecialWarningDodge(117910, nil, nil, nil, 2, 2)
local specWarnImperviousShield	= mod:NewSpecialWarningDispel(117961, nil, nil, nil, 1, 2, 3)--Heroic Ability

local timerMassiveAttackCD		= mod:NewCDTimer(5, 117921, nil, nil, nil, 5)--This timer needed for all players to figure out Flanking Orders moves.
local timerAnnihilateCD			= mod:NewNextTimer(39, 117948, nil, nil, nil, 3)
local timerFlankingOrdersCD		= mod:NewCDTimer(40, 117910, nil, nil, nil, 3)--Every 40 seconds on normal, but on heroic it has a 40-50 second variation so has to be a CD bar instead of next
local timerImperviousShieldCD	= mod:NewCDTimer(42, 117961, nil, nil, nil, 5, nil, DBM_COMMON_L.HEROIC_ICON, nil, 1, 4)
--Subetai
mod:AddTimerLine(Subetai)
local warnPinnedDown			= mod:NewTargetAnnounce(118135, 4)--We warn for this one since it's more informative then warning for just Rain of Arrows
local warnPillage				= mod:NewTargetNoFilterAnnounce(118047, 3)

local specWarnVolley			= mod:NewSpecialWarningDodge(118094, nil, nil, nil, 2, 2)--118088 trigger ID, but we use the other ID cause it has a tooltip/icon
local specWarnPinningArrow		= mod:NewSpecialWarningSwitch(-5861, "Dps", nil, nil, 1, 2)
local specWarnPillage			= mod:NewSpecialWarningYou(118047, nil, nil, nil, 1, 2)--Works as both a You and near warning
local yellPillage				= mod:NewYell(118047)
local specWarnSleightOfHand		= mod:NewSpecialWarningTarget(118162, nil, nil, nil, 1, 3, 3)--Heroic Ability

local timerVolleyCD				= mod:NewNextTimer(39.9, 118094, nil, nil, nil, 3)
local timerRainOfArrowsCD		= mod:NewCDTimer(50.5, 118122, nil, nil, nil, 3)--heroic 41s fixed cd. normal and lfr 50.5~60.5 variable cd.
local timerPillageCD			= mod:NewNextTimer(41, 118047, nil, nil, nil, 3)
local timerSleightOfHandCD		= mod:NewCDTimer(42, 118162, nil, nil, nil, 5, nil, DBM_COMMON_L.HEROIC_ICON)

local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddRangeFrameOption(8, nil, "Ranged")--For multiple abilities. the abiliies don't seem to target melee (unless a ranged is too close or a melee is too far.)

mod.vb.ZianActive = false
mod.vb.MengActive = false
mod.vb.QiangActive = false
mod.vb.SubetaiActive = false
local bossesActivated = {}
local pinnedTargets = {}
local diedShadow = {}

local function warnPinnedDownTargets()
	warnPinnedDown:Show(table.concat(pinnedTargets, "<, >"))
	specWarnPinningArrow:Show()
	specWarnPinningArrow:Play("targetchange")
	table.wipe(pinnedTargets)
end

function mod:OnCombatStart(delay)
	table.wipe(bossesActivated)
	table.wipe(pinnedTargets)
	table.wipe(diedShadow)
	self.vb.ZianActive = false
	self.vb.MengActive = false
	self.vb.SubetaiActive = false
	self.vb.QiangActive = true
	berserkTimer:Start(-delay)
	timerAnnihilateCD:Start(10.5)
	timerFlankingOrdersCD:Start(16.9)--Old 25
	if self:IsHeroic() then
		timerImperviousShieldCD:Start(40.7)
		warnImperviousShieldSoon:Schedule(35.7)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 118162 then
		specWarnSleightOfHand:Show(args.sourceName)
		specWarnSleightOfHand:Play("crowdcontrol")
		timerSleightOfHandCD:Start()
	elseif spellId == 117506 then
		warnUndyingShadows:Show()
		timerUndyingShadowsCD:Start()--41.5
	elseif spellId == 117628 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnShadowBlast:Show(args.sourceName)
			specWarnShadowBlast:Play("kickcast")
		end
	elseif spellId == 117697 then
		specWarnShieldOfDarkness:Show(args.sourceName)
		specWarnShieldOfDarkness:Play("stopattack")
		warnShieldOfDarknessSoon:Schedule(37.5, 5)--Start pre warning with regular warnings only as you don't move at this point yet.
		warnShieldOfDarknessSoon:Schedule(38.5, 4)
		warnShieldOfDarknessSoon:Schedule(39.5, 3)
		warnShieldOfDarknessSoon:Schedule(40.5, 2)
		warnShieldOfDarknessSoon:Schedule(41.5, 1)
		timerShieldOfDarknessCD:Start()
	elseif spellId == 117833 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnCrazyThought:Show(args.sourceName)
			specWarnCrazyThought:Play("kickcast")
		end
	elseif spellId == 117708 then
		specWarnMaddeningShout:Show()
		specWarnMaddeningShout:Play("findmc")
		if self.vb.MengActive then
			timerMaddeningShoutCD:Start()
		else
			timerMaddeningShoutCD:Start(77)
		end
	elseif spellId == 117948 then
		specWarnAnnihilate:Show()
		specWarnAnnihilate:Play("shockwave")
		if self:IsHeroic() then
			timerAnnihilateCD:Start(32.5)
		else
			timerAnnihilateCD:Start()
		end
	elseif spellId == 117961 then
		specWarnImperviousShield:Show(args.sourceName)
		specWarnImperviousShield:Play("dispelboss")
		timerImperviousShieldCD:Start()
		if self:IsDifficulty("heroic10") then--Is this still different?
			warnImperviousShieldSoon:Schedule(57)
			timerImperviousShieldCD:Start(62)
		else
			warnImperviousShieldSoon:Schedule(37)
			timerImperviousShieldCD:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 117685 then
		warnChargedShadows:Show(args.destName)
		timerChargingShadowsCD:Start(10.7)
	elseif spellId == 117506 then
		warnUndyingShadows:Show()
		if self.vb.ZianActive then
			timerUndyingShadowsCD:Start()--41.5
		else
			timerUndyingShadowsCD:Start(85)
		end
	elseif spellId == 117910 then
		specWarnFlankingOrders:Show()
		specWarnFlankingOrders:Play("watchstep")
		if self.vb.QiangActive then
			timerFlankingOrdersCD:Start()--40
		else
			timerFlankingOrdersCD:Start(75)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 117539 and not diedShadow[args.destGUID] then--They only ressurrect once so only start timer once per GUID
		diedShadow[args.destGUID] = true
		timerUSRevive:Start(args.destGUID)--Basically, the rez timer for a defeated Undying Shadow that is going to re-animate in 60 seconds.
	elseif spellId == 117837 then
		specWarnDelirious:Show(args.destName)
		specWarnDelirious:Play("enrage")
		timerDeliriousCD:Start()
	elseif spellId == 117756 then
		warnCowardice:Show(args.destName)
	elseif spellId == 117737 then
		warnCrazed:Show(args.destName)
	elseif spellId == 117697 then
		specWarnShieldOfDarknessD:Show(args.destName)
		specWarnShieldOfDarknessD:Play("dispelboss")
	elseif spellId == 118303 then
		timerFixate:Start(args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			specWarnFixate:Play("justrun")
			yellFixate:Yell()
		else
			warnFixate:Show(args.destName)
		end
	elseif spellId == 118135 then
		pinnedTargets[#pinnedTargets + 1] = args.destName
		self:Unschedule(warnPinnedDownTargets)
		self:Schedule(0.3, warnPinnedDownTargets)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 118303 then
		timerFixate:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 117558 and destGUID == UnitGUID("player") and self:AntiSpam(3, 4) then
		specWarnCoalescingShadows:Show(spellName)
		specWarnCoalescingShadows:Play("watchfeet")
	elseif spellId == 117921 and self:AntiSpam(3, 5) then
		timerMassiveAttackCD:Start()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 118088 and self:AntiSpam(2, 1) then--Volley
		specWarnVolley:Show()
		specWarnVolley:Play("shockwave")
		timerVolleyCD:Start()
	elseif spellId == 118121 and self:AntiSpam(2, 2) then--Rain of Arrows
		if self:IsHeroic() then
			timerRainOfArrowsCD:Start(39.9)
		else
			timerRainOfArrowsCD:Start(50.5)
		end
--	"<63.5 21:23:16> [UNIT_SPELLCAST_SUCCEEDED] Qiang the Merciless [[boss1:Inactive Visual::0:118205]]", -- [14066]
--	"<63.5 21:23:16> [UNIT_SPELLCAST_SUCCEEDED] Qiang the Merciless [[boss1:Cancel Activation::0:118219]]", -- [14068]
	elseif spellId == 118205 and self:AntiSpam(2, 3) then--Inactive Visual
		local cid = self:GetUnitCreatureId(uId)
		if cid == 60701 then
			self.vb.ZianActive = false
			timerChargingShadowsCD:Cancel()
			timerShieldOfDarknessCD:Cancel()
			warnShieldOfDarknessSoon:Cancel()
			timerUndyingShadowsCD:Cancel()--Used to restart, but in 10.2.7 now fires instantly on becoming ghost
			if self.Options.RangeFrame and not self.vb.SubetaiActive then--Close range frame, but only if zian is also not active, otherwise we still need it
				DBM.RangeCheck:Hide()
			end
		elseif cid == 60708 then
			self.vb.MengActive = false
			timerDeliriousCD:Cancel()
			timerMaddeningShoutCD:Stop()
			timerMaddeningShoutCD:Start(30)--This boss retains Maddening Shout
		elseif cid == 60709 then
			self.vb.QiangActive = false
			timerMassiveAttackCD:Cancel()
			timerAnnihilateCD:Cancel()
			timerImperviousShieldCD:Cancel()
			warnImperviousShieldSoon:Cancel()
			timerFlankingOrdersCD:Cancel()--Used to restart to 30 remaining, but in 10.2.7 now fires instantly on becoming ghost
		elseif cid == 60710 then
			self.vb.SubetaiActive = false
			timerVolleyCD:Cancel()
			timerRainOfArrowsCD:Cancel()
			timerSleightOfHandCD:Cancel()
			timerPillageCD:Cancel()--Used to restart to 30 remaining, but in 10.2.7 now fires instantly on becoming ghost
			if self.Options.RangeFrame and not self.vb.ZianActive then--Close range frame, but only if subetai is also not active, otherwise we still need it
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:118047") and target then
		target = DBM:GetUnitFullName(target)
		if self.vb.SubetaiActive then
			timerPillageCD:Start()
		else
			timerPillageCD:Start(75)
		end
		if target then
			if target == UnitName("player") then
				specWarnPillage:Show()
				specWarnPillage:Play("targetyou")
				yellPillage:Yell()
			else
				warnPillage:Show(target)
			end
		end
	end
end

--Phase change controller. Even for pull.
function mod:CHAT_MSG_MONSTER_YELL(msg, boss)
	if not self:IsInCombat() or bossesActivated[boss] then return end--Ignore yells out of combat or from bosses we already activated.
	if not bossesActivated[boss] then bossesActivated[boss] = true end--Once we activate off bosses first yell, add them to ignore.
	if boss == Zian then
		warnActivated:Show(boss)
		self.vb.ZianActive = true
		timerChargingShadowsCD:Start(9.9)
		timerUndyingShadowsCD:Start(20)
		if self:IsHeroic() then
			warnShieldOfDarknessSoon:Schedule(35, 5)--Start pre warning with regular warnings only as you don't move at this point yet.
			warnShieldOfDarknessSoon:Schedule(36, 4)
			warnShieldOfDarknessSoon:Schedule(37, 3)
			warnShieldOfDarknessSoon:Schedule(38, 2)
			warnShieldOfDarknessSoon:Schedule(39, 1)
			timerShieldOfDarknessCD:Start(40)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	elseif boss == Meng then
		warnActivated:Show(boss)
		self.vb.MengActive = true
		if self:IsHeroic() then
			timerDeliriousCD:Start()
			timerMaddeningShoutCD:Start(40)--On heroic, he skips first cast as a failsafe unless you manage to kill it within 20 seconds. otherwise, first cast will actually be after about 40-45 seconds. Since this is VERY hard to do right now, lets just automatically skip it for now. Maybe find a better way to fix it later if it becomes a problem this expansion
		else
			timerMaddeningShoutCD:Start(20.5)
		end
	elseif boss == Qiang then
		warnActivated:Show(boss)
	elseif boss == Subetai then
		warnActivated:Show(boss)
		self.vb.SubetaiActive = true
		timerVolleyCD:Start(5)
		timerPillageCD:Start(18)
		if self:IsHeroic() then
			timerSleightOfHandCD:Start(15.5)
			timerRainOfArrowsCD:Start(40)
		else
			timerRainOfArrowsCD:Start(15)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end
