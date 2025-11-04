local mod	= DBM:NewMod(818, "DBM-Raids-MoP", 2, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103134004")
mod:SetCreatureID(68036)--Crimson Fog 69050
mod:SetEncounterID(1572)
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 1)
mod:SetZone(1098)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 133765 138467 136154 134587",
	"SPELL_CAST_SUCCESS 136932 134122 134123 134124 139202 139204",
	"SPELL_AURA_APPLIED 133767 133597 133598 134626 137727 133798",
	"SPELL_AURA_APPLIED_DOSE 133767 133798",
	"SPELL_AURA_REMOVED 133767 137727 133597",
	"SPELL_DAMAGE 133793",
	"SPELL_MISSED 133793",
	"SPELL_PERIODIC_DAMAGE 134755",
	"SPELL_PERIODIC_MISSED 134755",
	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_DIED"
)

local warnHardStare					= mod:NewSpellAnnounce(133765, 3, nil, "Tank|Healer")--Announce CAST not debuff, cause it misses a lot, plus we have 1 sec to hit an active mitigation
local warnForceOfWill				= mod:NewTargetNoFilterAnnounce(136413, 4)
local warnLingeringGaze				= mod:NewTargetAnnounce(138467, 3)
mod:AddBoolOption("warnBeam", nil, "announce")
local warnBeamNormal				= mod:NewAnnounce("warnBeamNormal", 4, 139204, true, false)
local warnBeamHeroic				= mod:NewAnnounce("warnBeamHeroic", 4, 139204, true, false)
local warnAddsLeft					= mod:NewAnnounce("warnAddsLeft", 2, 134123)
local warnLifeDrain					= mod:NewTargetNoFilterAnnounce(133795, 3)--Some times needs to block this even dps. So warn for everyone.
local warnDarkParasite				= mod:NewTargetNoFilterAnnounce(133597, 3, nil, "Healer")--Heroic
local warnIceWall					= mod:NewSpellAnnounce(134587, 3, 111231)

local specWarnSeriousWound			= mod:NewSpecialWarningStack(133767, nil, 5, nil, nil, 1, 2)--This we will use debuff on though.
local specWarnSeriousWoundOther		= mod:NewSpecialWarningTaunt(133767, nil, nil, nil, 1, 2)
local specWarnForceOfWill			= mod:NewSpecialWarningDodge(136413, nil, nil, nil, 3, 2)
local yellForceOfWill				= mod:NewYell(136413)
local specWarnLingeringGaze			= mod:NewSpecialWarningMoveAway(138467, nil, nil, nil, 1, 2)
local yellLingeringGaze				= mod:NewYell(138467, nil, false)
local specWarningGTFO				= mod:NewSpecialWarningGTFO(138467, nil, nil, nil, 1, 8)
local specWarnBlueBeam				= mod:NewSpecialWarning("specWarnBlueBeam", nil, nil, nil, 3, 17)
local specWarnBlueBeamLFR			= mod:NewSpecialWarningYou(139202, true, false, nil, 3, 17)
local specWarnRedBeam				= mod:NewSpecialWarningYou(139204, nil, nil, nil, 3, 17)
local specWarnYellowBeam			= mod:NewSpecialWarningYou(133738, nil, nil, nil, 3, 17)
local specWarnFogRevealed			= mod:NewSpecialWarning("specWarnFogRevealed", nil, nil, nil, 1, 2)--Use another "Be Aware!" sound because Lingering Gaze comes on Spectrum phase.
local specWarnDisintegrationBeam	= mod:NewSpecialWarningSpell(-6882, nil, nil, nil, 2, 2)
local specWarnLifeDrain				= mod:NewSpecialWarningTarget(133795, "Tank", nil, nil, 1, 2)
local yellLifeDrain					= mod:NewYell(133795, L.LifeYell)

