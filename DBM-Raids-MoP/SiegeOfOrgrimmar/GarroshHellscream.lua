local mod	= DBM:NewMod(869, "DBM-Raids-MoP", 1, 369)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,mythic,lfr"

mod:SetRevision("20241103134004")
mod:SetCreatureID(71865)
mod:SetEncounterID(1623)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(20210902000000)
mod:SetZone(1136)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 144583 144584 144969 144985 145037 147120 147011 145599 144821",
	"SPELL_CAST_SUCCESS 144748 144749 145065 145171",
	"SPELL_AURA_APPLIED 144945 145065 145171 145183 145195 144585 147209 147665 147235",
	"SPELL_AURA_APPLIED_DOSE 145183 145195 147235",
	"SPELL_AURA_REMOVED 145183 145195 144945 145065 145171 147209 147665",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"--I saw garrosh fire boss1 and boss3 events, so use all 5 to be safe
)

--General
local warnPhase						= mod:NewPhaseChangeAnnounce(2, 2, nil, nil, nil, nil, nil, 2)

local timerRoleplay					= mod:NewTimer(120.5, "timerRoleplay", "237538")--Wonder if this is somewhat variable?
local berserkTimer					= mod:NewBerserkTimer(1080)
--Stage 1: The True Horde
local warnSiegeEngineer				= mod:NewSpellAnnounce(-8298, 4, 144616)

local specWarnDesecrate				= mod:NewSpecialWarningTargetCount(144748, nil, nil, nil, 2, 2)
local specWarnDesecrateYou			= mod:NewSpecialWarningYou(144748, nil, nil, nil, 1, 2)
local yellDesecrate					= mod:NewYell(144748)
local specWarnHellscreamsWarsong	= mod:NewSpecialWarningSpell(144821, "Tank|Healer", nil, nil, 2, 2)
local specWarnExplodingIronStar		= mod:NewSpecialWarningSpell(144798, nil, nil, nil, 3, 2)
local specWarnFarseerWolfRider		= mod:NewSpecialWarningSwitchCount(-8294, "-Healer", nil, nil, 1, 2)
local specWarnSiegeEngineer			= mod:NewSpecialWarningPreWarn(-8298, false, 4, nil, nil, 1, 2)
local specWarnChainHeal				= mod:NewSpecialWarningInterrupt(144583, "HasInterrupt", nil, nil, 1, 2)
local specWarnChainLightning		= mod:NewSpecialWarningInterrupt(144584, false, nil, nil, 1, 2)

