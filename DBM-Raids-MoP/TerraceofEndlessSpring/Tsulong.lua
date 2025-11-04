local mod	= DBM:NewMod(742, "DBM-Raids-MoP", 3, 320)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20250926000732")
mod:SetCreatureID(62442)--62919 Unstable Sha, 62969 Embodied Terror
mod:SetEncounterID(1505)
mod:SetReCombatTime(60)--fix lfr combat re-starts after killed.
mod:SetZone(996)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Victory)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 122768 123012 122858 123716",
	"SPELL_AURA_APPLIED_DOSE 122768",
	"SPELL_CAST_START 122855",
	"SPELL_CAST_SUCCESS 122752 124176 123630",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED"--Not sure why no boss nit Ids used, maybe cause they're inconsistent?
)

local warnNight							= mod:NewSpellAnnounce(-6310, 2, 108558)
--local warnSunbeam						= mod:NewSpellAnnounce(122789, 3)
local warnDay							= mod:NewSpellAnnounce(-6315, 2, 122789)
local warnSummonUnstableSha				= mod:NewSpellAnnounce(-6320, 3, "627685")
local warnSummonEmbodiedTerror			= mod:NewCountAnnounce(-6316, 4, "627685")
local warnSunBreath						= mod:NewCountAnnounce(122855, 3)
local warnLightOfDay					= mod:NewTargetCountAnnounce(123716, 1, nil, "Healer", nil, nil, nil, nil, true)

local specWarnShadowBreath				= mod:NewSpecialWarningSpell(122752, nil, nil, nil, 1, 2)
local specWarnDreadShadows				= mod:NewSpecialWarningStack(122768, nil, 9, nil, nil, 1, 6)--For heroic, 10 is unhealable, and it stacks pretty fast so adaquate warning to get over there would be abou 5-6
local specWarnNightmares				= mod:NewSpecialWarningDodge(122770, nil, nil, nil, 2, 2)
local yellNightmares					= mod:NewYell(122770)
local specWarnDarkOfNight				= mod:NewSpecialWarningSwitchCount(-6550, "Dps", nil, nil, 1, 2)
local specWarnTerrorize					= mod:NewSpecialWarningDispel(123012, "RemoveMagic", nil, nil, 1, 2)

local timerNightCD						= mod:NewNextTimer(121, -6310, nil, nil, nil, 6, 130013, DBM_COMMON_L.DAMAGE_ICON)
local timerSunbeamCD					= mod:NewCDTimer(41, 122789, nil, nil, nil, 3)
local timerShadowBreathCD				= mod:NewCDTimer(26, 122752, nil, "Tank|Healer", nil, 5, nil, DBM_COMMON_L.TANK_ICON)
local timerNightmaresCD					= mod:NewNextTimer(15.5, 122770, nil, nil, nil, 3, nil, nil, nil, 1, 4)
local timerDarkOfNightCD				= mod:NewCDCountTimer(30.5, -6550, nil, nil, nil, 1, 130013)
local timerDayCD						= mod:NewNextTimer(121, -6315, nil, nil, nil, 6, 122789)
local timerSummonUnstableShaCD			= mod:NewNextTimer(18, -6320, nil, nil, nil, 1, "627685")
local timerSummonEmbodiedTerrorCD		= mod:NewNextCountTimer(40.7, -6316, nil, nil, nil, 1, "627685")
local timerTerrorizeCD					= mod:NewCDTimer(13.5, 123012, nil, nil, nil, 5)--Besides being cast 14 seconds after they spawn, i don't know if they recast it if they live too long, their health was too undertuned to find out.
local timerSunBreathCD					= mod:NewNextCountTimer(29, 122855, nil, nil, nil, 5, nil, nil, nil, mod:IsHealer() and 1 or nil, 4)--LuaLS has a problem with this for some reason but seems valid
local timerBathedinLight				= mod:NewBuffFadesTimer(6, 122858, nil, "Healer", nil, 5)
local timerLightOfDay					= mod:NewTargetTimer(6, 123716, nil, "Healer", nil, 5)

local berserkTimer						= mod:NewBerserkTimer(490)--a little over 8 min, basically 3rd dark phase is auto berserk.

mod.vb.terrorCount = 0
mod.vb.darkOfNightCount = 0
mod.vb.lightOfDayCount = 0
mod.vb.breathCount = 0

function mod:ShadowsTarget(targetname, uId)
	if not targetname then return end
	if targetname == UnitName("player") then
		yellNightmares:Yell()
	end
end

