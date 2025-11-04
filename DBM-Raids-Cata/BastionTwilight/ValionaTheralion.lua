local mod	= DBM:NewMod(157, "DBM-Raids-Cata", 4, 72)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20241115112135")
mod:SetCreatureID(45992, 45993)
mod:SetEncounterID(1032)
mod:SetUsedIcons(1, 2, 3, 8)
mod:SetZone(671)
--mod:SetModelSound("Sound\\Creature\\Chogall\\VO_BT_Chogall_BotEvent10.ogg", "Sound\\Creature\\Valiona\\VO_BT_Valiona_Event06.ogg")
--Long: Valiona, Theralion put them in their place!
--Short: Enter twilight!

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 86840 90950 86408 86369",
	"SPELL_AURA_APPLIED 86788 86622 93051 86214",
	"SPELL_AURA_APPLIED_DOSE 86788 86622 93051 86214",--No idea which IDs are actually used by dose, so using all
	"SPELL_AURA_REFRESH 86788 86622 93051 86214",--No idea which IDs are actually used by refresh, so using all
	"SPELL_AURA_REMOVED 86788 86622 93051",
	"SPELL_DAMAGE 86505",
	"SPELL_MISSED 86505",
--	"SPELL_HEAL",--Why were these registered, they aren't even used
--	"SPELL_PERIODIC_HEAL",--Why were these registered, they aren't even used
	"RAID_BOSS_EMOTE",
	"UNIT_AURA player",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

--TODO, fix RAID_BOSS_EMOTE so it's not easily broken by onyxian whelpling pets being out
--Valiona Ground Phase
local warnBlackout					= mod:NewTargetNoFilterAnnounce(86788, 3)
local warnDazzlingDestruction		= mod:NewCountAnnounce(86408, 4)--Used by Theralion just before landing
--Theralion Ground Phase
local warnFabFlames					= mod:NewTargetAnnounce(86505, 3)
local warnEngulfingMagic			= mod:NewTargetAnnounce(86622, 3)
local warnDeepBreath				= mod:NewCountAnnounce(86059, 4)--Used by Valiona just before landing

local warnTwilightShift				= mod:NewStackAnnounce(93051, 2)

--Valiona Ground Phase
local specWarnDevouringFlames		= mod:NewSpecialWarningRun(86840, nil, nil, nil, 4, 2)
local specWarnDazzlingDestruction	= mod:NewSpecialWarningSpell(86408, nil, nil, nil, 2, 2)
local specWarnBlackout				= mod:NewSpecialWarningYou(86788, nil, nil, nil, 1, 2)
mod:AddBoolOption("TBwarnWhileBlackout", false, "announce")
local specWarnTwilightBlast			= mod:NewSpecialWarningMove(86369, false, nil, nil, 1, 2)
local yellTwilightBlast				= mod:NewYell(86369, nil, false)
--Theralion Ground Phase
local specWarnDeepBreath			= mod:NewSpecialWarningDodge(86059, nil, nil, nil, 2, 2)
local specWarnFabulousFlames		= mod:NewSpecialWarningMove(86505, nil, nil, nil, 2, 8)
local yellFabFlames					= mod:NewYell(86505)
local specWarnTwilightMeteorite		= mod:NewSpecialWarningYou(86013, nil, nil, nil, 1, 2)
local yellTwilightMeteorite			= mod:NewYell(86013, false, nil, nil, "YELL")
local specWarnEngulfingMagic		= mod:NewSpecialWarningMoveAway(86622, nil, nil, nil, 3, 2)
local yellEngulfingMagic			= mod:NewYell(86622)

local specWarnTwilightZone			= mod:NewSpecialWarningStack(86214, nil, 20, nil, nil, 1, 6)

--Valiona Ground Phase
local timerBlackout					= mod:NewTargetTimer(15, 86788, nil, nil, nil, 5, nil, DBM_COMMON_L.MAGIC_ICON..DBM_COMMON_L.HEALER_ICON)
local timerBlackoutCD				= mod:NewCDTimer(45.5, 86788, nil, nil, nil, 3, nil, DBM_COMMON_L.MAGIC_ICON..DBM_COMMON_L.DEADLY_ICON)
local timerDevouringFlamesCD		= mod:NewCDTimer(40, 86840, nil, nil, nil, 3)
local timerNextDazzlingDestruction	= mod:NewNextTimer(132, 86408, nil, nil, nil, 3)
--Theralion Ground Phase
local timerTwilightMeteorite		= mod:NewCastTimer(6, 86013, nil, nil, nil, 5)
local timerEngulfingMagic			= mod:NewBuffFadesTimer(20, 86622, nil, nil, nil, 5)
local timerEngulfingMagicNext		= mod:NewCDTimer(35, 86622, nil, nil, nil, 3)--30-40 second variations.
local timerNextFabFlames			= mod:NewNextTimer(15, 86505, nil, nil, nil, 3)
local timerNextDeepBreath			= mod:NewNextTimer(98, 86059, nil, nil, nil, 3)

