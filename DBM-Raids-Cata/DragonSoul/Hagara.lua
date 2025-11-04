local mod	= DBM:NewMod(317, "DBM-Raids-Cata", 1, 187)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25,heroic,heroic25,lfr"

mod:SetRevision("20250720212354")
mod:SetCreatureID(55689)
mod:SetEncounterID(1296)
mod:SetUsedIcons(3, 4, 5, 6, 7, 8)
mod:SetZone(967)
--mod:SetModelSound("sound\\CREATURE\\HAGARA\\VO_DS_HAGARA_INTRO_01.OGG", "sound\\CREATURE\\HAGARA\\VO_DS_HAGARA_CRYSTALDEAD_05.OGG")

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 104451 107851 110317 109325",
	"SPELL_AURA_APPLIED_DOSE 105316",
	"SPELL_AURA_REMOVED 104451 105256 105311 105482 105409",
	"SPELL_CAST_START 104448 105256 105409 105289",
	"SPELL_CAST_SUCCESS 109557",
	"SPELL_SUMMON 105297"
)

local warnShatteringIce		= mod:NewTargetAnnounce(105289, 3, nil, "Healer")--3 second cast, give a healer a heads up of who's about to be kicked in the face.
local warnIceLance			= mod:NewTargetAnnounce(105269, 3)
local warnFrostTombCast		= mod:NewAnnounce("warnFrostTombCast", 4, 104448)--Can't use a generic, cause it's an 8 second cast even though it says 1second in tooltip.
local warnFrostTomb			= mod:NewTargetAnnounce(104451, 4)
local warnFrostflake		= mod:NewTargetAnnounce(109325, 3, nil, "Healer")--Spammy, only a dispeller really needs to know this, probably a healer assigned to managing it.
local warnStormPillars		= mod:NewSpellAnnounce(109557, 3, nil, false)--Spammy, off by default (since we can't get a target anyways.
local warnPillars			= mod:NewAnnounce("WarnPillars", 2, 105311)

local specWarnAssault		= mod:NewSpecialWarningDefensive(107851, nil, nil, nil, 1, 2)
local specWarnShattering	= mod:NewSpecialWarningYou(105289, nil, nil, nil, 1, 2)
local specWarnIceLance		= mod:NewSpecialWarningStack(105316, nil, 3, nil, nil, 1, 6)
local specWarnTempest		= mod:NewSpecialWarningSpell(105256, nil, nil, nil, 2, 2)
local specWarnLightingStorm	= mod:NewSpecialWarningSpell(105465, nil, nil, nil, 2, 2)
local specWarnWatery		= mod:NewSpecialWarningGTFO(110317, nil, nil, nil, 1, 8)
local specWarnFrostflake	= mod:NewSpecialWarningMoveAway(109325, nil, nil, nil, 1, 2)
local yellFrostflake		= mod:NewYell(109325)

local timerAssault			= mod:NewBuffActiveTimer(5, 107851, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerAssaultCD		= mod:NewCDCountTimer(15, 107851, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerShatteringCD		= mod:NewVarTimer("v10.5-15", 105289, nil, nil, nil, 3)--every 10.5-15 seconds
local timerIceLance			= mod:NewBuffActiveTimer(15, 105269)
local timerIceLanceCD		= mod:NewNextTimer(30, 105269, nil, nil, nil, 5)
local timerFrostTomb		= mod:NewCastTimer(8, 104448, nil, nil, nil, 3)
local timerFrostTombCD		= mod:NewNextTimer(20, 104451, nil, nil, nil, 3)
local timerSpecialCD		= mod:NewTimer(62, "TimerSpecial", "136116", nil, nil, 6, nil, nil, 1, 4)
local timerTempestCD		= mod:NewNextTimer(62, 105256, nil, nil, nil, 6, nil, nil, nil, 1, 4)
local timerLightningStormCD	= mod:NewNextTimer(62, 105465, nil, nil, nil, 6, nil, nil, nil, 1, 4)
local timerFrostFlakeCD		= mod:NewNextTimer(5, 109325, nil, nil, nil, 3)--^
local timerStormPillarCD	= mod:NewNextTimer(5, 109557, nil, nil, nil, 3)--Both of these are just spammed every 5 seconds on new targets.
local timerFeedback			= mod:NewBuffActiveTimer(15, 108934)

local berserkTimer			= mod:NewBerserkTimer(480)

mod:AddSetIconOption("SetIconOnFrostflake", 109325, false, 0, {3})
mod:AddSetIconOption("SetIconOnFrostTomb", 104451, true, 0, {3, 4, 5, 6, 7, 8})
mod:AddBoolOption("SetBubbles", true)--because chat bubble hides Ice Tomb target indication if bubbles are on.

local lanceTargets = {}
local tombTargets = {}
local tombIconTargets = {}
local firstPhase = true
local iceFired = false
mod.vb.assaultCount = 0
mod.vb.pillarsRemaining = 4
local frostPillar = DBM:EJ_GetSectionInfo(4069)
local lightningPillar = DBM:EJ_GetSectionInfo(3919)
local CVAR = false
local CVAR2 = false

function mod:ShatteredIceTarget()
	local targetname = self:GetBossTarget(55689)
	if not targetname then return end
	timerShatteringCD:Start()
	if UnitName("player") == targetname then
		specWarnShattering:Show()
		specWarnShattering:Play("targetyou")
	else
		warnShatteringIce:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(lanceTargets)
	table.wipe(tombIconTargets)
	table.wipe(tombTargets)
	firstPhase = true
	iceFired = false
	self.vb.assaultCount = 0
	timerAssaultCD:Start(4-delay, 1)
	timerIceLanceCD:Start(10-delay)
	timerSpecialCD:Start(30-delay)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.SetBubbles and not GetCVarBool("chatBubbles") and CVAR then--Only turn them back on if they are off now, but were on when we pulled
		SetCVar("chatBubbles", 1)
		CVAR = false
	end
	if self.Options.SetBubbles and not GetCVarBool("chatBubblesParty") and CVAR2 then--Only turn them back on if they are off now, but were on when we pulled
		SetCVar("chatBubblesParty", 1)
		CVAR2 = false
	end
end

local function warnLanceTargets()
	warnIceLance:Show(table.concat(lanceTargets, "<, >"))
	timerIceLance:Start()
	if not firstPhase and not iceFired then
		timerIceLanceCD:Start()
	end
	iceFired = true
	table.wipe(lanceTargets)
end

local function ClearTombTargets()
	table.wipe(tombIconTargets)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetTombIcons()
		table.sort(tombIconTargets, sort_by_group)
		local tombIcons = 8
		for i, v in ipairs(tombIconTargets) do
			self:SetIcon(v, tombIcons)
			tombIcons = tombIcons - 1
		end
		self:Schedule(8, ClearTombTargets)
	end
end

local function warnTombTargets()
	warnFrostTomb:Show(table.concat(tombTargets, "<, >"))
	table.wipe(tombTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 104451 then
		tombTargets[#tombTargets + 1] = args.destName
		if self.Options.SetIconOnFrostTomb then
			table.insert(tombIconTargets, DBM:GetRaidUnitId(args.destName))
			self:UnscheduleMethod("SetTombIcons")
			if (self:IsDifficulty("normal25") and #tombIconTargets >= 5) or (self:IsDifficulty("heroic25") and #tombIconTargets >= 6) or (self:IsDifficulty("normal10", "heroic10") and #tombIconTargets >= 2) then
				self:SetTombIcons()
			else
				if self:LatencyCheck() then--Icon sorting is still sensitive and should not be done by laggy members that don't have all targets.
					self:ScheduleMethod(0.3, "SetTombIcons")
				end
			end
		end
		self:Unschedule(warnTombTargets)
		if (self:IsDifficulty("normal25") and #tombTargets >= 5) or (self:IsDifficulty("heroic25") and #tombTargets >= 6) or (self:IsDifficulty("normal10", "heroic10") and #tombTargets >= 2) then
			warnTombTargets()
		else
			self:Schedule(0.3, warnTombTargets)
		end
	elseif spellId == 107851 then
		self.vb.assaultCount = self.vb.assaultCount + 1
		if self:IsTanking("player", "boss1", nil, true) then
			specWarnAssault:Show()
			specWarnAssault:Play("defensive")
		end
		timerAssault:Start()
		if (firstPhase and self.vb.assaultCount < 2) or (not firstPhase and self.vb.assaultCount < 3) then
			timerAssaultCD:Start(nil, self.vb.assaultCount+1)
		end
	elseif spellId == 110317 and args:IsPlayer() then
		specWarnWatery:Show(args.spellName)
		specWarnWatery:Play("watchfeet")
	elseif spellId == 109325 then
		warnFrostflake:Show(args.destName)
		timerFrostFlakeCD:Start()
		if args:IsPlayer() then
			specWarnFrostflake:Show()
			specWarnFrostflake:Play("runout")
			yellFrostflake:Yell()
		end
		if self.Options.SetIconOnFrostflake then
			self:SetIcon(args.destName, 3)
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 105316 and not self:IsTrivial() then
		local amount = args.amount
		if ((self:IsDifficulty("lfr25") and amount % 6 == 0) or (not self:IsDifficulty("lfr25") and amount % 3 == 0)) and args:IsPlayer() then--Warn every 3 stacks (6 stacks in LFR), don't want to spam TOO much.
			specWarnIceLance:Show(amount)
			specWarnIceLance:Play("stackhigh")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 104451 and self.Options.SetIconOnFrostTomb then
		self:SetIcon(args.destName, 0)
	elseif spellId == 105256 then--Tempest
		if self.Options.SetBubbles and GetCVarBool("chatBubbles") then
			SetCVar("chatBubbles", 0)
			CVAR = true
		end
		if self.Options.SetBubbles and GetCVarBool("chatBubblesParty") then
			SetCVar("chatBubblesParty", 0)
			CVAR2 = true
		end
		timerFrostFlakeCD:Cancel()
		timerIceLanceCD:Start(12)
		timerFeedback:Start()
		if not self:IsDifficulty("lfr25") then
			timerFrostTombCD:Start()
		end
		firstPhase = false
		iceFired = false
		self.vb.assaultCount = 0
		timerAssaultCD:Start(nil, 1)
		timerLightningStormCD:Start()
	elseif spellId == 105311 then--Frost defeated.
		self.vb.pillarsRemaining = self.vb.pillarsRemaining - 1
		warnPillars:Show(frostPillar, self.vb.pillarsRemaining)
	elseif spellId == 105482 then--Lighting defeated.
		self.vb.pillarsRemaining = self.vb.pillarsRemaining - 1
		warnPillars:Show(lightningPillar, self.vb.pillarsRemaining)
	elseif spellId == 105409 then--Water Shield
		if self.Options.SetBubbles and GetCVarBool("chatBubbles") then
			SetCVar("chatBubbles", 0)
			CVAR = true
		end
		if self.Options.SetBubbles and GetCVarBool("chatBubblesParty") then
			SetCVar("chatBubblesParty", 0)
			CVAR2 = true
		end
		timerStormPillarCD:Cancel()
		timerIceLanceCD:Start(12)
		timerFeedback:Start()
		if not self:IsDifficulty("lfr25") then
			timerFrostTombCD:Start()
		end
		firstPhase = false
		iceFired = false
		self.vb.assaultCount = 0
		timerAssaultCD:Start(nil, 1)
		timerTempestCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 104448 then
		warnFrostTombCast:Show(args.spellName)
		timerFrostTomb:Start()
	elseif spellId == 105256 then--Tempest
		if self.Options.SetBubbles and not GetCVarBool("chatBubbles") and CVAR then--Only turn them back on if they are off now, but were on when we pulled
			SetCVar("chatBubbles", 1)
			CVAR = false
		end
		if self.Options.SetBubbles and not GetCVarBool("chatBubblesParty") and CVAR2 then--Only turn them back on if they are off now, but were on when we pulled
			SetCVar("chatBubblesParty", 1)
			CVAR2 = false
		end
		self.vb.pillarsRemaining = 4
		timerAssaultCD:Cancel()
		timerIceLanceCD:Cancel()
		timerShatteringCD:Cancel()
		specWarnTempest:Show()
		specWarnTempest:Play("phasechange")
	elseif spellId == 105409 then--Water Shield
		if self.Options.SetBubbles and not GetCVarBool("chatBubbles") and CVAR then--Only turn them back on if they are off now, but were on when we pulled
			SetCVar("chatBubbles", 1)
			CVAR = false
		end
		if self.Options.SetBubbles and not GetCVarBool("chatBubblesParty") and CVAR2 then--Only turn them back on if they are off now, but were on when we pulled
			SetCVar("chatBubblesParty", 1)
			CVAR2 = false
		end
		if self:IsDifficulty("heroic10") then
			self.vb.pillarsRemaining = 8
		else
			self.vb.pillarsRemaining = 4
		end
		timerAssaultCD:Cancel()
		timerIceLanceCD:Cancel()
		timerShatteringCD:Cancel()
		specWarnLightingStorm:Show()
		specWarnLightingStorm:Play("aesoon")
	elseif spellId == 105289 then
		self:ScheduleMethod(0.2, "ShatteredIceTarget")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 109557 then
		warnStormPillars:Show()
		timerStormPillarCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	local spellId = args.spellId
	if spellId == 105297 then
		lanceTargets[#lanceTargets + 1] = args.sourceName
		self:Unschedule(warnLanceTargets)
		self:Schedule(0.5, warnLanceTargets)
	end
end
