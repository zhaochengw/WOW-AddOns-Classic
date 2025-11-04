local mod	= DBM:NewMod(174, "DBM-Raids-Cata", 5, 73)
local L		= mod:GetLocalizedStrings()
local Nefarian	= DBM:EJ_GetSectionInfo(3279)
local Onyxia	= DBM:EJ_GetSectionInfo(3283)

mod:SetRevision("20241103125714")
mod:SetCreatureID(41376, 41270)
mod:SetEncounterID(1026) -- ES fires when Nefarian engaged.
mod:SetUsedIcons(1, 2, 3)
mod:SetZone(669)
--mod:SetModelSound("Sound\\Creature\\Nefarian\\VO_BD_Nefarian_Event09.ogg", "Sound\\Creature\\Nefarian\\VO_BD_Nefarian_Event13.ogg")
--"Ha ha ha ha ha! The heroes have made it to the glorious finale. I take it you are in good spirits? Prepared for the final battle? Then gaze now upon my ultimate creation! RISE, SISTER!" = "Nefarian\\VO_BD_Nefarian_Event01",
--Long: I have tried to be an accommodating host, but you simply will not die! Time to throw all pretense aside and just... KILL YOU ALL!.
--Short: You really have to want it!

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 77826 80734",
	"SPELL_CAST_SUCCESS 77827",
	"SPELL_AURA_APPLIED 79339 79318",
	"SPELL_AURA_APPLIED_DOSE 80627",
	"SPELL_AURA_REMOVED 79339",
	"SPELL_DAMAGE 81007",
	"SPELL_MISSED 81007",
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_EMOTE"
)

local warnTailSwipe				= mod:NewSpellSourceAnnounce(77827, 3)
local warnShadowflameBreath		= mod:NewSpellSourceAnnounce(77826, 3, nil, "Tank")
local warnCinder				= mod:NewTargetNoFilterAnnounce(79339, 4)
local warnPhase					= mod:NewPhaseChangeAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warnDominion				= mod:NewTargetNoFilterAnnounce(79318, 3)
local warnShadowBlaze			= mod:NewSpellAnnounce(81031, 4)--May be quirky
local warnShadowblazeSoon		= mod:NewAnnounce("warnShadowblazeSoon", 2, 81031, "Tank", nil, true)--Back to on by default for tanks until option isn't tied to sound.

local specWarnElectrocute		= mod:NewSpecialWarningSpell(81198, nil, nil, nil, 2, 2)
local specWarnBlastsNova		= mod:NewSpecialWarningInterruptCount(80734, nil, nil, nil, 1, 2)
local specWarnDominion			= mod:NewSpecialWarningYou(79318, nil, nil, nil, 1, 2)
local specWarnStolenPower		= mod:NewSpecialWarningStack(80627, nil, 150, nil, nil, 1, 6)
local specWarnCinderMove		= mod:NewSpecialWarningMoveAway(79339, nil, nil, nil, 3, 2)
local yellCinder				= mod:NewShortYell(79339)
local yellCinderFades			= mod:NewShortFadesYell(79339)
local specWarnShadowblazeSoon	= mod:NewSpecialWarningPreWarn(81031, "Tank", 5, nil, nil, 1, 2)
local specWarnGTFO				= mod:NewSpecialWarningGTFO(81007, nil, nil, nil, 1, 8)