function mod:OnCombatStart(delay)
	timerShadowBreathCD:Start(8.5-delay)
	timerNightmaresCD:Start(15-delay)
	timerSunbeamCD:Start(43-delay)--Sometimes he doesn't emote first cast, so we start a bar for SECOND cast on pull, if we does cast it though, we'll update bar off first cast
	timerDayCD:Start(-delay)
	if not self:IsDifficulty("lfr25") then
		berserkTimer:Start(-delay)
	end
	if self:IsHeroic() then
		timerDarkOfNightCD:Start(10-delay, 1)
		self.vb.darkOfNightCount = 0
		self.vb.lightOfDayCount = 0
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 122768 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 9 and amount % 3 == 0  then
			specWarnDreadShadows:Show(amount)
			specWarnDreadShadows:Play("stackhigh")
		end
	elseif spellId == 123012 and args:GetDestCreatureID() == 62442 and self:CheckDispelFilter("magic") then
		specWarnTerrorize:Show(args.destName)
		specWarnTerrorize:Play("helpdispel")
	elseif spellId == 122858 and args:IsPlayer() then
		timerBathedinLight:Start()
	elseif spellId == 123716 then
		self.vb.lightOfDayCount = self.vb.lightOfDayCount + 1
		warnLightOfDay:Show(self.vb.lightOfDayCount, args.destName)
		timerLightOfDay:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 122855 then
		self.vb.breathCount = self.vb.breathCount + 1
		warnSunBreath:Show(self.vb.breathCount)
		if timerNightCD:GetTime(self.vb.darkOfNightCount+1) < 100 then
			timerSunBreathCD:Start(29, self.vb.breathCount+1)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 122752 then
		if self:IsTanking("player", nil, nil, true, args.sourceGUID) then
			specWarnShadowBreath:Show()
			specWarnShadowBreath:Play("breathsoon")
		end
		if timerNightCD:GetTime(self.vb.darkOfNightCount+1) < 93 then
			timerShadowBreathCD:Start()
		end
--"<267.3 22:12:00> [CLEU] SPELL_CAST_SUCCESS#false#0xF150F3EA00000157#Tsulong#68168#0#0x0000000000000000#nil#-2147483648#-2147483648#124176#Gold Active#1", -- [44606]
--"<267.4 22:12:01> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#I thank you, strangers. I have been freed.#Tsulong#####0#0##0#4654##0#false#false", -- [44649]
-- 124176 seems not always fires. 123630 seems that followed by after kill events?
	elseif args:IsSpellID(124176, 123630) then
		DBM:EndCombat(self)
	end
end

do
	local terrorName = DBM:EJ_GetSectionInfo(6316)
	terrorName = string.lower(terrorName or "")
	function mod:RAID_BOSS_EMOTE(msg)
		msg = string.lower(msg or "")
		if msg:find("spell:122789") then
			if timerDayCD:GetTime() < 60 then
				timerSunbeamCD:Start()
			end
		elseif msg:find(terrorName) then
			self.vb.terrorCount = self.vb.terrorCount + 1
			timerTerrorizeCD:Start()--always cast 14-15 seconds after one spawns (Unless stunned, if you stun the mob you can delay the cast, using this timer)
			warnSummonEmbodiedTerror:Show(self.vb.terrorCount)
			if self.vb.terrorCount < 3 then
				timerSummonEmbodiedTerrorCD:Start(nil, self.vb.terrorCount+1)
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, spellId)
	if spellId == 122770 and self:AntiSpam(2, 1) then--Nightmares (Night Phase)
		self:BossTargetScanner(62442, "ShadowsTarget")
		specWarnNightmares:Show()
		specWarnNightmares:Play("watchstep")
		if timerDayCD:GetTime() < 106 then
			timerNightmaresCD:Start()
		end
	elseif spellId == 123252 and self:IsInCombat() and self:AntiSpam(3, 2) then--Dread Shadows Cancel (Sun Phase)
		self.vb.lightOfDayCount = 0
		self.vb.terrorCount = 0
		self.vb.breathCount = 0
		timerShadowBreathCD:Cancel()
		timerSunbeamCD:Cancel()
		timerNightmaresCD:Cancel()
		timerDarkOfNightCD:Cancel()
		warnDay:Show()
		timerSunBreathCD:Start(29, 1)
		timerNightCD:Start(nil, self.vb.darkOfNightCount+1)
	elseif spellId == 122953 and self:AntiSpam(2, 3) then--Summon Unstable Sha (122946 is another ID, but it always triggers at SAME time as Dread Shadows Cancel so can just trigger there too without additional ID scanning.
		warnSummonUnstableSha:Show()
		if timerNightCD:GetTime(self.vb.darkOfNightCount+1) < 103 then
			timerSummonUnstableShaCD:Start()
		end
	elseif spellId == 122767 and self:AntiSpam(3, 4) then--Dread Shadows (Night Phase)
		timerSummonUnstableShaCD:Cancel()
		timerSummonEmbodiedTerrorCD:Cancel()
		timerSunBreathCD:Cancel()
		warnNight:Show()
		timerShadowBreathCD:Start(10)
		timerNightmaresCD:Start()
		timerDayCD:Start()
		if self:IsHeroic() then
			timerDarkOfNightCD:Start(10, self.vb.darkOfNightCount+1)
			self.vb.darkOfNightCount = 0
		end
	elseif spellId == 123813 and self:AntiSpam(3, 5) then--The Dark of Night (Night Phase)
		self.vb.darkOfNightCount = self.vb.darkOfNightCount + 1
		specWarnDarkOfNight:Show(self.vb.darkOfNightCount)
		specWarnDarkOfNight:Play("targetchange")
		timerDarkOfNightCD:Start(nil, self.vb.darkOfNightCount+1)
	end
end
