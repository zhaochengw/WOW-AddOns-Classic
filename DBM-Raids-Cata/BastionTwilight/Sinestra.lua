local mod	= DBM:NewMod(168, "DBM-Raids-Cata", 4, 72)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "heroic,heroic25"

mod:SetRevision("20241103125714")
mod:SetCreatureID(45213)
mod:SetEncounterID(1082, 1083)--Muiti encounter id. need to verify.
mod:SetUsedIcons(1, 2)
mod:SetZone(671)
mod.respawnTime = 40
--mod:SetModelSound("Sound\\Creature\\Sinestra\\VO_BT_Sinestra_Aggro01.ogg", "Sound\\Creature\\Sinestra\\VO_BT_Sinestra_Kill02.ogg")
--Long: We were fools to entrust an imbecile like Cho'gall with such a sacred duty! I will deal with you intruders myself!
--Short: Powerless....

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 90125 86227",
	"SPELL_AURA_APPLIED 90045 89421 89435 87299 87654 87946",
	"SPELL_AURA_REMOVED 87654",
	"SPELL_DAMAGE 92852 92958",
	"SPELL_MISSED 92852 92958",
	"SWING_DAMAGE",
	"SWING_MISSED",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnOrbSoon			= mod:NewAnnounce("WarnOrbSoon", 3, 92852, true, nil, 0)--Still on by default but no longer plays it's own sounds, basically a text countdown object