local timerDesecrateCD				= mod:NewCDCountTimer(33.8, 144748, nil, nil, nil, 3, nil, nil, nil, 2, 4)
local timerHellscreamsWarsongCD		= mod:NewNextTimer(42.2, 144821, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFarseerWolfRiderCD		= mod:NewNextCountTimer(50, -8294, nil, nil, nil, 1, 144585)--EJ says they come faster as phase progresses but all i saw was 3 spawn on any given pull and it was 30 50 50
local timerSiegeEngineerCD			= mod:NewNextCountTimer(40, -8298, nil, nil, nil, 1, 144616)
local timerPowerIronStar			= mod:NewCastTimer(16.5, 144616, nil, nil, nil, 2, nil, DBM_COMMON_L.DEADLY_ICON, nil, 1, 5)

mod:AddSetIconOption("SetIconOnShaman", -8294, false, 5, {8, 7, 6, 5, 4, 3, 2, 1})
--Intermission: Realm of Y'Shaarj
local warnYShaarjsProtection		= mod:NewTargetNoFilterAnnounce(144945, 2)
local warnYShaarjsProtectionFade	= mod:NewFadesAnnounce(144945, 1)

local specWarnAnnihilate			= mod:NewSpecialWarningDodge(144969, nil, nil, nil, 2, 2)

local timerEnterRealm				= mod:NewNextTimer(145.5, 144866, nil, nil, nil, 6, 144945)
local timerRealm					= mod:NewBuffActiveTimer(60.5, -8305, nil, nil, nil, 6, 144945, nil, nil, 1, 8)--May be too long, but intermission makes more sense than protection buff which actually fades before intermission ends if you do it right.
--Stage Two: Power of Y'Shaarj
local warnTouchOfYShaarj			= mod:NewTargetNoFilterAnnounce(145071, 3)
local warnGrippingDespair			= mod:NewStackAnnounce(145183, 2, nil, "Tank")

local specWarnWhirlingCorruption	= mod:NewSpecialWarningRunCount(144985, nil, nil, nil, 4, 2)--Two options important, for distinction and setting custom sounds for empowered one vs non empowered one, don't merge
local specWarnGrippingDespair		= mod:NewSpecialWarningStack(145183, nil, 4, nil, nil, 1, 6)--Unlike whirling and desecrate, doesn't need two options, distinction isn't important for tank swaps.
local specWarnGrippingDespairOther	= mod:NewSpecialWarningTaunt(145183, nil, nil, nil, 1, 2)
local specWarnTouchOfYShaarj		= mod:NewSpecialWarningSwitchCount(145071, "-Healer", nil, nil, 1, 2)
local specWarnTouchInterrupt		= mod:NewSpecialWarningInterrupt(145599, "HasInterrupt", nil, nil, 1, 2)

local timerWhirlingCorruptionCD		= mod:NewCDCountTimer(49.5, 144985, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON, nil, 1, 4)--One bar for both, "empowered" makes timer too long
local timerWhirlingCorruption		= mod:NewBuffActiveTimer(9, 144985, nil, false)
local timerTouchOfYShaarjCD			= mod:NewCDCountTimer(45, 145071, nil, nil, nil, 3, nil, DBM_COMMON_L.INTERRUPT_ICON, nil, 3, 4)
local timerGrippingDespair			= mod:NewTargetTimer(15, 145183, nil, "Tank", nil, 5, nil, DBM_COMMON_L.TANK_ICON)

mod:AddSetIconOption("SetIconOnMC", 145071, false, 0, {1, 2, 3, 4, 5, 6, 7, 8})
--Starge Three: MY WORLD
local warnEmpTouchOfYShaarj			= mod:NewTargetNoFilterAnnounce(145175, 3)
local warnEmpGrippingDespair		= mod:NewStackAnnounce(145195, 3, nil, "Tank")--Distinction is not that important, may just remove for the tank warning.

local specWarnEmpWhirlingCorruption	= mod:NewSpecialWarningRunCount(145037, nil, nil, nil, 4, 2)--Two options important, for distinction and setting custom sounds for empowered one vs non empowered one, don't merge
local specWarnEmpDesecrate			= mod:NewSpecialWarningTargetCount(144749, nil, nil, nil, 2, 2)--^^
--Starge Four: Heroic Hidden Phase
local warnMalice					= mod:NewTargetNoFilterAnnounce(147209, 2)
local warnManifestRage				= mod:NewSpellAnnounce(147011, 4)
local warnIronStarFixate			= mod:NewTargetNoFilterAnnounce(147665, 2)
local warnBombardmentOver			= mod:NewEndAnnounce(147120, 1)

local specWarnMaliceYou				= mod:NewSpecialWarningMoveTo(147209, nil, nil, nil, 1, 2)
local yellMalice					= mod:NewYell(147209, nil, false)
local yellMaliceFades				= mod:NewShortFadesYell(147209, nil, false, nil, "YELL")
local specWarnBombardment			= mod:NewSpecialWarningCount(147120, nil, nil, nil, 2, nil)
local specWarnISFixate				= mod:NewSpecialWarningYou(147665, nil, nil, nil, 1, 2)
local specWarnIronStarSpawn			= mod:NewSpecialWarningSpell(147047, nil, nil, nil, 2, 2)
local specWarnManifestRage			= mod:NewSpecialWarningMoveTo(147011, nil, nil, nil, 3, 2)
local specWarnMaliciousBlast		= mod:NewSpecialWarningStack(147235, nil, 1, nil, nil, 1, 6)
local specWarnNapalm				= mod:NewSpecialWarningGTFO(147136, nil, nil, nil, 1, 8)

local timerEnterGarroshRealm		= mod:NewNextTimer(20, 146984, nil, nil, nil, 6, 144945)
local timerMaliceCD					= mod:NewNextTimer(29.5, 147209, nil, nil, nil, 3, nil, nil, nil, 3, 4)--29.5-33sec variation
local timerBombardmentCD			= mod:NewNextTimer(55, 147120, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON, nil, 1, 4)
local timerBombardment				= mod:NewBuffActiveTimer(13, 147120, nil, nil, nil, 5, nil, DBM_COMMON_L.HEALER_ICON, nil, 2, 4)
local timerClumpCheck				= mod:NewNextTimer(3, 147126, nil, nil, nil, 2)
local timerMaliciousBlast			= mod:NewBuffFadesTimer(3, 147235, nil, false, nil, 5)
local timerFixate					= mod:NewTargetTimer(12, 147665, nil, nil, nil, 5)

mod:AddSetIconOption("SetIconOnMalice", 147209, false, 0, {7})
mod:AddBoolOption("InfoFrame", "Healer")--Custom on purpose, leave for now
--mod:AddBoolOption("RangeFrame")

--Upvales, don't need variables
local bombardCD = {55, 40, 40, 25, 25}
local engineerTimers = {20, 45, 40, 40, 35, 35, 30, 30, 25, 25, 25}
local shamanTimers = {31.5, 49.6, 49.6, 39.6, 39.6, 39.6, 29.6, 29.6, 29.6, 19.6}
local starFixate, grippingDespair, empGrippingDespair = DBM:GetSpellName(147665), DBM:GetSpellName(145183), DBM:GetSpellName(145195)
--Tables, can't recover
local lines = {}
--Not important, don't need to recover
local numberOfPlayers = 1
--Important, needs recover
mod.vb.engineerDied = 0
mod.vb.engineerCount = 0
mod.vb.shamanCount = 0
mod.vb.shamanAlive = 0
mod.vb.whirlCount = 0
mod.vb.desecrateCount = 0
mod.vb.mindControlCount = 0
mod.vb.bombardCount = 0
mod.vb.phase4Correction = false

local updateInfoFrame
do
	local spellName1, spellName2, spellName3 = DBM:GetSpellName(149004), DBM:GetSpellName(148983), DBM:GetSpellName(148994)
	function updateInfoFrame()
		table.wipe(lines)
		for uId in DBM:GetGroupMembers() do
			if not DBM:UnitDebuff(uId, spellName1, spellName2, spellName3) and not UnitIsDeadOrGhost(uId) then
				lines[UnitName(uId)] = ""
			end
		end
		return lines
	end
end

local function showInfoFrame(self)
	if self.Options.InfoFrame and self:IsInCombat() then
		DBM.InfoFrame:SetHeader(L.NoReduce)
		DBM.InfoFrame:Show(10, "function", updateInfoFrame)
	end
end

local function hideInfoFrame(self)
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:DesecrateTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") and not self:IsTanking(uId) then--Never targets tanks
		specWarnDesecrateYou:Show()
		specWarnDesecrateYou:Play("targetyou")
		yellDesecrate:Yell()
	else
		if UnitPower("boss1") < 75 then
			specWarnDesecrate:Show(self.vb.desecrateCount, targetname)
			specWarnDesecrate:Play("watchstep")
		else
			specWarnEmpDesecrate:Show(self.vb.desecrateCount, targetname)
			specWarnEmpDesecrate:Play("watchstep")
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.engineerDied = 0
	self.vb.engineerCount = 0
	self.vb.shamanCount = 0
	self.vb.shamanAlive = 0
	self:SetStage(1)
	self.vb.whirlCount = 0
	self.vb.desecrateCount = 0
	self.vb.mindControlCount = 0
	self.vb.bombardCount = 0
	self.vb.phase4Correction = false
	numberOfPlayers = DBM:GetNumRealGroupMembers()
	timerDesecrateCD:Start(10.5-delay, 1)
	specWarnSiegeEngineer:Schedule(16-delay)
	specWarnSiegeEngineer:ScheduleVoice(16-delay, "mobsoon")
	timerSiegeEngineerCD:Start(20-delay, 1)
	timerHellscreamsWarsongCD:Start(20.6-delay)
	timerFarseerWolfRiderCD:Start(30-delay, 1)
	if self:IsDifficulty("lfr25") then
		berserkTimer:Start(1500-delay)
	else
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
--[[	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end--]]
	hideInfoFrame(self)
	self:UnregisterShortTermEvents()
end

--[[
local function hideRangeDelay()
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end--]]

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 144583 then
		if self:CheckInterruptFilter(args.sourceGUID, nil, true) then
			specWarnChainHeal:Show(args.sourceName)
			specWarnChainHeal:Play("kickcast")
		end
	elseif spellId == 144584 then
		if self:CheckInterruptFilter(args.sourceGUID, nil, true) then
			specWarnChainLightning:Show(args.sourceName)
			specWarnChainLightning:Play("kickcast")
		end
	elseif spellId == 144969 then
		specWarnAnnihilate:Show()
		specWarnAnnihilate:Play("shockwave")
	elseif args:IsSpellID(144985, 145037) then
		self.vb.whirlCount = self.vb.whirlCount + 1
		if spellId == 144985 then
			specWarnWhirlingCorruption:Show(self.vb.whirlCount)
			specWarnWhirlingCorruption:Play("justrun")
		else
			specWarnEmpWhirlingCorruption:Show(self.vb.whirlCount)
			specWarnEmpWhirlingCorruption:Play("justrun")
		end
		timerWhirlingCorruption:Start()
		timerWhirlingCorruptionCD:Start(nil, self.vb.whirlCount+1)
	elseif spellId == 147120 then
		self.vb.bombardCount = self.vb.bombardCount + 1
		local count = self.vb.bombardCount
		specWarnBombardment:Show(count)
		specWarnBombardment:Play("specialsoon")
		warnBombardmentOver:Schedule(13)
		timerBombardment:Start()
		timerBombardmentCD:Start(bombardCD[count] or 15, count+1)
		timerClumpCheck:Start()
	elseif spellId == 147011 then
		if DBM:UnitDebuff("player", starFixate) then--Kiting an Unstable Iron Star
			specWarnManifestRage:Show(DBM_COMMON_L.BOSS)
			specWarnManifestRage:Play("movetoboss")
			specWarnManifestRage:ScheduleVoice(2, "kickcast")--it needs to be kited to garrosh and used as an interrupt
		else
			warnManifestRage:Show()
		end
	elseif spellId == 145599 and self:CheckInterruptFilter(args.sourceGUID, nil, true) then
		specWarnTouchInterrupt:Show(args.sourceName)
		specWarnTouchInterrupt:Play("kickcast")
	elseif spellId == 144821 then--Warsong. Does not show in combat log
		timerHellscreamsWarsongCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if args:IsSpellID(144748, 144749) then
		self.vb.desecrateCount = self.vb.desecrateCount + 1
		if self:GetStage(1) then
			timerDesecrateCD:Start(40, self.vb.desecrateCount+1)
		elseif self:GetStage(2) then
			timerDesecrateCD:Start(25, self.vb.desecrateCount+1)
		else--Phase 2
			timerDesecrateCD:Start(nil, self.vb.desecrateCount+1)--33.8
		end
		self:BossTargetScanner(71865, "DesecrateTarget", 0.02, 16)
	elseif args:IsSpellID(145065, 145171) then
		self.vb.mindControlCount = self.vb.mindControlCount + 1
		specWarnTouchOfYShaarj:Show(self.vb.mindControlCount)
		specWarnTouchOfYShaarj:Play("findmc")
		if numberOfPlayers < 2 then return end--Solo raid, no mind controls, so no timers
		if self:GetStage(3) then
			if self.vb.mindControlCount == 1 then--First one in phase is shorter than rest (well that or rest are delayed because of whirling)
				timerTouchOfYShaarjCD:Start(35, self.vb.mindControlCount+1)
			else
				timerTouchOfYShaarjCD:Start(42, self.vb.mindControlCount+1)
			end
		else
			timerTouchOfYShaarjCD:Start(nil, self.vb.mindControlCount+1)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 144945 then
		warnYShaarjsProtection:Show(args.destName)
		timerRealm:Start()
	elseif args:IsSpellID(145065, 145171) then
		if spellId == 145065 then
			warnTouchOfYShaarj:CombinedShow(0.5, args.destName)
		else
			warnEmpTouchOfYShaarj:CombinedShow(0.5, args.destName)
		end
		if self.Options.SetIconOnMC then
			self:SetSortedIcon("roster", 1, args.destName, 1)
		end
	elseif args:IsSpellID(145183, 145195) then
		local amount = args.amount or 1
		timerGrippingDespair:Start(args.destName)
		if amount >= 4 then
			if args:IsPlayer() then
				specWarnGrippingDespair:Show(amount)
				specWarnGrippingDespair:Play("stackhigh")
			else
				if not DBM:UnitDebuff("player", grippingDespair, empGrippingDespair) and not UnitIsDeadOrGhost("player") then
					specWarnGrippingDespairOther:Show(args.destName)
					specWarnGrippingDespairOther:Play("tauntboss")
				else
					if spellId == 145183 then
						warnGrippingDespair:Show(args.destName, amount)
					else
						warnEmpGrippingDespair:Show(args.destName, amount)
					end
				end
			end
		else
			if spellId == 145183 then
				warnGrippingDespair:Show(args.destName, amount)
			else
				warnEmpGrippingDespair:Show(args.destName, amount)
			end
		end
	elseif spellId == 144585 then
		self.vb.shamanAlive = self.vb.shamanAlive + 1
		self.vb.shamanCount = self.vb.shamanCount + 1
		specWarnFarseerWolfRider:Show(self.vb.shamanCount)
		specWarnFarseerWolfRider:Play("killmob")
		local timer = shamanTimers[self.vb.shamanCount+1] or 19.6--20 assumed, it could go lower?
		timerFarseerWolfRiderCD:Start(timer, self.vb.shamanCount+1)
		if self.Options.SetIconOnShaman and self.vb.shamanAlive < 9 then--Support for marking up to 8 shaman
			self:ScanForMobs(71983, 2, 9-self.vb.shamanAlive, 1, nil, 10, "SetIconOnShaman")
		end
	elseif spellId == 147209 then
		self:SendSync("MaliceTarget", args.destGUID)
	elseif spellId == 147665 then
		timerFixate:Start(args.destName)
		if args:IsPlayer() then
			specWarnISFixate:Show()
			specWarnISFixate:Play("targetyou")
		else
			warnIronStarFixate:Show(args.destName)
		end
	elseif spellId == 147235 and args:IsPlayer() then
		local amount = args.amount or 1
		timerGrippingDespair:Start(args.destName)
		if amount >= 1 then
			specWarnMaliciousBlast:Show(amount)
			specWarnMaliciousBlast:Play("stackhigh")
			timerMaliciousBlast:Start()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if args:IsSpellID(145183, 145195) then
		timerGrippingDespair:Cancel(args.destName)
	elseif spellId == 144945 then
		warnYShaarjsProtectionFade:Show()
		showInfoFrame(self)
	elseif args:IsSpellID(145065, 145171) and self.Options.SetIconOnMC then
		self:SetIcon(args.destName, 0)
	elseif spellId == 147209 then
		self:SendSync("MaliceTargetRemoved", args.destGUID)
	elseif spellId == 147665 then
		timerFixate:Cancel(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 147136 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnNapalm:Show(spellName)
		specWarnNapalm:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71984 then--Siege Engineer
		self.vb.engineerDied = self.vb.engineerDied + 1
		if self.vb.engineerDied == 2 then
			specWarnExplodingIronStar:Cancel()
			specWarnExplodingIronStar:CancelVoice()
			timerPowerIronStar:Cancel()
		end
	elseif cid == 71983 then--Farseer Wolf Rider
		self.vb.shamanAlive = self.vb.shamanAlive - 1
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 144821 then--Warsong. Does not show in combat log
		specWarnHellscreamsWarsong:Show()--Want this warning when adds get buff
		specWarnHellscreamsWarsong:Play("defensive")
	elseif spellId == 145235 then--Throw Axe At Heart
		timerSiegeEngineerCD:Cancel()
		timerFarseerWolfRiderCD:Cancel()
		timerDesecrateCD:Cancel()
		timerHellscreamsWarsongCD:Cancel()
		specWarnSiegeEngineer:Cancel()
		specWarnSiegeEngineer:CancelVoice()
		if self:GetStage(1) then
			timerEnterRealm:Start(25)
		end
	elseif spellId == 144866 then--Enter Realm of Y'Shaarj
		timerPowerIronStar:Cancel()
		timerDesecrateCD:Cancel()
		timerTouchOfYShaarjCD:Cancel()
		timerWhirlingCorruptionCD:Cancel()
	elseif spellId == 144956 then--Jump To Ground (intermission ending)
		timerRealm:Cancel()
		if self:GetStage(2, 1) then--first cast, phase2 trigger.
			self:SetStage(2)
			warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
			warnPhase:Play("ptwo")
		else
			self.vb.whirlCount = 0
			self.vb.desecrateCount = 0
			self.vb.mindControlCount = 0
			hideInfoFrame(self)
			timerDesecrateCD:Start(10, 1)
			if numberOfPlayers > 1 then
				timerTouchOfYShaarjCD:Start(15, 1)
			end
			timerWhirlingCorruptionCD:Start(30, 1)
			timerEnterRealm:Start()
		end
	--"<556.9 21:41:56> [UNIT_SPELLCAST_SUCCEEDED] Garrosh Hellscream [[boss1:Realm of Y'Shaarj::0:145647]]", -- [169886]
	elseif spellId == 145647 and self:GetStage(3, 1) then--Phase 3 trigger
		self:SetStage(3)
		self.vb.whirlCount = 0
		self.vb.desecrateCount = 0
		self.vb.mindControlCount = 0
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		timerEnterRealm:Cancel()
		timerDesecrateCD:Cancel()
		timerTouchOfYShaarjCD:Cancel()
		timerWhirlingCorruptionCD:Cancel()
		timerDesecrateCD:Start(21, 1)
		if numberOfPlayers > 1 then
			timerTouchOfYShaarjCD:Start(30, 1)
		end
		timerWhirlingCorruptionCD:Start(44.5, 1)
	elseif spellId == 146984 and self:GetStage(4, 1) then--Phase 4 trigger
		self:SetStage(4)
		self.vb.bombardCount = 0
		timerEnterRealm:Cancel()
		timerDesecrateCD:Cancel()
		timerTouchOfYShaarjCD:Cancel()
		timerWhirlingCorruptionCD:Cancel()
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(4))
		warnPhase:Play("pfour")
		timerMaliceCD:Start()
		timerBombardmentCD:Start(70)
		self:RegisterShortTermEvents(
			"SPELL_PERIODIC_DAMAGE",
			"SPELL_PERIODIC_MISSED"
		)
	elseif spellId == 147187 and not self.vb.phase4Correction then--Phase 4 timer fixer (Call Gunship) (needed in case anyone in raid watched cinematic)
		self.vb.phase4Correction = true
		timerMaliceCD:Update(18.5, 29.5)
		timerBombardmentCD:Update(20, 70)
	elseif spellId == 147126 then--Clump Check
		timerClumpCheck:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:144616") then
		self.vb.engineerCount = self.vb.engineerCount + 1
		self.vb.engineerDied = 0
		warnSiegeEngineer:Show()
		specWarnSiegeEngineer:Cancel()
		specWarnSiegeEngineer:Schedule(41)
		specWarnSiegeEngineer:ScheduleVoice(41, "mobsoon")
		local timer = engineerTimers[self.vb.engineerCount+1] or 25--Assumed 25 is lowest it goes
		timerSiegeEngineerCD:Start(timer, self.vb.engineerCount+1)
		if self:IsMythic() then
			timerPowerIronStar:Start(11.5)
			specWarnExplodingIronStar:Schedule(11.5)
			specWarnExplodingIronStar:ScheduleVoice(11.5, "aesoon")
		else
			timerPowerIronStar:Start()
			specWarnExplodingIronStar:Schedule(16.5)
			specWarnExplodingIronStar:ScheduleVoice(16.5, "aesoon")
        end
	elseif msg:find("spell:147047") then
		specWarnIronStarSpawn:Show()
		specWarnIronStarSpawn:Play("watchorb")
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.wasteOfTime then
		self:SendSync("prepull")
	elseif (msg == L.phase3End or msg:find(L.phase3End)) and self:IsInCombat() then
		self:SendSync("phase3End")
	end
end

function mod:OnSync(msg, guid)
	if msg == "MaliceTarget" and guid and self:IsInCombat() then
		local targetName = DBM:GetFullPlayerNameByGUID(guid)
		timerMaliceCD:Start()
		if targetName == UnitName("player") then
			specWarnMaliceYou:Show(DBM_COMMON_L.ALLIES)
			specWarnMaliceYou:Play("gathershare")
			yellMalice:Yell()
			yellMaliceFades:Countdown(14, 4)
		else
			warnMalice:Show(targetName)
		end
		if self.Options.SetIconOnMalice then
			self:SetIcon(targetName, 7)
		end
	elseif msg == "MaliceTargetRemoved" and guid and self.Options.SetIconOnMalice and self:IsInCombat() then
		local targetName = DBM:GetFullPlayerNameByGUID(guid)
		self:SetIcon(targetName, 0)
		if targetName == UnitName("player") then
			yellMaliceFades:Cancel()
		end
	elseif msg == "prepull" then
		timerRoleplay:Start()
	elseif msg == "phase3End" and self:IsInCombat() then
		timerDesecrateCD:Cancel()
		timerTouchOfYShaarjCD:Cancel()
		timerWhirlingCorruptionCD:Cancel()
		timerEnterGarroshRealm:Start()
	end
end