local timerElectrocute			= mod:NewCastTimer(5, 81198, nil, nil, nil, 2, nil, DBM_COMMON_L.HEALER_ICON)
local timerNefLanding			= mod:NewTimer(30, "timerNefLanding", 78620, nil, nil, 6)
local timerShadowflameBarrage	= mod:NewBuffActiveTimer(150, 78621, nil, nil, nil, 6)
local timerSwipeCD				= mod:NewCDSourceTimer(10, 77827, nil, nil, nil, 3)--10-20 second cd (18 being the most consistent)
local timerBreathCD				= mod:NewCDSourceTimer(12, 77826, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--12-20 second variations
local timerCinderCD				= mod:NewCDTimer(22, 79339, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)--Heroic Ability (Every 22-25 seconds, 25 being most common but we gotta use 22 for timer cause of that small chance it's that).
local timerDominionCD			= mod:NewNextTimer(15, 79318, nil, nil, nil, 3, nil, DBM_COMMON_L.HEROIC_ICON)
local timerShadowBlazeCD		= mod:NewCDTimer(10, 81031, nil, nil, nil, 5, nil, DBM_COMMON_L.TANK_ICON, nil, 2, 4)

local berserkTimer				= mod:NewBerserkTimer(630)

mod:AddSetIconOption("SetIconOnCinder", 79339, true, 0, {1, 2, 3})
mod:AddInfoFrameOption(-3284, true)
mod:AddBoolOption("SetWater", true)

mod.vb.shadowblazeTimer = 35
mod.vb.cinderIcons = 1
local castsPerGUID = {}
local cinderTargets	= {}
local dominionTargets = {}
local lastBlaze = 0--Do NOT use prototype for this, it's updated in a special way using different triggers then when method is called.
local CVAR = false
local shadowBlazeSynced = false
local Charge = DBM:EJ_GetSectionInfo(3284)

--Credits to Caleb for original concept, modified with yell sync and timer tweaks.
function mod:ShadowBlazeFunction()
	lastBlaze = GetTime()
	if self.vb.shadowblazeTimer > 15 then
		self.vb.shadowblazeTimer = self.vb.shadowblazeTimer - 5
	elseif self.vb.shadowblazeTimer > 10 and self:IsDifficulty("heroic10", "heroic25") then
		self.vb.shadowblazeTimer = self.vb.shadowblazeTimer - 5
	end
	warnShadowBlaze:Show()
	specWarnShadowblazeSoon:Schedule(self.vb.shadowblazeTimer - 5)--Pre warning 5 seconds prior to be safe, until we sync timer and know for sure.
	specWarnShadowblazeSoon:ScheduleVoice(self.vb.shadowblazeTimer - 5, "specialsoon")--Maybe better sound?
	if shadowBlazeSynced then
		warnShadowblazeSoon:Schedule(self.vb.shadowblazeTimer - 4, L.ShadowBlazeExact:format(4))
		warnShadowblazeSoon:Schedule(self.vb.shadowblazeTimer - 3, L.ShadowBlazeExact:format(3))
		warnShadowblazeSoon:Schedule(self.vb.shadowblazeTimer - 2, L.ShadowBlazeExact:format(2))
		warnShadowblazeSoon:Schedule(self.vb.shadowblazeTimer - 1, L.ShadowBlazeExact:format(1))
	end
	timerShadowBlazeCD:Start(self.vb.shadowblazeTimer)
	self:ScheduleMethod(self.vb.shadowblazeTimer, "ShadowBlazeFunction")
end

local function warnCinderTargets(self)
	warnCinder:Show(table.concat(cinderTargets, "<, >"))
	timerCinderCD:Start()
	table.wipe(cinderTargets)
	self.vb.cinderIcons = 1
end

local function warnDominionTargets()
	warnDominion:Show(table.concat(dominionTargets, "<, >"))
	timerDominionCD:Start()
	table.wipe(dominionTargets)
end

function mod:OnCombatStart(delay)
	self:SetStage(1)
	shadowBlazeSynced = false
	self.vb.shadowblazeTimer = 35
	CVAR = false
	table.wipe(castsPerGUID)
	table.wipe(cinderTargets)
	table.wipe(dominionTargets)
	timerNefLanding:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		berserkTimer:Start(-delay)
		timerDominionCD:Start(50-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(Charge)
		DBM.InfoFrame:Show(2, "enemypower", 2, ALTERNATE_POWER_INDEX)
	end
	if self.Options.SetWater and GetCVarBool("cameraWaterCollision") then
		CVAR = true--Cvar was true on pull so we remember that.
		SetCVar("cameraWaterCollision", 0)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.SetWater and not GetCVarBool("cameraWaterCollision") and CVAR then--Only turn it back on if it's off now, but it was on when we pulled.
		SetCVar("cameraWaterCollision", 1)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 77826 then
		warnShadowflameBreath:Show(args.sourceName)
		timerBreathCD:Start(nil, args.sourceName)
	elseif args.spellId == 80734 then
		if not castsPerGUID[args.sourceGUID] then
			castsPerGUID[args.sourceGUID] = 0
		end
		castsPerGUID[args.sourceGUID] = castsPerGUID[args.sourceGUID] + 1
		local count = castsPerGUID[args.sourceGUID]
		if self:CheckInterruptFilter(args.sourceGUID, false, false) then--Count interrupt, so cooldown is not checked
			specWarnBlastsNova:Show(args.sourceName, count)
			if count < 6 then
				specWarnBlastsNova:Play("kick"..count.."r")
			else
				specWarnBlastsNova:Play("kickcast")
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 77827 then
		warnTailSwipe:Show(args.sourceName)
		timerSwipeCD:Start(nil, args.sourceName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 79339 then
		cinderTargets[#cinderTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnCinderMove:Schedule(3)
			specWarnCinderMove:ScheduleVoice(3, "runout")
			yellCinder:Yell()
			yellCinderFades:Countdown(args.spellId)
		end
		if self.Options.SetIconOnCinder then
			self:SetIcon(args.destName, self.vb.cinderIcons)
		end
		self.vb.cinderIcons = self.vb.cinderIcons + 1
		self:Unschedule(warnCinderTargets)
		if (self:IsDifficulty("heroic25") and #cinderTargets >= 3) or (self:IsDifficulty("heroic10") and #cinderTargets >= 1) then
			warnCinderTargets(self)
		else
			self:Schedule(0.3, warnCinderTargets, self)
		end
	elseif args.spellId == 79318 then
		dominionTargets[#dominionTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnDominion:Show()
			specWarnDominion:Play("findmc")
		end
		self:Unschedule(warnDominionTargets)
		if (self:IsDifficulty("heroic25") and #dominionTargets >= 5) or (self:IsDifficulty("heroic10") and #dominionTargets >= 2) then
			warnDominionTargets()
		else
			self:Schedule(0.3, warnDominionTargets)
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 80627 and args:IsPlayer() and (args.amount or 1) >= 150 then
		specWarnStolenPower:Show(args.amount)
		specWarnStolenPower:Play("stackhigh")
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 79339 then
		if args:IsPlayer() then
			yellCinderFades:Cancel()
		end
		if self.Options.SetIconOnCinder then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, sourceFlags, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 81007 and destGUID == UnitGUID("player") and self:AntiSpam(4) then
		specWarnGTFO:Show(spellName)
		specWarnGTFO:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		if self.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
		self:SetStage(2)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(2))
		warnPhase:Play("ptwo")
		timerSwipeCD:Cancel()
		timerBreathCD:Cancel()
		timerDominionCD:Cancel()
		timerShadowflameBarrage:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerCinderCD:Start(11.5)--10+ cast, since we track application not cast.
		end
	elseif msg == L.YellPhase3 or msg:find(L.YellPhase3) then
		lastBlaze = 0
		self:SetStage(3)
		warnPhase:Show(DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.stage:format(3))
		warnPhase:Play("pthree")
		timerCinderCD:Cancel()
		timerShadowflameBarrage:Cancel()
		timerShadowBlazeCD:Start(12)--Seems to vary some, 12 should be a happy medium, it can be off 1-2 seconds though.
		self:ScheduleMethod(12, "ShadowBlazeFunction")
	elseif msg == L.YellShadowBlaze or msg:find(L.YellShadowBlaze) then--He only does this sometimes, it's not a trigger to replace loop, more so to correct it.
		shadowBlazeSynced = true
		self:UnscheduleMethod("ShadowBlazeFunction")--Unschedule any running stuff
		specWarnShadowblazeSoon:Cancel()--^^
		specWarnShadowblazeSoon:CancelVoice()
		timerShadowBlazeCD:Stop()--^^ Auto corrections still occur more then once, lets make sure to unschedule audio countdown as well so we don't start getting 2 running.
		if GetTime() - lastBlaze <= 3 then--The blaze timer is too fast, since the actual cast happened immediately after the method ran. So reschedule functions using last timing which should be right just a little fast. :)
			specWarnShadowblazeSoon:Schedule(self.vb.shadowblazeTimer - 5)
			specWarnShadowblazeSoon:ScheduleVoice(self.vb.shadowblazeTimer - 5, "specialsoon")--Maybe better sound?
			warnShadowblazeSoon:Schedule(self.vb.shadowblazeTimer - 4, L.ShadowBlazeExact:format(4))
			warnShadowblazeSoon:Schedule(self.vb.shadowblazeTimer - 3, L.ShadowBlazeExact:format(3))
			warnShadowblazeSoon:Schedule(self.vb.shadowblazeTimer - 2, L.ShadowBlazeExact:format(2))
			warnShadowblazeSoon:Schedule(self.vb.shadowblazeTimer - 1, L.ShadowBlazeExact:format(1))
			timerShadowBlazeCD:Start(self.vb.shadowblazeTimer)
			self:ScheduleMethod(self.vb.shadowblazeTimer, "ShadowBlazeFunction")
		elseif GetTime() - lastBlaze >= 6 then--It's been a considerable amount of time since last blaze, which means timer is slow cause he cast it before a new time stamp could be created.
			self:ShadowBlazeFunction()--run function immediately, the function will handle the rest.
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if (msg == L.NefAoe or msg:find(L.NefAoe)) and self:IsInCombat() then
		specWarnElectrocute:Show()
		specWarnElectrocute:Play("aesoon")
		timerElectrocute:Start()
	end
end