local warnOrbs				= mod:NewAnnounce("warnAggro", 4, 92852, nil, nil, nil, 92852)
local warnWrack				= mod:NewTargetNoFilterAnnounce(89421, 4)
local warnWrackJump			= mod:NewAnnounce("warnWrackJump", 3, 89421, false, nil, nil, 89421)--Not spammy at all (unless you're dispellers are retarded and make it spammy). Useful for a raid leader to coordinate quicker, especially on 10 man with low wiggle room.
local warnDragon			= mod:NewSpellAnnounce(-3231, 3, 69002)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnExtinction		= mod:NewSpellAnnounce(86227, 4)
local warnPhase3			= mod:NewPhaseAnnounce(3, 2)
local warnRedEssence		= mod:NewSpellAnnounce(87946, 3)

local specWarnOrbs			= mod:NewSpecialWarning("SpecWarnOrbs", nil, nil, nil, 2, 2, nil, nil, 92852)
local specWarnOrbOnYou		= mod:NewSpecialWarning("SpecWarnAggroOnYou", nil, nil, nil, 3, 5, nil, nil, 92852)
local specWarnBreath		= mod:NewSpecialWarningSpell(90125, nil, nil, nil, 2, 2)
local specWarnEggShield		= mod:NewSpecialWarningSpell(87654, "Ranged", nil, nil, 1, 2)
local specWarnEggWeaken		= mod:NewSpecialWarningSwitch(-3238, "Ranged", nil, nil, 1, 2)
local specWarnIndomitable	= mod:NewSpecialWarningDispel(90045, "RemoveEnrage", nil, nil, 1, 2)

local timerBreathCD			= mod:NewCDTimer(21, 90125, nil, nil, nil, 2)
local timerOrbs				= mod:NewTimer(28, "TimerOrbs", 92852, nil, nil, 3, DBM_COMMON_L.DEADLY_ICON, nil, 1, 4)
local timerWrack			= mod:NewNextTimer(61, 89421, nil, "Healer", nil, 5, nil, DBM_COMMON_L.HEALER_ICON)
local timerExtinction		= mod:NewCastTimer(16, 86227, nil, nil, nil, 2)
local timerEggWeakening		= mod:NewTimer(4, "TimerEggWeakening", 61357, nil, nil, 6)
local timerEggWeaken		= mod:NewTimer(30, "TimerEggWeaken", 61357, nil, nil, 5, DBM_COMMON_L.DAMAGE_ICON)
local timerDragon			= mod:NewNextTimer(50, -3231, nil, nil, nil, 1, 69002)
local timerRedEssenceCD		= mod:NewNextTimer(22, 87946, nil, nil, nil, 6)--21-23 seconds after red egg dies
local timerRedEssence		= mod:NewBuffFadesTimer(180, 87946, nil, nil, nil, 5)

mod:AddSetIconOption("SetIconOnOrbs", 92852, true, 0, {2, 1})--Basically uses all icons to mark anyone with threat initially, then remark when it's more sure after fact
mod:AddInfoFrameOption(92852, false)--Does not filter tanks. not putting ugly hack in info frame, its simpley an aggro tracker

mod.vb.eggDown = 0
mod.vb.eggRemoved = false
mod.vb.orbWarned = nil
mod.vb.expectedTargets = 25
local orbList = {}
local cachedWhelps = {}
local playerWarned = nil
local wrackName = DBM:GetSpellName(89421)
local wrackTargets = {}

local function resetPlayerOrbStatus(self)
	self.vb.orbWarned = nil
	playerWarned = nil
end

local function hasAggro(self, unit)
	-- 1. check tanks first
	-- 2. anyone with whelp aggro
	if self:IsTanking(unit) then
		return true
	end
	for guid, _ in pairs(cachedWhelps) do
		local whelpUID = self:GetUnitIdFromGUID(guid)
		if whelpUID then
			if self:IsTanking(unit, whelpUID, nil, true) then
				return true
			end
		end
	end
	return false
end

local function showOrbWarning(self, source)
	table.wipe(orbList)
	self:Unschedule(showOrbWarning)
	if not IsInGroup() then--Solo, always orb target
		playerWarned = true
		specWarnOrbOnYou:Show()
		specWarnOrbOnYou:Play("orbrun")
		return
	end
	for i = 1, DBM:GetNumGroupMembers() do
		-- do some checks for 25/10 man raid size so we don't warn for ppl who are not in the instance (but are in raid group)
		if i > self.vb.expectedTargets then return end
		local n = GetRaidRosterInfo(i)
		-- Has aggro on something, but not a tank
		if n and UnitThreatSituation(n) == 3 and not hasAggro(self, n) then
			orbList[#orbList + 1] = n
			if UnitIsUnit(n, "player") and not playerWarned then
				playerWarned = true
				specWarnOrbOnYou:Show()
				specWarnOrbOnYou:Play("orbrun")
			end
		end
	end
	if source == "spawn" then
		if #orbList >= 2 then--only warn for 2 or more.
			warnOrbs:Show(table.concat(orbList, "<, >"))
			-- if we could guess orb targets lets wipe the orb list in 5 sec
			-- if not then we might as well just save them for next time
			if self.Options.SetIconOnOrbs then
				self:ClearIcons()
				if orbList[1] then self:SetIcon(orbList[1], 1) end
				if orbList[2] then self:SetIcon(orbList[2], 2) end
				--if orbList[3] then self:SetIcon(orbList[3], 6) end
				--if orbList[4] then self:SetIcon(orbList[4], 5) end
				--if orbList[5] then self:SetIcon(orbList[5], 4) end
				--if orbList[6] then self:SetIcon(orbList[6], 3) end
				--if orbList[7] then self:SetIcon(orbList[7], 2) end
				--if orbList[8] then self:SetIcon(orbList[8], 1) end
			end
		else
			self:Schedule(0.5, showOrbWarning, self, "spawn")--check again soon since we didn't have 2 yet.
		end
	elseif source == "damage" then--Orbs are damaging people, they are without a doubt targeting 2 players by now, although may still have others with aggro :\
		warnOrbs:Show(table.concat(orbList, "<, >"))
		self:Schedule(10, resetPlayerOrbStatus, self)
		if self.Options.SetIconOnOrbs then
			self:ClearIcons()
			if orbList[1] then self:SetIcon(orbList[1], 1) end
			if orbList[2] then self:SetIcon(orbList[2], 2) end
			--if orbList[3] then self:SetIcon(orbList[3], 6) end
			--if orbList[4] then self:SetIcon(orbList[4], 5) end
			--if orbList[5] then self:SetIcon(orbList[5], 4) end
			--if orbList[6] then self:SetIcon(orbList[6], 3) end
			--if orbList[7] then self:SetIcon(orbList[7], 2) end
			--if orbList[8] then self:SetIcon(orbList[8], 1) end
		end
	end
end

function mod:OrbsRepeat()
	resetPlayerOrbStatus(self)
	timerOrbs:Start()
	if self.Options.WarnOrbSoon then
		warnOrbSoon:Schedule(23, 5)
		warnOrbSoon:Schedule(24, 4)
		warnOrbSoon:Schedule(25, 3)
		warnOrbSoon:Schedule(26, 2)
		warnOrbSoon:Schedule(27, 1)
	end
	specWarnOrbs:Show()--generic aoe warning on spawn, before we have actual targets yet.
	specWarnOrbs:Play("watchorb")
	if self:IsInCombat() then
		self:ScheduleMethod(28, "OrbsRepeat")
		self:Schedule(0.5, showOrbWarning, self, "spawn")--Start spawn checks
	end
end

local function showWrackWarning()
	warnWrackJump:Show(wrackName, table.concat(wrackTargets, "<, >"))
	table.wipe(wrackTargets)
end

function mod:OnCombatStart(delay)
	self.vb.expectedTargets = self:IsDifficulty("heroic25") and 25 or 10
	self.vb.eggDown = 0
	self.vb.eggRemoved = false
	timerDragon:Start(16-delay)
	timerBreathCD:Start(21-delay)
	timerOrbs:Start(29-delay)
	table.wipe(orbList)
	self.vb.orbWarned = nil
	playerWarned = nil
	table.wipe(wrackTargets)
	table.wipe(cachedWhelps)
	if self.Options.WarnOrbSoon then
		warnOrbSoon:Schedule(24-delay, 5)
		warnOrbSoon:Schedule(25-delay, 4)
		warnOrbSoon:Schedule(26-delay, 3)
		warnOrbSoon:Schedule(27-delay, 2)
		warnOrbSoon:Schedule(28-delay, 1)
	end
	self:ScheduleMethod(29-delay, "OrbsRepeat")
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.HasAggro)
		DBM.InfoFrame:Show(6, "playeraggro", 3)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 90125 then
		specWarnBreath:Show()
		specWarnBreath:Play("breathsoon")
		timerBreathCD:Start()
	elseif args.spellId == 86227 then
		warnExtinction:Show()
		timerExtinction:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 90045 then
		specWarnIndomitable:Show(args.destName)
		specWarnIndomitable:Play("enrage")
	elseif args.spellId == 89421 then--Cast wracks (10,25)
		warnWrack:Show(args.destName)
		timerWrack:Start()
	elseif args.spellId == 89435 then -- jumped wracks (10,25)
		wrackTargets[#wrackTargets + 1] = args.destName
		self:Unschedule(showWrackWarning)
		self:Schedule(0.3, showWrackWarning)
	elseif args.spellId == 87299 then
		self.vb.eggDown = 0
		warnPhase2:Show()
		timerBreathCD:Cancel()
		timerOrbs:Cancel()
		if self.Options.WarnOrbSoon then
			warnOrbSoon:Cancel()
		end
		self:UnscheduleMethod("OrbsRepeat")
		if self.Options.SetIconOnOrbs then
			self:ClearIcons()
		end
	elseif args.spellId == 87654 then
		if self:AntiSpam(3) then
			timerDragon:Cancel()
			if self.vb.eggRemoved then
				specWarnEggShield:Show()
				specWarnEggShield:Play("stopattack")
			end
		end
	elseif args.spellId == 87946 and args:IsNPC() then--NPC check just simplifies it cause he gains the buff too, before he dies, less local variables this way.
		warnRedEssence:Show()
		timerRedEssence:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 87654 and self:AntiSpam(3) then
		timerEggWeaken:Show()
		specWarnEggWeaken:Show()
		specWarnEggWeaken:Play("targetchange")
		self.vb.eggRemoved = true
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, _, _, _, spellId)
	if (spellId == 92958 or spellId == 92852) and not self.vb.orbWarned then
		self.vb.orbWarned = true
		showOrbWarning(self, "damage")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SWING_DAMAGE(sourceGUID)
	local cid = self:GetCIDFromGUID(sourceGUID)
	if cid == 47265 or cid == 48047 or cid == 48048 or cid == 48049 or cid == 48050 then--Whelps
		cachedWhelps[sourceGUID] = true
	end
end
mod.SWING_MISSED = mod.SWING_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 46842 then
		self.vb.eggDown = self.vb.eggDown + 1
		if self.vb.eggDown >= 2 then
			timerEggWeaken:Cancel()
			warnPhase3:Show()
			timerBreathCD:Start()
			timerOrbs:Start(30)
			timerDragon:Start()
			timerRedEssenceCD:Start()
			if self.Options.WarnOrbSoon then
				warnOrbSoon:Cancel()
				warnOrbSoon:Schedule(25, 5)
				warnOrbSoon:Schedule(26, 4)
				warnOrbSoon:Schedule(27, 3)
				warnOrbSoon:Schedule(28, 2)
				warnOrbSoon:Schedule(29, 1)
			end
			self:UnscheduleMethod("OrbsRepeat")
			self:ScheduleMethod(30, "OrbsRepeat")
		end
	elseif cid == 47265 or cid == 48047 or cid == 48048 or cid == 48049 or cid == 48050 then--Whelps
		cachedWhelps[args.destGUID] = nil
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellDragon or msg:find(L.YellDragon) then
		warnDragon:Show()
		timerDragon:Start()
	elseif msg == L.YellEgg or msg:find(L.YellEgg) then
		timerEggWeakening:Start()
	end
end
