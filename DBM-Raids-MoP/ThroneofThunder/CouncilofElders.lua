local mod	= DBM:NewMod(816, "DBM-Raids-MoP", 2, 362)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20260126031700")
mod:SetCreatureID(69078, 69132, 69134, 69131)--69078 Sul the Sandcrawler, 69132 High Prestess Mar'li, 69131 Frost King Malakk, 69134 Kazra'jin --Adds: 69548 Shadowed Loa Spirit,
mod:SetEncounterID(1570)
mod:SetUsedIcons(7, 6)
mod:SetBossHPInfoToHighest()
mod:SetZone(1098)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 136189 136521 136894 137203 137350 137891 136990",
	"SPELL_AURA_APPLIED 136442 136903 136992 136922 136860 136878 137359 137166 137641",
	"SPELL_AURA_APPLIED_DOSE 136903 136878",
	"SPELL_AURA_REMOVED 136442 136903 136904 137359 136992 136922",
	"SPELL_DAMAGE 136507",
	"SPELL_MISSED 136507",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

local Sul = DBM:EJ_GetSectionInfo(7049)
local Malakk = DBM:EJ_GetSectionInfo(7047)
local Marli = DBM:EJ_GetSectionInfo(7050)
local Kazrajin = DBM:EJ_GetSectionInfo(7048)

--All
local warnPossessed					= mod:NewStackAnnounce(136442, 2, nil, nil, "warnPossessed")

local specWarnPossessed				= mod:NewSpecialWarning("specWarnPossessed", nil, nil, 1, 2)
local specWarnDarkPower				= mod:NewSpecialWarningCount(136507, nil, nil, nil, 2, 2)
local specWarnSoulFragment			= mod:NewSpecialWarningYou(137641, nil, nil, nil, 1, 17)

local timerDarkPowerCD				= mod:NewCDTimer(68, 136507)
local berserkTimer					= mod:NewBerserkTimer(720)

mod:AddBoolOption("AnnounceCooldowns", "RaidCooldown")
--Sul the Sandcrawler
mod:AddTimerLine(Sul)
local warnQuicksand					= mod:NewSpellAnnounce(136521, 2)

local specWarnSandBolt				= mod:NewSpecialWarningInterruptCount(136189, false, nil, nil, 1, 2)
local specWarnSandStorm				= mod:NewSpecialWarningCount(136894, nil, nil, nil, 2, 2)
local specWarnQuickSand				= mod:NewSpecialWarningGTFO(136860, nil, nil, nil, 1, 8)

local timerQuickSandCD				= mod:NewCDTimer(32.7, 136521, nil, nil, nil, 3)
local timerSandStormCD				= mod:NewCDTimer(35, 136894, nil, nil, nil, 2)
--High Prestess Mar'li
mod:AddTimerLine(Marli)
local warnMarkedSoul				= mod:NewTargetNoFilterAnnounce(137359, 4)--Shadowed Loa Spirit fixate target, no need to warn for Shadowed Loa Spirit AND this, so we just warn for this

local specWarnBlessedLoaSpirit		= mod:NewSpecialWarningSwitch(137203, "Dps", nil, nil, 1, 2)
local specWarnShadowedLoaSpirit		= mod:NewSpecialWarningSwitch(137350, "Dps", nil, nil, 1, 2)
local specWarnMarkedSoul			= mod:NewSpecialWarningRun(137359, nil, nil, nil, 4, 2)
local specWarnTwistedFate			= mod:NewSpecialWarningSwitch(137891, nil, nil, nil, 1, 2)

local timerBlessedLoaSpiritCD		= mod:NewCDTimer(32.7, 137203, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)--Every 33-35 seconds.
local timerShadowedLoaSpiritCD		= mod:NewCDTimer(32.7, 137350, nil, nil, nil, 1, nil, DBM_COMMON_L.DAMAGE_ICON)--Possessed version of above, shared CD
local timerTwistedFateCD			= mod:NewCDTimer(32.7, 137891, nil, nil, nil, 3)--On heroic, this replaces shadowed loa spirit
local timerMarkedSoul				= mod:NewTargetTimer(20, 137359)
--Frost King Malakk
mod:AddTimerLine(Malakk)
local warnBitingCold				= mod:NewTargetAnnounce(136992, 3)--136917 is cast ID version, 136992 is player debuff
local warnFrostBite					= mod:NewTargetAnnounce(136922, 4)--136990 is cast ID version, 136922 is player debuff
local warnFrigidAssault				= mod:NewStackAnnounce(136903, 3, nil, "Tank|Healer")

