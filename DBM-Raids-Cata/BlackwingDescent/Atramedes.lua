local mod	= DBM:NewMod(171, "DBM-Raids-Cata", 5, 73)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241103125714")
mod:SetCreatureID(41442)
mod:SetEncounterID(1022)
mod:SetUsedIcons(8)
mod:SetZone(669)
--mod:SetModelSound("Sound\\Creature\\Nefarian\\VO_BD_Nefarian_AtramedesIntro.ogg", "Sound\\Creature\\Atramedes\\VO_BD_Atramedes_Event03.ogg")
--Long: Atramedes, are you going deaf as well as blind? Hurry up and kill them all.
--Short: Death waits in the darkness!

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 92677",
	"SPELL_CAST_SUCCESS 78075 77840 92681 77672",
	"SPELL_AURA_APPLIED 78092",
	"SPELL_AURA_REMOVED 78092 92681",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_AURA player"
)

--TODO, see if phasing can be done without yells. Transcriptor was broken during OG 4.0 and not recording USCS events and that was fixed in firelands. THis means all of 4.0 needs re-evaluating
local warnSonicBreath		= mod:NewSpellAnnounce(78075, 3)
local warnTracking			= mod:NewTargetNoFilterAnnounce(78092, 4)
local warnAirphase			= mod:NewSpellAnnounce(-3081, 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnGroundphase		= mod:NewSpellAnnounce(-3061, 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnShieldsLeft		= mod:NewAddsLeftAnnounce(-3073, 2, 77611)
local warnAddSoon			= mod:NewSoonAnnounce(-3082, 3, 92685)
local warnPhaseShift		= mod:NewSpellAnnounce(92681, 3)
local warnObnoxious			= mod:NewCastAnnounce(92677, 4, nil, nil, false)
local warnSearingFlameSoon	= mod:NewSoonAnnounce(77840, 3)

local specWarnSearingFlame	= mod:NewSpecialWarningCount(77840, nil, nil, nil, 2, 2)
local specWarnSonarPulse	= mod:NewSpecialWarningDodge(77672, nil, nil, nil, 2, 2)
local specWarnTracking		= mod:NewSpecialWarningRun(78092, nil, nil, nil, 4, 2)
local specWarnPestered		= mod:NewSpecialWarningYou(92685, nil, nil, nil, 1, 2)
local yellPestered			= mod:NewYell(92685)
local specWarnObnoxious		= mod:NewSpecialWarningInterrupt(92677, "HasInterrupt", nil, nil, 1, 2)
local specWarnAddTargetable	= mod:NewSpecialWarningSwitch(92677, "Ranged", nil, nil, 1, 2)

local timerSonarPulseCD		= mod:NewCDTimer(10, 77672, nil, nil, nil, 3)
local timerSonicBreath		= mod:NewCDTimer(41, 78075, nil, nil, nil, 3)
local timerSearingFlame		= mod:NewCDTimer(45, 77840, nil, nil, nil, 2)
local timerAirphase			= mod:NewNextTimer(85, -3081, nil, nil, nil, 6, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")--These both need more work
local timerGroundphase		= mod:NewNextTimer(31.5, -3061, nil, nil, nil, 6, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")--I just never remember to log and /yell at right times since they lack most accurate triggers.

local berserkTimer			= mod:NewBerserkTimer(600)

mod:AddSetIconOption("TrackingIcon", 78092, true, 0, {8})
mod:AddInfoFrameOption(-3072, true)

mod.vb.shieldsLeft = 10
mod.vb.searingCount = 0
local SoundLevel = DBM:EJ_GetSectionInfo(3072)

local function groundphase(self)
	timerAirphase:Start()
	timerSonicBreath:Start(25)
	warnSearingFlameSoon:Schedule(40)
	timerSearingFlame:Start(nil, self.vb.searingCount+1)--45
end

function mod:OnCombatStart(delay)
	self.vb.shieldsLeft = 10
	self.vb.searingCount = 0
	timerSonarPulseCD:Start(-delay)
	timerSonicBreath:Start(25-delay)
	warnSearingFlameSoon:Schedule(40-delay)
	timerSearingFlame:Start(-delay, 1)
	timerAirphase:Start(90-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		berserkTimer:Start(-delay)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(SoundLevel)
		DBM.InfoFrame:Show(5, "playerpower", 10, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 92677 then
		if self.Options.SpecWarn92677interrupt and self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnObnoxious:Show(args.sourceName)--Only warn for melee targeting him or exclicidly put him on focus, else warn regardless if he's your target/focus or not if you aren't a melee
			specWarnObnoxious:Play("kickcast")
		else
			warnObnoxious:Show()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 78075 then
		timerSonicBreath:Start()
		warnSonicBreath:Show()
	elseif args.spellId == 77840 then
		self.vb.searingCount = self.vb.searingCount + 1
		specWarnSearingFlame:Show(self.vb.searingCount)
		specWarnSearingFlame:Play("aesoon")
	elseif args.spellId == 92681 then--Add is phase shifting which means a new one is spawning, or an old one is changing target cause their first target died.
		warnPhaseShift:Show()
	elseif args.spellId == 77672 then--Sonar Pulse (the discs)
		specWarnSonarPulse:Show()
		specWarnSonarPulse:Play("watchstep")
		timerSonarPulseCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 78092 then
		if args:IsPlayer() then
			specWarnTracking:Show()
			specWarnTracking:Play("runout")
		else
			warnTracking:Show(args.destName)
		end
		if self.Options.TrackingIcon then
			self:SetIcon(args.destName, 8)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 78092 then
		if self.Options.TrackingIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 92681 then--Phase shift removed, add targetable/killable.
		specWarnAddTargetable:Show()
		specWarnAddTargetable:Play("killmob")
	end
end

function mod:UNIT_DIED(args)
	if self:IsInCombat() and args:IsNPC() and self:GetCIDFromGUID(args.destGUID) ~= 49740 then
		self.vb.shieldsLeft = self.vb.shieldsLeft - 1
		warnShieldsLeft:Show(self.vb.shieldsLeft)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Airphase or msg:find(L.Airphase)  then
		warnAirphase:Show()
		timerSonicBreath:Cancel()
		timerSonarPulseCD:Cancel()
		timerGroundphase:Start()
		self:Schedule(31.5, groundphase, self)
	elseif msg == L.NefAdd or msg:find(L.NefAdd)  then
		warnAddSoon:Show()--Unfortunately it seems quite random when he does this so i cannot add a CD bar for it. i see variations as large as 20 seconds in between to a minute in between.
	end
end

do
	local pestered = DBM:GetSpellName(92685)--TODO, if can verify exact spellID then no reason to localize spellname, just pass ID in unitDebuff
	local pesteredWarned = false
	function mod:UNIT_AURA(uId)
		local isPestered = DBM:UnitDebuff("player", pestered)
		if isPestered and not pesteredWarned then
			pesteredWarned = true--This aura is a periodic trigger, so we don't want to spam warn for it.
			specWarnPestered:Show()
			specWarnPestered:Play("targetyou")
			yellPestered:Yell()
		elseif pesteredWarned and not isPestered then
			pesteredWarned = false
		end
	end
end
