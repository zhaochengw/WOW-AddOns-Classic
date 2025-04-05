local mod	= DBM:NewMod("Halion", "DBM-Raids-WoTLK", 1)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,normal25,heroic,heroic25"

mod:SetRevision("20241103133102")
mod:SetCreatureID(39863)--40142 (twilight form)
mod:SetEncounterID(not mod:IsPostCata() and 887 or 1150)
mod:SetModelID(31952)
mod:SetUsedIcons(7, 3)
mod:SetHotfixNoticeRev(20240113000000)
mod:SetMinSyncRevision(20240112000000)
mod:SetZone(724)

mod:RegisterCombat("combat")
--mod:RegisterKill("yell", L.Kill)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 74806 74525 75063",
	"SPELL_CAST_SUCCESS 74792 74562 75476",
	"SPELL_AURA_APPLIED 74792 74562 74826 74827 74828 74829 74830 74831 74832 74833 74834 74835 74836",
	"SPELL_AURA_REMOVED 74792 74562",
	"SPELL_DAMAGE 74712 74717",
	"SPELL_MISSED 74712 74717",
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2",--Halion reports as two different bosses
	"UNIT_HEALTH boss1 boss2",
	"UNIT_AURA player"
--	"UPDATE_UI_WIDGET"
)

--TODO, current code with AnnounceAlternatePhase will break mod if combat log is synced between phases

-- General
local berserkTimer					= mod:NewBerserkTimer(480)

mod:AddBoolOption("AnnounceAlternatePhase", true, "announce")

-- Stage One - Physical Realm (100%)
mod:AddTimerLine(SCENARIO_STAGE:format(1)..": "..L.PhysicalRealm)
local warnPhase2Soon				= mod:NewPrePhaseAnnounce(2)
local warningFieryCombustion		= mod:NewTargetNoFilterAnnounce(74562, 4)
local warningMeteor					= mod:NewSpellAnnounce(74648, 3)
local warningFlameBreath			= mod:NewSpellAnnounce(74525, 2, nil, "Tank|Healer")

local specWarnFieryCombustion		= mod:NewSpecialWarningRun(74562, nil, nil, nil, 4, 2)
local yellFieryCombustion			= mod:NewYell(74562)
local specWarnMeteor				= mod:NewSpecialWarningSoon(74648, nil, nil, nil, 2, 2)
local specWarnMeteorStrike			= mod:NewSpecialWarningGTFO(74648, nil, nil, nil, 1, 8)