local timerTwilightShift			= mod:NewTargetTimer(100, 93051, nil, "Tank", 2, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerTwilightShiftCD			= mod:NewCDTimer(20, 93051, nil, "Tank|Healer", 2, 5, nil, DBM_COMMON_L.TANK_ICON)

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddSetIconOption("BlackoutIcon", 86788, true, 0, {8})
mod:AddSetIconOption("EngulfingIcon", 86622, true, 0, {1, 2, 3})
mod:AddInfoFrameOption(86788, true)

mod.vb.blackoutCount = 0
mod.vb.engulfingMagicIcon = 1
mod.vb.dazzlingCast = 0
mod.vb.breathCast = 0
mod.vb.ValionaLanded = false
local engulfingMagicTargets = {}
local markWarned = false--Personal, do not sync

local function showEngulfingMagicWarning(self)
	warnEngulfingMagic:Show(table.concat(engulfingMagicTargets, "<, >"))
	timerEngulfingMagic:Start()
	table.wipe(engulfingMagicTargets)
	self.vb.engulfingMagicIcon = 1
end

local function valionaDelay(self)
	timerEngulfingMagicNext:Cancel()
	timerBlackoutCD:Start(10)
	timerDevouringFlamesCD:Start(25)
end

local function theralionDelay(self)
	timerDevouringFlamesCD:Cancel()
	timerBlackoutCD:Cancel()
	timerNextFabFlames:Start(10)
	timerEngulfingMagicNext:Start(15)
	timerNextDeepBreath:Start()
	self.vb.ValionaLanded = false
end

local function AMSTimerDelay()
	timerTwilightShiftCD:Start()
end

function mod:FabFlamesTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		if self:AntiSpam(2, 3) then--Trigger the anti spam here so when we pre warn it thrown at them we don't double warn them again for taking 1 tick of it when it lands.
			specWarnFabulousFlames:Show()
			specWarnFabulousFlames:Play("targetyou")
		end
		yellFabFlames:Yell()
	else
		warnFabFlames:Show(targetname)
	end
end

function mod:TwilightBlastTarget(targetname, uId)
	if not targetname then return end
	if self.Options.TBwarnWhileBlackout or self.vb.blackoutCount == 0 then
		if targetname == UnitName("player") then
			specWarnTwilightBlast:Show()
			specWarnTwilightBlast:Play("targetyou")
			yellTwilightBlast:Yell()
		end
	end
end

function mod:OnCombatStart(delay)
	markWarned = false
	self.vb.engulfingMagicIcon = 1
	berserkTimer:Start(-delay)
	timerBlackoutCD:Start(10-delay)
	timerDevouringFlamesCD:Start(25.5-delay)
	timerNextDazzlingDestruction:Start(85-delay)
	self.vb.blackoutCount = 0
	self.vb.dazzlingCast = 0
	self.vb.breathCast = 0
	self.vb.ValionaLanded = true
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(86840, 90950) then--Strange to have 2 cast ids instead of either 1 or 4
		timerDevouringFlamesCD:Start()
		specWarnDevouringFlames:Show()
		specWarnDevouringFlames:Play("justrun")
	elseif args.spellId == 86408 then
		self.vb.dazzlingCast = self.vb.dazzlingCast + 1
		warnDazzlingDestruction:Show(self.vb.dazzlingCast)
		if self.vb.dazzlingCast == 1 then
			specWarnDazzlingDestruction:Show()
			specWarnDazzlingDestruction:Play("watchstep")
		elseif self.vb.dazzlingCast == 3 then
			self:Schedule(5, theralionDelay, self)--delayed so we don't cancel blackout timer until after 3rd cast.
			self.vb.dazzlingCast = 0
		end
	elseif args.spellId == 86369 then--First cast of this is true phase change, as theralion can still cast his grounded phase abilities until he's fully in air casting this instead.
		self:ScheduleMethod(0.1, "BossTargetScanner", args.sourceGUID, "TwilightBlastTarget", 0.1, 4)
		if not self.vb.ValionaLanded then
			timerNextFabFlames:Cancel()
			self.vb.ValionaLanded = true
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 86788 then
		self.vb.blackoutCount = self.vb.blackoutCount + 1
		timerBlackout:Start(args.destName)
		timerBlackoutCD:Start()
		if self.Options.BlackoutIcon then
			self:SetIcon(args.destName, 8)
		end
		if args:IsPlayer() then
			specWarnBlackout:Show()
			specWarnBlackout:Play("targetyou")
		else
			warnBlackout:Show(args.destName)
		end
		if self.Options.InfoFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(args.spellName)
			DBM.InfoFrame:Show(6, "playerabsorb", args.spellName, select(16, DBM:UnitDebuff(args.destName, args.spellName)))
		end
	elseif args.spellId == 86622 then
		engulfingMagicTargets[#engulfingMagicTargets + 1] = args.destName
		timerEngulfingMagicNext:Start()
		if args:IsPlayer() then
			specWarnEngulfingMagic:Show()
			specWarnEngulfingMagic:Play("runout")
			yellEngulfingMagic:Yell()
		end
		if self.Options.EngulfingIcon then
			self:SetIcon(args.destName, self.vb.engulfingMagicIcon)
		end
		self.vb.engulfingMagicIcon = self.vb.engulfingMagicIcon + 1
		self:Unschedule(showEngulfingMagicWarning)
		if (self:IsDifficulty("heroic25") and #engulfingMagicTargets >= 3) or (self:IsDifficulty("normal25", "heroic10") and #engulfingMagicTargets >= 2) or (self:IsDifficulty("normal10") and #engulfingMagicTargets >= 1) then
			showEngulfingMagicWarning(self)
		else
			self:Schedule(0.3, showEngulfingMagicWarning, self)
		end
	elseif args.spellId == 93051 then
		warnTwilightShift:Show(args.destName, args.amount or 1)
		timerTwilightShift:Cancel(args.destName.." (1)")
		timerTwilightShift:Cancel(args.destName.." (2)")
		timerTwilightShift:Cancel(args.destName.." (3)")
		timerTwilightShift:Cancel(args.destName.." (4)")
		timerTwilightShift:Cancel(args.destName.." (5)")
		timerTwilightShift:Show(args.destName.." ("..tostring(args.amount or 1)..")")
		timerTwilightShiftCD:Start()
		self:Unschedule(AMSTimerDelay)
		self:Schedule(20, AMSTimerDelay)--Cause when a DK AMSes it we don't get another timer.
	elseif args.spellId == 86214 and args:IsPlayer() then
		if (args.amount or 1) >= 20 and self:AntiSpam(5, 1) then
			specWarnTwilightZone:Show(args.amount)
			specWarnTwilightZone:Play("stackhigh")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 86788 then
		self.vb.blackoutCount = self.vb.blackoutCount - 1
		if self.Options.InfoFrame and self.vb.blackoutCount == 0 then
			DBM.InfoFrame:Hide()
		end
		timerBlackout:Cancel(args.destName)
		if self.Options.BlackoutIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 86622 then
		if self.Options.EngulfingIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 93051 then
		timerTwilightShift:Cancel(args.destName.." (1)")
		timerTwilightShift:Cancel(args.destName.." (2)")
		timerTwilightShift:Cancel(args.destName.." (3)")
		timerTwilightShift:Cancel(args.destName.." (4)")
		timerTwilightShift:Cancel(args.destName.." (5)")
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 86505 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnFabulousFlames:Show()
		specWarnFabulousFlames:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE--Absorbs still show as spell missed, such as PWS, but with this you'll still get a special warning to GTFO, instead of dbm waiting til your shield breaks and you take a second tick :)

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Trigger1 or msg:find(L.Trigger1) then--TODO, verify npc as well to filter onyxian whelpling pets?
		self.vb.breathCast = self.vb.breathCast + 1
		warnDeepBreath:Show(self.vb.breathCast)
		if self.vb.breathCast == 1 then
			timerNextDeepBreath:Cancel()
			specWarnDeepBreath:Show()
			specWarnDeepBreath:Play("breathsoon")
			timerNextDazzlingDestruction:Start()
			self:Schedule(40, valionaDelay, self)--We do this cause you get at least one more engulfing magic after this emote before they completely switch so we need a method to cancel bar more appropriately
		elseif self.vb.breathCast == 3 then
			self.vb.breathCast = 0
		end
	end
end

do
	local meteorTarget = DBM:GetSpellName(88518)
	local function markRemoved()
		markWarned = false
	end
	function mod:UNIT_AURA(uId)
		if DBM:UnitDebuff("player", meteorTarget) and not markWarned then--Switch to ID if correct ID is verified
			specWarnTwilightMeteorite:Show()
			specWarnTwilightMeteorite:Play("targetyou")
			timerTwilightMeteorite:Start()
			yellTwilightMeteorite:Yell()
			markWarned = true
			self:Schedule(7, markRemoved)
		end
	end
end

do
	local fabFlames = DBM:GetSpellName(86497)
	function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
		local spellName = DBM:GetSpellName(spellId)--Shit workaround, fix
		local guid = UnitGUID(uId)
		if spellName == fabFlames and not self.vb.ValionaLanded and self:AntiSpam(2, 2) then
			self:ScheduleMethod(0.1, "BossTargetScanner", guid, "FabFlamesTarget", 0.1, 4)
			timerNextFabFlames:Start()
		end
	end
end