local specWarnBitingCold			= mod:NewSpecialWarningMoveAway(136992, nil, nil, nil, 1, 2)
local yellBitingCold				= mod:NewShortYell(136992)--This one you just avoid so chat bubble is useful
local specWarnFrostBite				= mod:NewSpecialWarningMoveTo(136922, nil, nil, nil, 1, 2)--This one you do not avoid you clear it hugging people so no chat bubble
local specWarnFrigidAssault			= mod:NewSpecialWarningStack(136903, nil, 10, nil, nil, 1, 6)
local specWarnFrigidAssaultOther	= mod:NewSpecialWarningTaunt(136903, nil, nil, nil, 1, 2)

local timerBitingCold				= mod:NewBuffFadesTimer(30, 136917)
local timerBitingColdCD				= mod:NewCDTimer(45, 136917, nil, nil, nil, 3)--10 man Cds (and probably LFR), i have no doubt on 25 man this will either have a shorter cd or affect 3 targets with same CD. Watch for timer diffs though
local timerFrostBite				= mod:NewBuffFadesTimer(30, 136990)
local timerFrostBiteCD				= mod:NewCDTimer(45, 136990, nil, nil, nil, 3)--^same comment as above
local timerFrigidAssault			= mod:NewTargetTimer(15, 136903, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerFrigidAssaultCD			= mod:NewCDTimer(32.7, 136904, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--30 seconds after last one ended (maybe even a next timer, i'll change it with more logs.)

mod:AddSetIconOption("SetIconOnBitingCold", 136917, true, 0, {7})
mod:AddSetIconOption("SetIconOnFrostBite", 136990, true, 0, {6})
--Kazra'jin
mod:AddTimerLine(Kazrajin)
local warnRecklessCharge			= mod:NewCastAnnounce(137122, 3, 2, nil, false)

local specWarnDischarge				= mod:NewSpecialWarningCount(137166, nil, nil, nil, 2, 2)

local timerRecklessChargeCD			= mod:NewCDTimer(6, 137122, nil, false, nil, 3)

local lingeringPresence = DBM:GetSpellName(136467)
mod.vb.boltCasts = 0
mod.vb.darkPowerCount = 0
mod.vb.sandstormCount = 0
mod.vb.possessesDone = 0
mod.vb.dischargeCount = 0
mod.vb.kazraPossessed = false
mod.vb.darkPowerWarned = false

function mod:OnCombatStart(delay)
	self.vb.kazraPossessed = false
	self.vb.darkPowerWarned = false
	self.vb.possessesDone = 0
	self.vb.boltCasts = 0
	self.vb.darkPowerCount = 0
	self.vb.sandstormCount = 0
	timerQuickSandCD:Start(5.8-delay)
	timerRecklessChargeCD:Start(10-delay)--the trigger is 6 seconds from pull, charge will happen at 10. I like timer ending at cast finish for this one though vs tryng to have TWO timers for something that literally only has 6 second cd
	timerBitingColdCD:Start(15-delay)--15 seconds until debuff, 13 til cast.
	timerBlessedLoaSpiritCD:Start(25-delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 136189 then
		if self.vb.boltCasts == 3 then self.vb.boltCasts = 0 end
		self.vb.boltCasts = self.vb.boltCasts + 1
		specWarnSandBolt:Show(args.sourceName, self.vb.boltCasts)
		specWarnSandBolt:Play("kickcast")
	elseif spellId == 136521 and args:GetSrcCreatureID() == 69078 then--Filter the ones cast by adds dying.
		warnQuicksand:Show()
		timerQuickSandCD:Start()
	elseif spellId == 136894 then
		self.vb.sandstormCount = self.vb.sandstormCount + 1
		specWarnSandStorm:Show(self.vb.sandstormCount)
		specWarnSandStorm:Play("aesoon")
		timerSandStormCD:Start()
	elseif spellId == 137203 then
		specWarnBlessedLoaSpirit:Show()
		specWarnBlessedLoaSpirit:Play("targetchange")
		timerBlessedLoaSpiritCD:Start()
	elseif spellId == 137350 then
		specWarnShadowedLoaSpirit:Show()
		specWarnShadowedLoaSpirit:Play("targetchange")
		timerShadowedLoaSpiritCD:Start()
	elseif spellId == 137891 then
		specWarnTwistedFate:Show()
		specWarnTwistedFate:Play("lineapart")
		timerTwistedFateCD:Start()
	elseif spellId == 136990 then
		timerFrostBiteCD:Schedule(1.5)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 136442 then--Possessed
		local cid = args:GetDestCreatureID()
		local uid
		for i = 1, 5 do
			if UnitName("boss"..i) == args.destName then
				uid = "boss"..i
				break
			end
		end
		self.vb.possessesDone = self.vb.possessesDone + 1
		warnPossessed:Show(args.destName, self.vb.possessesDone)
		specWarnPossessed:Show(args.spellName, args.destName)
		specWarnPossessed:Play("targetchange")
		if uid and DBM:UnitBuff(uid, lingeringPresence) then
			local _, _, stack = DBM:UnitBuff(uid, lingeringPresence)
			if self:IsHeroic() then
				timerDarkPowerCD:Start(math.floor(68/(0.15*stack+1.0)+0.5))--(68, 59, 52, 47)
			elseif self:IsDifficulty("normal25") then
				timerDarkPowerCD:Start(math.floor(68/(0.10*stack+1.0)+0.5))--(68, 62, 57, 52)
			elseif self:IsDifficulty("normal10") then
				timerDarkPowerCD:Start(math.floor(68/(0.10*(stack-1)+1.0)+0.5))--(76, 68, 62, x)
			else
				timerDarkPowerCD:Start(math.floor(68/(0.05*(stack-6)+1.0)+0.5))--(97, 91, 85, x)
			end
		else
			if self:IsDifficulty("lfr25") then
				timerDarkPowerCD:Start(97)
			elseif self:IsDifficulty("normal10") then
				timerDarkPowerCD:Start(76)
			else
				timerDarkPowerCD:Start(68)
			end
		end
		if cid == 69078 then--Sul the Sandcrawler
			self:UnregisterShortTermEvents()
		elseif cid == 69132 then--High Prestess Mar'li
			--Swap timers. While possessed
			local elapsed, total = timerBlessedLoaSpiritCD:GetTime()
			timerBlessedLoaSpiritCD:Cancel()
			if elapsed and total and total ~= 0 then --If for some reason it was nil, like it JUST came off cd, do nothing, she should cast loa spirit right away.
				if self:IsHeroic() then
					timerTwistedFateCD:Update(elapsed, total)
				else
					timerShadowedLoaSpiritCD:Update(elapsed, total)
				end
			end
			self:UnregisterShortTermEvents()
		elseif cid == 69131 then--Frost King Malakk
			--Swap timers. While possessed
			local elapsed, total = timerBitingColdCD:GetTime()
			timerBitingColdCD:Cancel()
			if elapsed and total and total ~= 0 then --If for some reason it was nil, like it JUST came off cd, do nothing, he should cast frost bite right away.
				timerFrostBiteCD:Update(elapsed, total)
			end
		elseif cid == 69134 then--Kazra'jin
			self.vb.dischargeCount = 0
			self.vb.kazraPossessed = true
		end
	elseif spellId == 136903 then--Player Debuff version, not cast version
		local amount = args.amount or 1
		timerFrigidAssault:Start(args.destName)
		if self:AntiSpam(2.5, 1) then
			warnFrigidAssault:Show(args.destName, amount)
			if args:IsPlayer() then
				if amount >= 10 then
					specWarnFrigidAssault:Show(amount)
					specWarnFrigidAssault:Play("stackhigh")
				end
			else
				if amount >= 10 and not DBM:UnitDebuff("player", args.spellName) and not UnitIsDeadOrGhost("player") then
					specWarnFrigidAssaultOther:Show(args.destName)
					specWarnFrigidAssaultOther:Play("tauntboss")
				end
			end
		end
	elseif spellId == 136992 then--Player Debuff version, not cast version
		if self.Options.SetIconOnBitingCold then
			self:SetIcon(args.destName, 7)--Cross
		end
		timerBitingColdCD:Start()
		if args:IsPlayer() then
			specWarnBitingCold:Show()
			specWarnBitingCold:Play("range5")
			timerBitingCold:Start()
			yellBitingCold:Yell()
		else
			warnBitingCold:Show(args.destName)
		end
	elseif spellId == 136922 then--Player Debuff version, not cast version (amount is just a spam filter for ignoring SPELL_AURA_APPLIED_DOSE on this event)
		if self.Options.SetIconOnFrostBite then
			self:SetIcon(args.destName, 6)--Square
		end
		if args:IsPlayer() then
			specWarnFrostBite:Show(DBM_COMMON_L.ALLIES)
			specWarnFrostBite:Play("gathershare")
			timerFrostBite:Start()
		else
			warnFrostBite:Show(args.destName)
		end
	elseif args:IsSpellID(136860, 136878) and args:IsPlayer() and self:AntiSpam(2, 3) then--Trigger off initial quicksand debuff and ensnared stacks. much less cpu them registering damage events and just as effective.
		specWarnQuickSand:Show(args.spellName)
		specWarnQuickSand:Play("watchfeet")
	elseif spellId == 137359 then
		timerMarkedSoul:Start(args.destName)
		if args:IsPlayer() then
			specWarnMarkedSoul:Show()
			specWarnMarkedSoul:Play("justrun")
		else
			warnMarkedSoul:Show(args.destName)
		end
	elseif spellId == 137166 then
		self.vb.dischargeCount = self.vb.dischargeCount + 1
		specWarnDischarge:Show(self.vb.dischargeCount)
		specWarnDischarge:Play("aesoon")
		if self.Options.AnnounceCooldowns then
			DBM:PlayCountSound(self.vb.dischargeCount)
		end
	elseif spellId == 137641 and args:IsPlayer() then
		specWarnSoulFragment:Show()
		specWarnSoulFragment:Play("debuffyou")
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 136442 then--Possessed
		self.vb.darkPowerWarned = false
		timerDarkPowerCD:Cancel()
		if args:GetDestCreatureID() == 69078 then--Sul the Sandcrawler
			timerSandStormCD:Cancel()
		elseif args:GetDestCreatureID() == 69132 then--High Prestess Mar'li
			--Swap timer back
			local elapsed, total
			if self:IsHeroic() then
				elapsed, total = timerTwistedFateCD:GetTime()
			else
				elapsed, total = timerShadowedLoaSpiritCD:GetTime()
			end
			timerTwistedFateCD:Cancel()
			timerShadowedLoaSpiritCD:Cancel()
			if elapsed and total and total ~= 0 then
				timerBlessedLoaSpiritCD:Update(elapsed, total)
			end
		elseif args:GetDestCreatureID() == 69131 then--Frost King Malakk
			--Swap timer back
			local elapsed, total  = timerFrostBiteCD:GetTime()
			timerFrostBiteCD:Cancel()
			if elapsed and total and total ~= 0 then
				timerBitingColdCD:Update(elapsed, total)
			end
		elseif args:GetDestCreatureID() == 69134 then--Kazra'jin
			self.vb.kazraPossessed = false
			timerRecklessChargeCD:Cancel()--Because it's not going to be 25 sec anymore. It'll go back to 6 seconds. He'll probably do it right away since more than likely it'll be off CD
		end
	elseif spellId == 136903 then
		timerFrigidAssault:Cancel(args.destName)
	elseif spellId == 136904 then
		timerFrigidAssaultCD:Start()
	elseif spellId == 137359 then
		timerMarkedSoul:Cancel(args.destName)
	elseif spellId == 136992 and self.Options.SetIconOnBitingCold then
		self:SetIcon(args.destName, 0)
		if args:IsPlayer() then
			timerBitingCold:Cancel()
		end
	elseif spellId == 136922 and self.Options.SetIconOnFrostBite then
		self:SetIcon(args.destName, 0)
		if args:IsPlayer() then
			timerFrostBite:Cancel()
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 136507 and not self.vb.darkPowerWarned then
		self.vb.darkPowerWarned = true
		self.vb.darkPowerCount = self.vb.darkPowerCount + 1
		specWarnDarkPower:Show(self.vb.darkPowerCount)
		specWarnDarkPower:Play("aesoon")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 69078 then--Sul the Sandcrawler
		timerSandStormCD:Cancel()
	elseif cid == 69132 then--High Prestess Mar'li
		timerTwistedFateCD:Cancel()
		timerBlessedLoaSpiritCD:Cancel()
		timerShadowedLoaSpiritCD:Cancel()
	elseif cid == 69131 then--Frost King Malakk
		timerFrostBiteCD:Cancel()
		timerBitingColdCD:Cancel()
		timerFrigidAssaultCD:Cancel()
	elseif cid == 69134 then--Kazra'jin
		timerRecklessChargeCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 137107 then--Pre cast trigger. there are other later spellids but they aren't consistent, only this one is.
		warnRecklessCharge:Schedule(2)--warning 4 seconds early on something cast every 6 seconds seems silly. Lets warn 2 seconds early.
		if self.vb.kazraPossessed then--While possessed he gains "Overload" which will make his charge cd way different.
			timerRecklessChargeCD:Schedule(4, 25)--Will have timer actualy sync up to the cast finish so it also kind serves as a cast bar.
		else
			timerRecklessChargeCD:Schedule(4)--Will have timer actualy sync up to the cast finish so it also kind serves as a cast bar.
		end
	end
end