local timerHardStareCD				= mod:NewCDTimer(11.2, 133765, nil, "Tank|Healer", nil, 5)
local timerSeriousWound				= mod:NewTargetTimer(60, 133767, nil, "Tank|Healer")
local timerlingeringGazeCD			= mod:NewCDTimer(46, 138467, nil, nil, nil, 3)
local timerForceOfWillCD			= mod:NewCDTimer(20, 136413, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)--Actually has a 20 second cd but rarely cast more than once per phase because of how short the phases are (both beams phases cancel this ability)
local timerLightSpectrumCD			= mod:NewNextTimer(60, -6891, nil, nil, nil, 6, nil, nil, nil, 1, 5)
local timerDisintegrationBeam		= mod:NewBuffActiveTimer(55, -6882, nil, nil, nil, 6, nil, nil, nil, 1, 5)
local timerDisintegrationBeamCD		= mod:NewNextTimer(136, -6882, nil, nil, nil, 6)
local timerLifeDrainCD				= mod:NewCDTimer(40, 133795, nil, nil, nil, 3)
local timerLifeDrain				= mod:NewBuffActiveTimer(18, 133795, nil, nil, nil, 5)
local timerIceWallCD				= mod:NewNextTimer(120, 134587, nil, nil, nil, 6, 111231, DBM_COMMON_L.HEROIC_ICON)
local timerDarkParasiteCD			= mod:NewCDTimer(60.5, 133597, nil, "Healer", nil, 5)--Heroic 60-62. (the timer is tricky and looks far more variable but it really isn't, it just doesn't get to utilize it's true cd timer more than twice per fight)
local timerDarkParasite				= mod:NewTargetTimer(30, 133597, nil, false, 2)--Spammy bar in 25 man not useful.
local timerDarkPlague				= mod:NewTargetTimer(30, 133598, nil, false, 2)--Spammy bar in 25 man not useful.
local timerObliterateCD				= mod:NewNextTimer(80, 137747, nil, nil, nil, 2)--Heroic

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddSetIconOption("SetIconRays", -6891, true, 0, {1, 6, 7})
mod:AddSetIconOption("SetIconLifeDrain", 133795, true, 0, {8})
mod:AddSetIconOption("SetIconOnParasite", 133597, false, 0, {5, 4, 3})
mod:AddInfoFrameOption(133795)
mod:AddBoolOption("SetParticle", true)

mod.vb.totalFogs = 3
mod.vb.lingeringGazeCD = 46
mod.vb.lastRed = nil
mod.vb.lastBlue = nil
mod.vb.lastYellow = nil
mod.vb.spectrumStarted = false
mod.vb.lifeDrained = false
mod.vb.lfrCrimsonFogRevealed = false
mod.vb.lfrAmberFogRevealed = false
mod.vb.lfrAzureFogRevealed = false
mod.vb.firstIcewall = false
local lfrEngaged = false
local crimsonFog = DBM:EJ_GetSectionInfo(6892)
local amberFog = DBM:EJ_GetSectionInfo(6895)
local azureFog = DBM:EJ_GetSectionInfo(6898)
local lifeDrain = DBM:GetSpellName(133795)
local playerName = UnitName("player")
local CVAR = nil
local yellowRevealed = 0
local scanTime = 0

local function warnBeam(self)
	if mod:IsDifficulty("heroic10", "heroic25", "lfr25") then
		warnBeamHeroic:Show(self.vb.lastRed, self.vb.lastBlue, self.vb.lastYellow)
	else
		warnBeamNormal:Show(self.vb.lastRed, self.vb.lastBlue)
	end
end

local function HideInfoFrame()
	if mod.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

local function BeamEnded(self)
	timerlingeringGazeCD:Start(17)
	timerForceOfWillCD:Start(19)
	if self:IsHeroic() then
		timerDarkParasiteCD:Start(10)
		timerIceWallCD:Start(32)
		self.vb.firstIcewall = true
	end
	if self:IsDifficulty("lfr25") then
		timerLightSpectrumCD:Start(66)
		timerDisintegrationBeamCD:Start(186)
	else
		timerLightSpectrumCD:Start(39)
		timerDisintegrationBeamCD:Start()
	end
end

local function findBeamJump(spellName, spellId)
	scanTime = scanTime + 1
	for uId in DBM:GetGroupMembers() do
		local name = DBM:GetUnitFullName(uId)
		if spellId == 139202 and DBM:UnitDebuff(uId, spellName) and mod.vb.lastBlue ~= name then
			mod.vb.lastBlue = name
			if name == UnitName("player") then
				if mod:IsDifficulty("lfr25") and mod.Options.specWarnBlueBeam then
					specWarnBlueBeamLFR:Show()
					specWarnBlueBeamLFR:Play("blueyou")
				else
					specWarnBlueBeam:Show()
					specWarnBlueBeam:Play("blueyou")
				end
			end
			if mod.Options.SetIconRays then
				mod:SetIcon(uId, 6)--Square
			end
			return
		elseif spellId == 139204 and DBM:UnitDebuff(uId, spellName) and mod.vb.lastRed ~= name then
			mod.vb.lastRed = name
			if name == UnitName("player") then
				specWarnRedBeam:Show()
				specWarnRedBeam:Play("redyou")
			end
			if mod.Options.SetIconRays then
				mod:SetIcon(uId, 7)--Cross
			end
			return
		end
	end
	if scanTime < 30 then--Scan for 3 sec but not forever.
		mod:Schedule(0.1, findBeamJump, spellName, spellId)--Check again if we didn't return from either debuff (We checked too soon)
	end
end

function mod:OnCombatStart(delay)
	self.vb.lingeringGazeCD = 46
	self.vb.lastRed = nil
	self.vb.lastBlue = nil
	self.vb.lastYellow = nil
	self.vb.spectrumStarted = false
	self.vb.lifeDrained = false
	self.vb.lfrCrimsonFogRevealed = false
	self.vb.lfrAmberFogRevealed = false
	self.vb.lfrAzureFogRevealed = false
	CVAR = nil
	timerHardStareCD:Start(5-delay)
	timerlingeringGazeCD:Start(15.5-delay)
	timerForceOfWillCD:Start(32.3-delay)
	timerLightSpectrumCD:Start(40-delay)
	if self:IsHeroic() then
		timerDarkParasiteCD:Start(-delay)
		timerIceWallCD:Start(127-delay)
		self.vb.firstIcewall = false--On pull, we only get one icewall and the CD behavior of parasite unaltered so we make sure to treat first icewall like a 2nd
	end
	if self:IsDifficulty("lfr25") then
		lfrEngaged = true
		timerLifeDrainCD:Start(151)
		timerDisintegrationBeamCD:Start(161-delay)
	else
		timerDisintegrationBeamCD:Start(135-delay)
	end
	berserkTimer:Start(-delay)
	if self.Options.SetParticle and GetCVar("particleDensity") then
		CVAR = GetCVar("particleDensity")--Cvar was true on pull so we remember that.
		SetCVar("particleDensity", 10)
	end
end

function mod:OnCombatEnd()
	lfrEngaged = false
	if self.Options.SetIconRays and self.vb.lastRed then
		self:SetIcon(self.vb.lastRed, 0)
	end
	if self.Options.SetIconRays and self.vb.lastBlue then
		self:SetIcon(self.vb.lastBlue, 0)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if CVAR then--CVAR was set on pull which means we changed it, change it back
		SetCVar("particleDensity", CVAR)
	end
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 133765 then
		warnHardStare:Show()
		timerHardStareCD:Start()
	elseif spellId == 138467 then
		timerlingeringGazeCD:Start(self.vb.lingeringGazeCD)
	elseif spellId == 136154 and self:IsDifficulty("lfr25") and not self.vb.lfrCrimsonFogRevealed then--Only use in lfr.
		self.vb.lfrCrimsonFogRevealed = true
		specWarnFogRevealed:Show(crimsonFog)
		specWarnFogRevealed:Play("killbigmob")
	elseif spellId == 134587 and self:AntiSpam(3, 3) then
		warnIceWall:Show()
		if self.vb.firstIcewall then--if it's first icewall of a two icewall phase, it alters CD of dark parasite to be 50 seconds after this cast (thus preventing it from ever being a 60 second cd between casts for rest of fight do to beam and ice altering it)
			self.vb.firstIcewall = false
			timerDarkParasiteCD:Start(50)--50-52.5
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 136932 then--Force of Will Precast
		warnForceOfWill:Show(args.destName)
		specWarnForceOfWill:Show()
		specWarnForceOfWill:Play("stilldanger")
		if timerLightSpectrumCD:GetTime() > 22 or timerDisintegrationBeamCD:GetTime() > 110 then--Don't start timer if either beam or spectrum will come first (cause both disable force ability)
			timerForceOfWillCD:Start()
		end
		if args:IsPlayer() then
			yellForceOfWill:Yell()
		end
	elseif spellId == 134122 then--Blue Beam Precas
		self.vb.lingeringGazeCD = not self.vb.spectrumStarted and 25 or 40 -- First spectrum Lingering Gaze CD = 25, second = 40
		self.vb.spectrumStarted = true
		self.vb.lastBlue = args.destName
		if args:IsPlayer() then
			if self:IsDifficulty("lfr25") and self.Options.specWarnBlueBeam then
				specWarnBlueBeamLFR:Show()
				specWarnBlueBeamLFR:Play("blueyou")
			else
				specWarnBlueBeam:Show()
				specWarnBlueBeam:Play("blueyou")
			end
		end
		if self.Options.SetIconRays then
			self:SetIcon(args.destName, 6)--Square
		end
		if self:IsDifficulty("lfr25") then
			self:RegisterShortTermEvents(
				"SPELL_DAMAGE"
			)
		end
		self:Schedule(0.5, warnBeam, self)
	elseif spellId == 134123 then--Red Beam Precast
		self.vb.lastRed = args.destName
		if args:IsPlayer() then
			specWarnRedBeam:Show()
			specWarnRedBeam:Play("redyou")
		end
		if self.Options.SetIconRays then
			self:SetIcon(args.destName, 7)--Cross
		end
	elseif spellId == 134124 then--Yellow Beam Precast
		self.vb.lastYellow = args.destName
		self.vb.totalFogs = 3
		yellowRevealed = 0
		self.vb.lfrCrimsonFogRevealed = false
		self.vb.lfrAmberFogRevealed = false
		self.vb.lfrAzureFogRevealed = false
		timerForceOfWillCD:Cancel()
		if self:IsHeroic() then
			timerObliterateCD:Start()
			if self.vb.lifeDrained then -- Check 1st Beam ended.
				timerIceWallCD:Start(88.5)
			end
		end
		if self:IsDifficulty("heroic10", "heroic25", "lfr25") then
			if args:IsPlayer() then
				specWarnYellowBeam:Show()
				specWarnYellowBeam:Play("yellowyou")
			end
		end
		if self.Options.SetIconRays then
			self:SetIcon(args.destName, 1, 10)--Star (auto remove after 10 seconds because this beam un-tethers one initial person positions it.
		end
	elseif args:IsSpellID(139202, 139204) then
		--The SPELL_CAST_SUCCESS event works, it's the SPELL_AURA_APPLIED/REMOVED events that are busted/
		--SUCCESS has no target. Still have to find target with UnitDebuff checks
		scanTime = 0
		self:Schedule(0.1, findBeamJump, args.spellName, spellId)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 133767 then
		local amount = args.amount or 1
		timerSeriousWound:Start(args.destName)
		if amount >= 5 then
			if args:IsPlayer() then
				specWarnSeriousWound:Show(amount)
				specWarnSeriousWound:Play("stackhigh")
			else
				if not DBM:UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
					specWarnSeriousWoundOther:Show(args.destName)
					specWarnSeriousWoundOther:Play("tauntboss")
				end
			end
		end
	elseif spellId == 133597 and not args:IsDestTypeHostile() then--Dark Parasite (filtering the wierd casts they put on themselves periodicly using same spellid that don't interest us and would mess up cooldowns)
		warnDarkParasite:CombinedShow(0.5, args.destName)
		local _, _, _, _, duration = DBM:UnitDebuff(args.destName, args.spellName)
		timerDarkParasite:Start(duration, args.destName)
		if not self.vb.lifeDrained then--Only time spell ever gets to use it's true 60 second cd without one of the two failsafes altering it. very first phase
			timerDarkParasiteCD:DelayedStart(0.5)
		end
		if self.Options.SetIconOnParasite and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			self:SetSortedIcon("roster", 0.5, args.destName, 5, 3, true)
		end
	elseif spellId == 133598 then--Dark Plague
		local _, _, _, _, duration = DBM:UnitDebuff(args.destName, args.spellName)
		--maybe add a warning/special warning for everyone if duration is too high and many adds expected
		timerDarkPlague:Start(duration, args.destName)
	elseif spellId == 134626 then
		warnLingeringGaze:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnLingeringGaze:Show()
			specWarnLingeringGaze:Play("runout")
			yellLingeringGaze:Yell()
		end
	elseif spellId == 137727 and self.Options.SetIconLifeDrain then -- Life Drain current target. If target warning needed, insert into this block. (maybe very spammy)
		self:SetIcon(args.destName, 8)--Skull
	elseif spellId == 133798 and self.Options.InfoFrame and not self:IsDifficulty("lfr25") then -- Force update
		DBM.InfoFrame:Update()
		if args:IsPlayer() then
			yellLifeDrain:Yell(playerName, args.amount or 1)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 133767 then
		timerSeriousWound:Cancel(args.destName)
	elseif spellId == 137727 and self.Options.SetIconLifeDrain then -- Life Drain current target.
		self:SetIcon(args.destName, 0)
	elseif spellId == 133597 then--Dark Parasite
		if self.Options.SetIconOnParasite then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId, spellName)
	if spellId == 133793 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then--134044
		specWarningGTFO:Show(spellName)
		specWarningGTFO:Play("watchfeet")
	end
	if not lfrEngaged or self.vb.lfrAmberFogRevealed then return end -- To reduce cpu usage normal and heroic.
	if destName == amberFog and not self.vb.lfrAmberFogRevealed then -- Lfr Amger fog do not have CLEU, no unit events and no emote.
		self:UnregisterShortTermEvents()
		self.vb.lfrAmberFogRevealed = true
		specWarnFogRevealed:Show(amberFog)
		specWarnFogRevealed:Play("killbigmob")
	end
end

function mod:SPELL_MISSED(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 133793 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarningGTFO:Show(spellName)
		specWarningGTFO:Play("watchfeet")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 134755 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarningGTFO:Show(spellName)
		specWarningGTFO:Play("watchfeet")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--Blizz doesn't like combat log anymore for some spells
function mod:CHAT_MSG_MONSTER_EMOTE(msg, npc, _, _, target)
	if (npc == crimsonFog or npc == amberFog or npc == azureFog) and self:AntiSpam(1, npc) then
		if npc == azureFog and not self.vb.lfrAzureFogRevealed then
			self.vb.lfrAzureFogRevealed = true--Only one in ALL modes, so might as well use this to work around the multi emote blizz bug
			specWarnFogRevealed:Show(npc)
			specWarnFogRevealed:Play("killbigmob")
		elseif npc == amberFog and not self:IsDifficulty("lfr25") then
			yellowRevealed = yellowRevealed + 1
			if yellowRevealed > 2 and self:AntiSpam(10, npc) or yellowRevealed < 3 then--Fix for invisible amber blizz bug (when this happens it spams emote like 20 times)
				specWarnFogRevealed:Show(npc)
				specWarnFogRevealed:Play("killbigmob")
			end
		elseif npc == crimsonFog and not self:IsDifficulty("lfr25") then
			specWarnFogRevealed:Show(npc)
			specWarnFogRevealed:Play("killbigmob")
		end
	elseif msg:find("spell:133795") and target then--Does show in combat log, but emote gives targetname 3 seconds earlier.
		target = DBM:GetUnitFullName(target) or target
		if self.Options.SpecWarn133795target then
			specWarnLifeDrain:Show(target)
			specWarnLifeDrain:Play("helpsoak")
		else
			warnLifeDrain:Show(target)
		end
		timerLifeDrain:Start()
		timerLifeDrainCD:Start(not self.vb.lifeDrained and 50 or nil)--first is 50, 2nd and later is 40
		self.vb.lifeDrained = true
		if target and self.Options.SetIconLifeDrain then
			self:SetIcon(target, 8)--Skull
		end
		if self.Options.InfoFrame and not self:IsDifficulty("lfr25") then
			DBM.InfoFrame:SetHeader(lifeDrain)
			DBM.InfoFrame:Show(5, "playerdebuffstacks", lifeDrain)
			self:Schedule(21, HideInfoFrame)
		end
	elseif msg:find("spell:134169") then
		self.vb.lingeringGazeCD = 46 -- Return to Original CD.
		timerForceOfWillCD:Cancel()
		timerlingeringGazeCD:Cancel()
		timerLifeDrainCD:Cancel()
		timerDarkParasiteCD:Cancel()
		specWarnDisintegrationBeam:Show()
		specWarnDisintegrationBeam:Play("specialsoon")
		--Best to start next phase bars when this one ends, so artifically create a "phase end" trigger
		timerDisintegrationBeam:Start()
		self:Schedule(55, BeamEnded, self)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 69050 then--Crimson Fog
		self.vb.totalFogs = self.vb.totalFogs - 1
		if self.vb.totalFogs >= 1 then
			warnAddsLeft:Show(self.vb.totalFogs)
		else--No adds left, force ability is re-enabled
			self:Unschedule(findBeamJump)
			timerObliterateCD:Cancel()
			timerForceOfWillCD:Start(15)
			if self.Options.SetIconRays and self.vb.lastRed then
				self:SetIcon(self.vb.lastRed, 0)
			end
			if self.Options.SetIconRays and self.vb.lastBlue then
				self:SetIcon(self.vb.lastBlue, 0)
			end
			self.vb.lastRed = nil
			self.vb.lastBlue = nil
			self.vb.lastYellow = nil
		end
	elseif cid == 69051 then--Amber Fog
		--Maybe do something for heroic here too, if timers for the crap this thing does gets added.
		if self:IsDifficulty("lfr25") then
			self.vb.totalFogs = self.vb.totalFogs - 1
			if self.vb.totalFogs >= 1 then
				--LFR does something completely different than kill 3 crimson adds to end phase. in LFR, they kill 1 of each color (which is completely against what you do in 10N, 25N, 10H, 25H)
				warnAddsLeft:Show(self.vb.totalFogs)
			else--No adds left, force ability is re-enabled
				timerObliterateCD:Cancel()
				timerForceOfWillCD:Start(15)
				if self.Options.SetIconRays and self.vb.lastRed then
					self:SetIcon(self.vb.lastRed, 0)
				end
				if self.Options.SetIconRays and self.vb.lastBlue then
					self:SetIcon(self.vb.lastBlue, 0)
				end
				self.vb.lastRed = nil
				self.vb.lastBlue = nil
				self.vb.lastYellow = nil
			end
		end
	elseif cid == 69052 then--Azure Fog (endlessly respawn in all but LFR, so we ignore them dying anywhere else)
		if self:IsDifficulty("lfr25") then
			self.vb.totalFogs = self.vb.totalFogs - 1
			if self.vb.totalFogs >= 1 then
				--LFR does something completely different than kill 3 crimson adds to end phase. in LFR, they kill 1 of each color (which is completely against what you do in 10N, 25N, 10H, 25H)
				warnAddsLeft:Show(self.vb.totalFogs)
			else--No adds left, force ability is re-enabled
				timerObliterateCD:Cancel()
				timerForceOfWillCD:Start(15)
				if self.Options.SetIconRays and self.vb.lastRed then
					self:SetIcon(self.vb.lastRed, 0)
				end
				if self.Options.SetIconRays and self.vb.lastBlue then
					self:SetIcon(self.vb.lastBlue, 0)
				end
				self.vb.lastRed = nil
				self.vb.lastBlue = nil
				self.vb.lastYellow = nil
			end
		end
	end
end
