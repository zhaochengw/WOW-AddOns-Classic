local mod	= DBM:NewMod("Sindragosa", "DBM-Raids-WoTLK", 2)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25,heroic,heroic25"

mod:SetRevision("20241103133102")
mod:SetCreatureID(36853)
mod:SetEncounterID(not mod:IsPostCata() and 855 or 1105)
mod:SetModelID(30362)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7)
mod:SetMinSyncRevision(20220623000000)
mod:SetZone(631)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 69649 73061",
	"SPELL_AURA_APPLIED 70126 69762 70106 69766 70127",
	"SPELL_AURA_APPLIED_DOSE 70106 69766 70127",
	"SPELL_AURA_REMOVED 69762 70157 70106 69766 70127",
	"SPELL_CAST_SUCCESS 70117",
	"UNIT_HEALTH boss1",
	"CHAT_MSG_MONSTER_YELL"
)

--Known issue: if a player dies with pre target debuff, the icon won't get cleared at all. it's annoying to fix since we don't want to clear icon until the TOMB is cleared (when they don't die)
local warnAirphase				= mod:NewAnnounce("WarnAirphase", 2, 43810)
local warnGroundphaseSoon		= mod:NewAnnounce("WarnGroundphaseSoon", 2, 43810)
local warnPhase2soon			= mod:NewPrePhaseAnnounce(2)
local warnPhase2				= mod:NewPhaseAnnounce(2, 2)
local warnInstability			= mod:NewCountAnnounce(69766, 2, nil, false)
local warnChilledtotheBone		= mod:NewCountAnnounce(70106, 2, nil, false)
local warnMysticBuffet			= mod:NewCountAnnounce(70128, 2, nil, false)
local warnFrostBeacon			= mod:NewTargetNoFilterAnnounce(70126, 4)
local warnFrostBreath			= mod:NewSpellAnnounce(69649, 2, nil, "Tank|Healer")
local warnUnchainedMagic		= mod:NewTargetAnnounce(69762, 2, nil, "SpellCaster", 2)

local specWarnUnchainedMagic	= mod:NewSpecialWarningYou(69762, nil, nil, nil, 1, 2)
local specWarnFrostBeacon		= mod:NewSpecialWarningMoveAway(70126, nil, nil, nil, 3, 2)
local yellFrostBeacon			= mod:NewShortPosYell(70126)
local yellFrostBeaconFades		= mod:NewIconFadesYell(70126)
local specWarnInstability		= mod:NewSpecialWarningStack(69766, nil, 4, nil, nil, 1, 6)
local specWarnChilledtotheBone	= mod:NewSpecialWarningStack(70106, nil, 4, nil, nil, 1, 6)
local specWarnMysticBuffet		= mod:NewSpecialWarningStack(70128, false, 5, nil, nil, 1, 6)
local specWarnBlisteringCold	= mod:NewSpecialWarningRun(70123, nil, nil, nil, 4, 2)