local timerFieryConbustionCD		= mod:NewCDTimer(30.3, 74562, nil, nil, nil, 3)
local timerMeteorCD					= mod:NewNextTimer(40, 74648, nil, nil, nil, 3)--Target or aoe? tough call. It's a targeted aoe!
local timerMeteorCast				= mod:NewCastTimer(7, 74648, nil, nil, nil, 3)--7-8 seconds from boss yell the meteor impacts.
local timerFlameBreathCD			= mod:NewCDTimer(12.1, 74525, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--12.1-19.4

mod:AddSetIconOption("SetIconOnFireConsumption", 74562, true, 0, {7})--Red x for Fire

-- Stage Two - Twilight Realm (75%)
local twilightRealmName = DBM:GetSpellName(74807)
mod:AddTimerLine(SCENARIO_STAGE:format(2)..": "..twilightRealmName)
local warnPhase3Soon				= mod:NewPrePhaseAnnounce(3)
local warnPhase2					= mod:NewPhaseAnnounce(2, 2, nil, nil, nil, nil, nil, 2)
local warningShadowConsumption		= mod:NewTargetNoFilterAnnounce(74792, 4)
local warningDarkBreath				= mod:NewSpellAnnounce(74806, 2, nil, "Tank|Healer")
local warningTwilightCutter			= mod:NewAnnounce("TwilightCutterCast", 4, 74769, nil, nil, nil, 74769)

local specWarnShadowConsumption		= mod:NewSpecialWarningRun(74792, nil, nil, nil, 4, 2)
local yellShadowconsumption			= mod:NewYell(74792)
local specWarnTwilightCutter		= mod:NewSpecialWarningSpell(74769, nil, nil, nil, 3, 2)

local timerShadowConsumptionCD		= mod:NewCDTimer(25, 74792, nil, nil, nil, 3)--TODO, timer accuracy of normal
local timerTwilightCutterCast		= mod:NewCastTimer(4.5, 74769, nil, nil, nil, 3, nil, DBM_COMMON_L.DEADLY_ICON)
local timerTwilightCutter			= mod:NewBuffActiveTimer(10, 74769, nil, nil, nil, 6)
local timerTwilightCutterCD			= mod:NewNextTimer(15, 74769, nil, nil, nil, 6)
local timerDarkBreathCD				= mod:NewCDTimer(12.1, 74806, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)--12.1-19.4

mod:AddSetIconOption("SetIconOnShadowConsumption", 74792, true, 0, {3})--Purple diamond for shadow

-- Stage Three - Corporeality (50%)
local twilightDivisionName = DBM:GetSpellName(75063)
mod:AddTimerLine(SCENARIO_STAGE:format(3)..": "..twilightDivisionName)
local warnPhase3					= mod:NewPhaseAnnounce(3, 2, nil, nil, nil, nil, nil, 2)

local specWarnCorporeality			= mod:NewSpecialWarningCount(74826, nil, nil, nil, 1, 2)

mod.vb.warned_preP2 = false
mod.vb.warned_preP3 = false
local playerInTwilight = false
local corporealityValueByID = {
	[74826] = 50,
	[74827] = 60,
	[74828] = 70,
	[74829] = 80,
	[74830] = 90,
	[74831] = 100,
	[74832] = 40,
	[74833] = 30,
	[74834] = 20,
	[74835] = 10,
	[74836] = 0
}

-- Globals
--local C_UIWidgetManager = C_UIWidgetManager

local function UpdateCorp(self, spellId)
	if self:AntiSpam(3, 1) then--3 second throttle in case player
		local corporeality = corporealityValueByID[spellId]
		local voiceFile = corporeality >= 70 and self:IsTank() and "defensive" or corporeality > 60 and "dpshard" or corporeality == 60 and "dpsmore" or corporeality == 40 and "dpsslow" or corporeality < 40 and "dpsstop"
		specWarnCorporeality:Show(corporeality)
		if voiceFile then
			specWarnCorporeality:Play(voiceFile)
		end
	end
end

local function updateBossDistance(self)
	if playerInTwilight or self:GetStage(2) then
		--Set twilight timers normal
		timerShadowConsumptionCD:SetFade(false)
		timerTwilightCutterCast:SetFade(false)
		timerTwilightCutter:SetFade(false)
		timerTwilightCutterCD:SetFade(false)
		timerDarkBreathCD:SetFade(false)
		--Set Fire timers faded
		timerFieryConbustionCD:SetFade(true)
		timerMeteorCD:SetFade(true)
		timerMeteorCast:SetFade(true)
		timerFlameBreathCD:SetFade(true)
		if self:GetStage(3) then
			for spellId, _ in ipairs(corporealityValueByID) do
				if DBM:UnitBuff("boss2", spellId) then--Twilight dragon is always boss2
					UpdateCorp(self, spellId)
					break
				end
			end
		end
	else
		--Set twilight timers faded
		timerShadowConsumptionCD:SetFade(true)
		timerTwilightCutterCast:SetFade(true)
		timerTwilightCutter:SetFade(true)
		timerTwilightCutterCD:SetFade(true)
		timerDarkBreathCD:SetFade(true)
		--Set Fire timers normal
		timerFieryConbustionCD:SetFade(false)
		timerMeteorCD:SetFade(false)
		timerMeteorCast:SetFade(false)
		timerFlameBreathCD:SetFade(false)
		if self:GetStage(3) then
			for spellId, _ in ipairs(corporealityValueByID) do
				if DBM:UnitBuff("boss1", spellId) then--normal dragon is always boss1
					UpdateCorp(self, spellId)
					break
				end
			end
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.warned_preP2 = false
	self.vb.warned_preP3 = false
	playerInTwilight = false
	updateBossDistance(self)
	self:SetStage(1)
	berserkTimer:Start(-delay)
	timerFlameBreathCD:Start(10-delay)
	timerFieryConbustionCD:Start(15-delay)
	timerMeteorCD:Start(20-delay)
end

function mod:OnTimerRecovery()
	if DBM:UnitBuff("player", 136223) then
		playerInTwilight = true
		updateBossDistance(self)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 74806 then
		if playerInTwilight or self.Options.AnnounceAlternatePhase or self:GetStage(2) then
			warningDarkBreath:Show()
		end
		timerDarkBreathCD:Start()
	elseif spellId == 74525 then
		if not playerInTwilight or self.Options.AnnounceAlternatePhase then
			warningFlameBreath:Show()
		end
		timerFlameBreathCD:Start()
	--"<240.45 02:11:23> [CLEU] SPELL_CAST_START#Creature-0-4401-724-10055-40142-000020C89D#Halion##nil#75063#Twilight Division#nil#nil", -- [40368]
	--"<240.66 02:11:23> [CHAT_MSG_MONSTER_YELL] I am the light and the darkness! Cower, mortals, before the herald of Deathwing!#Halion#####0#0##0#456#nil#0#false#false#false#false", -- [40414]
	elseif spellId == 75063 then
		self:SetStage(3)
		warnPhase3:Show()
		warnPhase3:Play("pthree")
		timerFieryConbustionCD:Stop()
		timerFieryConbustionCD:Start(20)--restart is used purely to avoid false debug on retail when boss is instantly phased into phase 3 in one attack (thus clipping P1 timer)
	end
end

function mod:SPELL_CAST_SUCCESS(args)--We use spell cast success for debuff timers in case it gets resisted by a player we still get CD timer for next one
	local spellId = args.spellId
	if spellId == 74792 then
		if self:IsDifficulty("heroic10", "heroic25") then
			timerShadowConsumptionCD:Start(20.6)
		else
			timerShadowConsumptionCD:Start()
		end
	elseif spellId == 74562 then
		if self:IsClassic() and self:IsDifficulty("heroic10", "heroic25") then
			timerFieryConbustionCD:Start(20)
		else--On retail, even heroic is always every 30?
			timerFieryConbustionCD:Start()--30
		end
	elseif spellId == 75476 then--Dusk Shroud (When stage 2 dragon is engaged. ie attacked by twilight realm tank)
		--Starting timers here is way more accurate than stage 2 trigger
		timerShadowConsumptionCD:Start(16.2)
		timerDarkBreathCD:Start(17.8)
		timerTwilightCutterCD:Start(30.9)
	end
end

function mod:SPELL_AURA_APPLIED(args)--We don't use spell cast success for actual debuff on >player< warnings since it has a chance to be resisted.
	local spellId = args.spellId
	if spellId == 74792 then
		if args:IsPlayer() then
			specWarnShadowConsumption:Show()
			specWarnShadowConsumption:Play("runout")
			yellShadowconsumption:Yell()
		elseif playerInTwilight or self.Options.AnnounceAlternatePhase or self:GetStage(2) then
			warningShadowConsumption:Show(args.destName)
		end
		if self.Options.SetIconOnShadowConsumption then
			self:SetIcon(args.destName, 3)
		end
	elseif spellId == 74562 then
		if args:IsPlayer() then
			specWarnFieryCombustion:Show()
			specWarnFieryCombustion:Play("runout")
			yellFieryCombustion:Yell()
		elseif not playerInTwilight or self.Options.AnnounceAlternatePhase then
			warningFieryCombustion:Show(args.destName)
		end
		if self.Options.SetIconOnFireConsumption then
			self:SetIcon(args.destName, 7)
		end
	elseif args:IsSpellID(74826, 74827, 74828, 74829, 74830, 74831, 74832, 74833, 74834, 74835, 74836) and not self:IsTrivial() then -- Corporeality
		local destcId = args:GetDestCreatureID()
		if (playerInTwilight and destcId == 40142) or (not playerInTwilight and destcId == 39863) then
			UpdateCorp(self, spellId)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 74792 then
		if self.Options.SetIconOnShadowConsumption then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 74562 then
		if self.Options.SetIconOnFireConsumption then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if (spellId == 74712 or spellId == 74717) and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnMeteorStrike:Show(spellName)
		specWarnMeteorStrike:Play("watchfeet")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_HEALTH(uId)
	if not self.vb.warned_preP2 and self:GetUnitCreatureId(uId) == 39863 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.79 then
		self.vb.warned_preP2 = true
		warnPhase2Soon:Show()
	elseif not self.vb.warned_preP3 and self:GetUnitCreatureId(uId) == 40142 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.54 then
		self.vb.warned_preP3 = true
		warnPhase3Soon:Show()
	end
end

--Yells no longer required, but still faster, so kept since mostly translated already anyways. USCS will be used as backup
function mod:CHAT_MSG_MONSTER_YELL(msg)
	--"<153.64 02:09:56> [CHAT_MSG_MONSTER_YELL] You will find only suffering within the realm of twilight! Enter if you dare!#Halion#####0#0##0#441#nil#0#false#false#false#false", -- [20011]
	--"<155.94 02:09:59> [UNIT_SPELLCAST_SUCCEEDED] Halion(74.4%-0.0%){Target:??} -Twilight Phasing- [[boss1:Cast-3-4401-724-10055-74808-002B20C9A5:74808]]", -- [20547]
	--"<157.88 02:10:00> [CLEU] SPELL_CAST_SUCCESS#Creature-0-4401-724-10055-40142-000020C89D#Halion##nil#75476#Dusk Shroud#nil#nil", -- [20787]
	if msg == L.Phase2 or msg:find(L.Phase2) then
		self:SendSync("Phase2", "yell")
	--"<109.92 02:09:13> [CHAT_MSG_MONSTER_YELL] The heavens burn!#Halion#####0#0##0#436#nil#0#false#false#false#false", -- [6537]
	--"<110.79 02:09:13> [UNIT_SPELLCAST_SUCCEEDED] Halion(89.8%-0.0%){Target:Atlee} -Meteor Strike- [[boss1:Cast-3-4401-724-10055-74637-004CA0C979:74637]]", -- [6819]
	--"<117.06 02:09:20> [CLEU] SPELL_CAST_SUCCESS#Creature-0-4401-724-10055-40029-000020C97A#Meteor Strike##nil#74648#Meteor Strike#nil#nil", -- [8289]
	elseif msg == L.MeteorCast or msg:find(L.MeteorCast) then--There is no CLEU cast trigger for meteor, only yell and USCS. yell slightly faster
		if self:LatencyCheck() then
			self:SendSync("Meteor", "yell")
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 74637 then--Meteor Strike
		if self:LatencyCheck() then
			self:SendSync("Meteor", "uscs")
		end
	elseif spellId == 74809 then--Classic can also use Twilight Phasing (74808) but retial cannot
		self:SendSync("Phase2", "uscs")
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.twilightcutter or msg:find(L.twilightcutter) then
		if self:LatencyCheck() then
			self:SendSync("TwilightCutter")
		end
	end
end

function mod:UNIT_AURA(uId)
	local isTwilight = DBM:UnitBuff("player", 74807)
	if isTwilight and not playerInTwilight then
		playerInTwilight = true
		updateBossDistance(self)
	elseif not isTwilight and playerInTwilight then
		playerInTwilight = false
		updateBossDistance(self)
	end
end

--[[function mod:UPDATE_UI_WIDGET(table)
	local id = table.widgetID
	if id ~= 613 and id ~= 3940 and id ~= 3941 then return end -- Retail: 613; Classic WotLK: 3940 and 3941
	local widgetInfo = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(id)
	local text = widgetInfo.text
	if not text then return end
	corporeality = tonumber(text:match("%d+"))
	if corporeality > 0 and previousCorporeality ~= corporeality then
		specWarnCorporeality:Show(corporeality)
		previousCorporeality = corporeality
		if corporeality > 60 then -- only voice for >= 70%, 60% is still manageable so default to the selected SA sound
			if self:IsTank() then
				specWarnCorporeality:Play("defensive")
			end
		end
		if corporeality < 40 then
			if self:IsDps() then
				specWarnCorporeality:Play("dpsstop")
			end
		elseif corporeality == 40 then
			if self:IsDps() then
				specWarnCorporeality:Play("dpsslow")
			end
		elseif corporeality == 60 then
			if self:IsDps() then
				specWarnCorporeality:Play("dpsmore")
			end
		elseif corporeality > 60 then
			if self:IsDps() then
				specWarnCorporeality:Play("dpshard")
			end
		end
	end
end]]

function mod:OnSync(msg, target)
	if msg == "TwilightCutter" and self:AntiSpam(5, 3) then
		if playerInTwilight or self.Options.AnnounceAlternatePhase or self:GetStage(2) then
			warningTwilightCutter:Show()
		end
		if playerInTwilight or self:GetStage(2) then
			specWarnTwilightCutter:Schedule(5)
			specWarnTwilightCutter:ScheduleVoice(5, "farfromline")
		end
		timerTwilightCutterCD:Cancel()
		timerTwilightCutterCast:Start()
		timerTwilightCutter:Schedule(5)--Delay it since it happens 5 seconds after the emote
		timerTwilightCutterCD:Schedule(15)--It's every 30 sec, lasts 15, we schedule a 15 second timer to start in 15 seconds
	elseif msg == "Meteor" and self:AntiSpam(5, 4) then--Needs own antispam since core antispam won't filter yell and uscs at same event
		if not playerInTwilight then
			specWarnMeteor:Show()
			specWarnMeteor:Play("watchstep")
		elseif self.Options.AnnounceAlternatePhase then
			warningMeteor:Show()
		end
		if target and target == "uscs" then--Non yell phasing, ~1 seconds later
			timerMeteorCast:Start(6)--7 seconds from boss yell the meteor impacts.
			timerMeteorCD:Start(39)--40
		else
			timerMeteorCast:Start()--7 seconds from boss yell the meteor impacts.
			timerMeteorCD:Start()--40
		end
	elseif msg == "Phase2" and self:GetStage(2, 1) then--Syncing is still used because retail still requires yell
		self:SetStage(2)
		timerFieryConbustionCD:Cancel()--Only one that stops, whoever stays tanking Fire halion still deals with breaths and meteors
		warnPhase2:Show()
		warnPhase2:Play("ptwo")
	end
end