local timerNextAirphase			= mod:NewTimer(110, "TimerNextAirphase", 43810, nil, nil, 6)
local timerNextGroundphase		= mod:NewTimer(45, "TimerNextGroundphase", 43810, nil, nil, 6)
local timerNextFrostBreath		= mod:NewNextTimer(22, 69649, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerNextBlisteringCold	= mod:NewCDTimer(67, 70123, nil, nil, nil, 2)
local timerNextBeacon			= mod:NewCDCountTimer(16, 70126, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerBlisteringCold		= mod:NewCastTimer(6, 70123, nil, nil, nil, 2)
local timerUnchainedMagic		= mod:NewCDTimer(30, 69762, nil, nil, nil, 3)
local timerInstability			= mod:NewBuffFadesTimer(5, 69766, nil, nil, nil, 5)
local timerChilledtotheBone		= mod:NewBuffFadesTimer(8, 70106, nil, nil, nil, 5)
local timerMysticBuffet			= mod:NewBuffFadesTimer(10, 70128, nil, nil, nil, 5)
local timerNextMysticBuffet		= mod:NewNextTimer(6, 70128, nil, nil, nil, 2)
local timerMysticAchieve		= mod:NewAchievementTimer(30, 4620, "AchievementMystic")

local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconOnFrostBeacon", 70126, true, 7, {1, 2, 3, 4, 5, 6})--Uses roster sorting icons, so it does NOT match BWs. Cross mod raids should disable DBM or BW
mod:AddSetIconOption("SetIconOnUnchainedMagic", 69762, true, 0, {2, 3, 4, 5, 6, 7})--Starts at 2 so it doesn't steal frost beacon icon and the like
mod:AddBoolOption("ClearIconsOnAir", false, nil, nil, nil, nil, 70126)
mod:AddBoolOption("AnnounceFrostBeaconIcons", false, nil, nil, nil, nil, 70126)
mod:AddBoolOption("AchievementCheck", false, "announce", nil, nil, nil, 4620, "achievement")--group it with achievement timer
mod:AddRangeFrameOption("10/20")

local beaconTargets		= {}
local unchainedTargets	= {}
mod.vb.warned_P2 = false
mod.vb.warnedfailed = false
mod.vb.unchainedIcons = 2
local playerUnchained = false
local playerBeaconed = false
mod.vb.beaconCount = 0

local beaconDebuffFilter, unchainedDebuffFilter
do
	local beaconDebuff, unchainedDebuff = DBM:GetSpellName(70126), DBM:GetSpellName(69762)
	beaconDebuffFilter = function(uId)
		return DBM:UnitDebuff(uId, beaconDebuff)
	end
	unchainedDebuffFilter = function(uId)
		return DBM:UnitDebuff(uId, unchainedDebuff)
	end
end

local function warnBeaconTargets(self)
	if self.Options.RangeFrame then
		if not playerBeaconed then
			DBM.RangeCheck:Show(10, beaconDebuffFilter, nil, nil, nil, 9)
		else
			DBM.RangeCheck:Show(10, nil, nil, nil, nil, 9)
		end
	end
	warnFrostBeacon:Show(table.concat(beaconTargets, "<, >"))
	table.wipe(beaconTargets)
	playerBeaconed = false
end

local function warnUnchainedTargets(self)
	if self.Options.RangeFrame then
		if not playerUnchained then
			DBM.RangeCheck:Show(20, unchainedDebuffFilter)
		else
			DBM.RangeCheck:Show(20)
		end
	end
	warnUnchainedMagic:Show(table.concat(unchainedTargets, "<, >"))
	if self.vb.phase == 2 then
		timerUnchainedMagic:Start(80)
	else
		timerUnchainedMagic:Start()
	end
	table.wipe(unchainedTargets)
	self.vb.unchainedIcons = 2
	playerUnchained = false
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	berserkTimer:Start(-delay)
	timerNextAirphase:Start(50-delay)
	timerNextBlisteringCold:Start(33-delay)
	self.vb.warned_P2 = false
	self.vb.warnedfailed = false
	table.wipe(beaconTargets)
	table.wipe(unchainedTargets)
	self.vb.unchainedIcons = 2
	playerUnchained = false
	playerBeaconed = false
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(69649, 73061) then--Frost Breath
		warnFrostBreath:Show()
		timerNextFrostBreath:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 70126 then--Pre target debuff
		beaconTargets[#beaconTargets + 1] = args.destName
		if args:IsPlayer() then
			playerBeaconed = true
			specWarnFrostBeacon:Show()--self:IconNumToTexture(i)
			specWarnFrostBeacon:Play("scatter")--"mm"..i
		end
		if self.vb.phase == 2 then--Phase 2 there is only one icon/beacon, don't use sorting method if we don't have to.
			self.vb.beaconCount = self.vb.beaconCount + 1
			timerNextBeacon:Start(nil, self.vb.beaconCount+1)
			if self.Options.SetIconOnFrostBeacon then
				self:SetIcon(args.destName, 1)
				if self.Options.AnnounceFrostBeaconIcons and IsInGroup() and DBM:GetRaidRank() > 1 then
					SendChatMessage(L.BeaconIconSet:format(1, args.destName), IsInRaid() and "RAID" or "PARTY")
				end
				if playerBeaconed then
					yellFrostBeacon:Yell(1, 1)
					yellFrostBeaconFades:Countdown(args.spellId, nil, 1)
				end
			end
			warnBeaconTargets(self)
		else--Phase 1 air phase, multiple beacons
			self:Unschedule(warnBeaconTargets)
			local maxBeacon = (self.vb.phase == 2) and 1 or self:IsDifficulty("heroic25") and 6 or self:IsDifficulty("normal25") and 5 or 2--Heroic 10 and normal 2 are both 2
			if (#beaconTargets == maxBeacon) or (DBM:NumRealAlivePlayers() == #beaconTargets) then--Max beacons, or every player alive has one
				table.sort(beaconTargets, DBM.SortByGroup)
				for i = 1, #beaconTargets do
					local name = beaconTargets[i]
					if self.Options.SetIconOnFrostBeacon then
						self:SetIcon(name, i)
					end
					if name == DBM:GetMyPlayerInfo() then
						yellFrostBeacon:Yell(i, i)
						yellFrostBeaconFades:Countdown(args.spellId, nil, i)
					end
					if self.Options.AnnounceFrostBeaconIcons and IsInGroup() and DBM:GetRaidRank() > 1 then
						SendChatMessage(L.BeaconIconSet:format(i, name, IsInRaid() and "RAID" or "PARTY"))
					end
				end
				warnBeaconTargets(self)
			else
				self:Schedule(0.3, warnBeaconTargets, self)
			end
		end
	elseif args.spellId == 69762 then
		unchainedTargets[#unchainedTargets + 1] = args.destName
		if args:IsPlayer() then
			playerUnchained = true
			specWarnUnchainedMagic:Show()
			specWarnUnchainedMagic:Play("targetyou")
		end
		if self.Options.SetIconOnUnchainedMagic then
			self:SetIcon(args.destName, self.vb.unchainedIcons)
		end
		self.vb.unchainedIcons = self.vb.unchainedIcons + 1
		self:Unschedule(warnUnchainedTargets)
		if #unchainedTargets >= 6 then
			warnUnchainedTargets(self)
		else
			self:Schedule(0.3, warnUnchainedTargets, self)
		end
	elseif args.spellId == 70106 and not self:IsTrivial() then	--Chilled to the bone (melee)
		if args:IsPlayer() then
			timerChilledtotheBone:Start()
			if (args.amount or 1) >= 5 then
				specWarnChilledtotheBone:Show(args.amount)
				specWarnChilledtotheBone:Play("stackhigh")
			else
				warnChilledtotheBone:Show(args.amount or 1)
			end
		end
	elseif args.spellId == 69766 and not self:IsTrivial() then	--Instability (casters)
		if args:IsPlayer() then
			timerInstability:Start()
			if (args.amount or 1) >= 5 then
				specWarnInstability:Show(args.amount)
				specWarnInstability:Play("stackhigh")
			else
				warnInstability:Show(args.amount or 1)
			end
		end
	elseif args.spellId == 70127 then	--Mystic Buffet (phase 2 - everyone)
		if args:IsPlayer() then
			timerMysticBuffet:Start()
			timerNextMysticBuffet:Start()
			if (args.amount or 1) >= 5 then
				specWarnMysticBuffet:Show(args.amount)
				specWarnMysticBuffet:Play("stackhigh")
			else
				warnMysticBuffet:Show(args.amount or 1)
			end
			if self.Options.AchievementCheck and not self.vb.warnedfailed and (args.amount or 1) < 2 then
				timerMysticAchieve:Start()
			end
		end
		if args:IsDestTypePlayer() then
			if self.Options.AchievementCheck and DBM:GetRaidRank() > 0 and not self.vb.warnedfailed and self:AntiSpam(3) then
				if (args.amount or 1) == 5 then
					SendChatMessage(L.AchievementWarning:format(args.destName), "RAID")
				elseif (args.amount or 1) > 5 then
					self.vb.warnedfailed = true
					SendChatMessage(L.AchievementFailed:format(args.destName, (args.amount or 1)), "RAID_WARNING")
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 70117 then--Icy Grip Cast, not blistering cold, but adds an extra 1sec to the warning
		if not self:IsTrivial() then
			specWarnBlisteringCold:Show()
			specWarnBlisteringCold:Play("runout")
		end
		timerBlisteringCold:Start()
		if self:GetStage(2) then--Should only repeat in stage 2, otherwise timer is started by air phase yell
			timerNextBlisteringCold:Start()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69762 then
		if self.Options.SetIconOnUnchainedMagic then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 70157 then--Post target (frozen) debuff
		if self.Options.SetIconOnFrostBeacon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 70106 then	--Chilled to the bone (melee)
		if args:IsPlayer() then
			timerChilledtotheBone:Cancel()
		end
	elseif args.spellId == 69766 then	--Instability (casters)
		if args:IsPlayer() then
			timerInstability:Cancel()
		end
	elseif args.spellId == 70127 then
		if args:IsPlayer() then
			timerMysticAchieve:Cancel()
			timerMysticBuffet:Cancel()
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if not self.vb.warned_P2 and self:GetUnitCreatureId(uId) == 36853 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.38 then
		self.vb.warned_P2 = true
		warnPhase2soon:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellAirphase or msg:find(L.YellAirphase)) or (msg == L.YellAirphaseDem or msg:find(L.YellAirphaseDem)) then
		if self.Options.ClearIconsOnAir then
			self:ClearIcons()
		end
		warnAirphase:Show()
		timerNextFrostBreath:Cancel()
		timerUnchainedMagic:Start(55)
		timerNextBlisteringCold:Start(80)--Not exact anywhere from 80-110seconds after airphase begin
		timerNextAirphase:Start()
		timerNextGroundphase:Start()
		warnGroundphaseSoon:Schedule(40)
	elseif (msg == L.YellPhase2 or msg:find(L.YellPhase2)) or (msg == L.YellPhase2Dem or msg:find(L.YellPhase2Dem)) then
		self.vb.beaconCount = 0
		self:SetStage(2)
		warnPhase2:Show()
		timerNextBeacon:Start(7, 1)
		timerNextAirphase:Cancel()
		timerNextGroundphase:Cancel()
		warnGroundphaseSoon:Cancel()
		timerNextBlisteringCold:Start(35)
	end
end
