--********************************************************
--  感謝MOP的 magicdragoon 和 frankcg 為DEX做的部分改進
--  Amount-pro add by Farever
--********************************************************

local dex_lastani = 1;
local dex_bottom = 0;
local dex_petbottom = 0
local DEX_MAXANI = 25;
local DEX_TEXTSIZE = 22;
local DEX_OUTLINE = "";
local DEX_FONTNAME = DEX_FontList[4];
local DEX_SHADOW = 2;
local DEX_aoeStartTimer = 0;
local DEX_aoeNew = 1;
local DEX_aoeId = 1;
local DEX_aoeDct = 0;
local DEX_ExtraAttList = {0,0,0,0,0};
local DEX_ExtraAttCount = 0;
local DEX_ExtraAttCur = 1;
local DEX_ExtraTimer = 0;
local DEX_logLine = 10;
local DEX_logTime = 10;


DEX_ReflectSpellID = 0
DEX_ReflectFromID = 0
DEX_ReflectTimer = 0

DEX_ANI_UID = -9999999

DEX_DAMAGE_TYPE_HIT = 0
DEX_DAMAGE_TYPE_SPELL = 1
DEX_DAMAGE_TYPE_PERIODIC = 2
DEX_DAMAGE_TYPE_HEALTH = 3
DEX_DAMAGE_TYPE_PET = 4096
DEX_DAMAGE_TYPE_HONOR = 5
DEX_DAMAGE_TYPE_MANA = 6


DEX_MOVTYP_NORMAL = 0;
DEX_MOVTYP_AOE = 1;
DEX_MOVTYP_PET = 2;
DEX_MOVTYP_OTHER = 3;
DEX_MOVTYP_NONE = 99;

DEX_HEX_LIST = {"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","f"}

local DEX_critFlag = 0;
local DEX_logFlag = 1;

local amount, school, resisted, blocked, absorbed, critical, glancing, crushing
local spellId, spellName, spellSchool, missType, powerType, extraAmount, environmentalType, extraSpellId, extraSpellName, extraSpellSchool, auraType
local missType

local dexType,dexText,dexSpell,dexCrit
local playerGUID, petGUID, targetGUID

local DEX_CritFix = {
	{y = 99999,uid = 0,aid = 1},
	{y = 99999,uid = 0,aid = 1},
}

local DEX_MovTypOther_TimerSlot = {0,0,0,0,0}

local DEX_PREFIXES = {
		["SWING"] = 1,
		["RANGE"] = 4,
		["SPELL"] = 4,
		["SPELL_PERIODIC"] = 4,
		["ENVIRONMENTAL"] = 2,
		["DAMAGE"] = 4,
	}

local DEX_FONTEFF = {
		{ol = "",shadowOff = 1},
		{ol = "OUTLINE",shadowOff = 0},
		{ol = "OUTLINE",shadowOff = 2},
		{ol = "THICKOUTLINE",shadowOff = 0},
		{ol = "THICKOUTLINE",shadowOff = 2},
	}

local dex_AniData = {
		["aniText1"] = {},					-- These are structures that define the animation data
		["aniText2"] = {},
		["aniText3"] = {},
		["aniText4"] = {},
		["aniText5"] = {},
		["aniText6"] = {},					-- These are structures that define the animation data
		["aniText7"] = {},
		["aniText8"] = {},
		["aniText9"] = {},
		["aniText10"] = {},
		["aniText11"] = {},					-- These are structures that define the animation data
		["aniText12"] = {},
		["aniText13"] = {},
		["aniText14"] = {},
		["aniText15"] = {},
		["aniText16"] = {},					-- These are structures that define the animation data
		["aniText17"] = {},
		["aniText18"] = {},
		["aniText19"] = {},
		["aniText20"] = {},
		["aniText21"] = {},
		["aniText22"] = {},
		["aniText23"] = {},
		["aniText24"] = {},
		["aniText25"] = {},
}

DEXPlayer = nil;
DEX_DEFAULT_CFG = {
	["DEX_Enable"] = 1,
	["DEX_ShowWithMess"] = 0,
	["DEX_ShowSpellName"] = 1,
	["DEX_ShowNameOnCrit"] = 1,
	["DEX_ShowNameOnMiss"] = 1,
	["DEX_ShowCurrentOnly"] = 0,
	["DEX_ShowDamagePeriodic"] = 1,
	["DEX_ShowDamageShield"] = 1,
	["DEX_ShowDamageHealth"] = 1,
	["DEX_ShowDamagePet"] = 1,
	["DEX_ShowBlockNumber"] = 0,
	["DEX_ShowDamageWoW"] = 0,
	["DEX_ShowMaxDamage"] = 0,
	["DEX_ShowOwnHealth"] = 0,
	["DEX_Speed"] = 80,
	["DEX_PosX"] = 0,
	["DEX_PosY"] = 100,
	["DEX_FontSize"] = 25,
	["DEX_Font"] = 4,
	["DEX_OutLine"] = 1,
	["DEX_ColorPet"] = {1,0.6,0},
	["DEX_ColorNormal"] = {1,1,1},
	["DEX_ColorNormalSe"] = {0.78,0.8,1},
	["DEX_ColorSkill"] = {1,1,0},
	["DEX_ColorSkillSe"] = {1,0.24,0},
	["DEX_ColorPeriodic"] = {1,0.3,1},
	["DEX_ColorPeriodicSe"] = {1,0,1},
	["DEX_ColorHealth"] = {0,1,0},
	["DEX_ColorHealthSe"] = {0,0.85,0},
	["DEX_ColorSpec"] = {0.85,0.85,0},
	["DEX_ColorSpecSe"] = {1,1,1},
	["DEX_ColorMana"] = {0,0,1},
	["DEX_ColorManaSe"] = {0.3,0.3,1},
	["DEX_ColorMode"] = 2,
	["DEX_ShowInterruptCrit"] = 0,
	["DEX_LOGLINE"] = 10,
	["DEX_LOGTIME"] = 10,
	["DEX_UniteSpell"] = 0,
	["DEX_NumberFormat"] = 1,
	["DEX_ShowSpellIcon"] = 1,
	["DEX_ShowInterrupt"] = 1,
	["DEX_ShowOverHeal"] = 0,
}

local function RegisterSpells(list, ...)
	local i
	for i = 1, select("#", ...) do
		local id = select(i, ...)
		if type(id) == "number" then
			local spell = GetSpellInfo(id)
			if spell then
				list[spell] = 1
			end
		end
	end
end

DEX_DISPELLED_FILTER = {}

RegisterSpells(DEX_DISPELLED_FILTER, 1776, 6770, 2094, 5246, 19386, 3355) -- 鑿擊, 悶棍, 致盲, 破膽怒吼, 翼龍釘刺, 冰凍陷阱

DEX_AOE_LIST = {} -- AOE spells definition through calls of DEX_RegisterAOE
local aoeList = {}

function DEX_RegisterAOE(class, ...)
--	if not RAID_CLASS_COLORS[class] then
--		return
--	end
	local list = DEX_AOE_LIST[class]
	if not list then
		list = {}
		DEX_AOE_LIST[class] = list
	end

	RegisterSpells(list, ...)
end

DEX_RegisterAOE("WARRIOR", 6343) -- 雷霆一擊
DEX_RegisterAOE("ROGUE", 51723) -- 飛舞刀刃
DEX_RegisterAOE("PALADIN", 26573, 53595, 7294, 53385) -- 奉獻, 公正之錘, 懲罰光環, 神性風暴
DEX_RegisterAOE("HUNTER", 2643, 214579, 120360, 191433) -- 多重射擊, 響尾蛇射擊, 彈幕, 爆炸陷阱
DEX_RegisterAOE("WARLOCK", 27243, 105174, 193440, 5740) -- 腐蝕種子, 古爾丹之手, 惡魔怒火, 火焰之雨
DEX_RegisterAOE("MAGE", 120, 1449, 190356, 122, 2120, 31661) -- 冰錐術, 魔爆術, 暴風雪, 冰霜新星, 烈焰風暴, 龍之吐息
DEX_RegisterAOE("PRIEST", 48045) -- 心靈烙印
DEX_RegisterAOE("DRUID", 740, 132469, 77758, 106830, 213771, 106785) -- 寧靜, 颶風, 痛擊（熊形態）, 痛擊（獵豹形態）,揮擊(熊形态), 揮擊(獵豹形态)
DEX_RegisterAOE("SHAMAN", 187874, 51490) -- 閃電轟擊, 雷霆風暴
DEX_RegisterAOE("DEATHKNIGHT", 49184, 43265) -- 凜風衝擊, 死亡凋零
DEX_RegisterAOE("MONK", 101546, 115181) -- 鶴旋踢, 火焰吐息

function DEX_Debug(msg)
	DEFAULT_CHAT_FRAME:AddMessage("|cff10ff00"..msg.."|r");
end

function DEX_OnLoad(self)
	self:RegisterEvent("VARIABLES_LOADED");
	self:RegisterEvent("PLAYER_LOGIN");
	self:RegisterEvent("UNIT_PET");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	DEX_Set_WOWDamage();
end

function DEX_Init(self)
	DEXPlayer = DEX_Config_GetPlayer();
	DEX_Debug(DEX_Version);

	SlashCmdList["DEX"] = DEX_showMenu;
	SLASH_DEX1 = "/dex";

	if(myAddOnsList) then
		myAddOnsList.DEX = {
			name = "Damage Text",
			description = "DamageEx",
			version = DEX_Version,
			frame = "DEX_TEXT",
			optionsframe = "DEXOptions",
			category = MYADDONS_CATEGORY_COMBAT
		};
	end

	-- Add my options frame to the global UI panel list
	UIPanelWindows["DEXOptions"] = {area = "center", pushable = 0};

	DEX_aniInit(); --动画初始化
	DEX_staticInit(); -- 公共方法初始化
	DEX_OnOptionCheck("DEX_Enable", DEX_Get("DEX_Enable") == 1)

end

function DEX_OnOptionCheck(name, checked)
	if name == "DEX_Enable" then
		local registered = DEX_TEXT:IsEventRegistered("COMBAT_LOG_EVENT_UNFILTERED")
		if checked and not registered then
			DEX_TEXT:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		elseif not checked and registered then
			DEX_TEXT:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		end
	end
end

function DEX_Reset()
	DEX_hideMenu();
	DEX_Config_NewPlayer()
	DEXPlayer = DEX_Config_GetPlayer();
	DEX_showMenu();
end

function DEX_Config_GetPlayer()
	if (DEX_SAVE == nil) then
		DEX_Config_NewPlayer()
	end
	return DEX_SAVE
end

--Set up a default config
function DEX_Config_NewPlayer()
	DEX_SAVE = nil
	DEX_SAVE = DEX_clone(DEX_DEFAULT_CFG);
end
function DEX_Get(option)
	if (DEXPlayer ~= nil) and (DEXPlayer[option] ~= nil) then
		return DEXPlayer[option];
	else
		return DEX_DEFAULT_CFG[option];
	end
end

function DEX_Set(option, newVal)
	if (DEXPlayer ~= nil) then
		if ( option ) then
			DEXPlayer[option] = newVal;
		end
	end
end

function DEX_clone(t)
  local new = {};
  local i, v = next(t, nil);
  while i do
  	if type(v)=="table" then
  		v=DEX_clone(v);
  	end
    new[i] = v;
    i, v = next(t, i);
  end
  return new;
end

function DEX_ProcBlock()
	if DEX_Get("DEX_ShowBlockNumber") ~= 1 then return;end
	if resisted then
		dexText = dexText.."-"..resisted
	elseif blocked then
		dexText = dexText.."-"..blocked
	elseif absorbed then
		dexText = dexText.."-"..absorbed
	elseif glancing then
		dexText = dexText.." "..getglobal("DEFLECT");
	elseif crushing then
		dexText = dexText.." "..DEX_TXT_CRUSH;
	end
end

function DEX_OnEvent(self, event, ...)
	if event == "VARIABLES_LOADED" then
		DEX_Init(self);
	elseif event == "PLAYER_LOGIN" then
		aoeList = DEX_AOE_LIST[select(2, UnitClass("player"))]
		playerGUID = UnitGUID("player")
		petGUID = UnitGUID("pet")
	elseif event == "UNIT_PET" then
		if "player" == ... then
			petGUID = UnitGUID("pet")
		end
	elseif event == "PLAYER_TARGET_CHANGED" then
		targetGUID = UnitGUID("target")
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		DEX_ProcessCombatLog(CombatLogGetCurrentEventInfo())
	end
end

--function DEX_ProcessCombatLog(timeStamp, flag, hideCaster, sourceGUID, sourceName, sourceFlag, destGUID, destName, destFlag, ...)
--function DEX_ProcessCombatLog(timeStamp, flag, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
--											(larg1, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, ...)
function DEX_ProcessCombatLog(timeStamp, flag, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlag, destRaidFlags, ...)
	if type(flag) ~= "string" then
		return -- should never happen but just in case..
	end

	local prefixes, suffixes = strmatch(flag, "(.-)_(.+)")
	if not prefixes or not suffixes then
		return -- should never happen either, who knows..
	end

	if strsub(suffixes,1,8) == "PERIODIC" then
		prefixes = prefixes.."_PERIODIC"
		suffixes = strsub(suffixes,10)
	end

	local ISPLAYER = sourceGUID == playerGUID
	local ISPET = sourceGUID == petGUID or CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MY_PET)
	-- or CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE)			--Modify big bug
	if not ISPLAYER and not ISPET then
		return -- irrelevant combat data, ignore
	end

	if ISPET and DEX_Get("DEX_ShowDamagePet") == 0 then
		return
	end

	local ISTARGET = destGUID == targetGUID
	if not ISTARGET and DEX_Get("DEX_ShowCurrentOnly") == 1 then
		return
	end

	if suffixes == "HEAL" and destGUID == playerGUID and DEX_Get("DEX_ShowOwnHealth") ~= 1 then
		return
	end

	if flag == "SPELL_EXTRA_ATTACKS" then
		spellId, spellName, spellSchool,amount = select(1,...)
		if ISPLAYER then
			DEX_ExtraAttack(amount)
			return
		end
	end
	if flag == "SPELL_MISSED" then
		missType = select(4,...);
		if missType == "REFLECT" then
			if spellId then
				DEX_ReflectSpellID = select(1,...)
				DEX_ReflectFromID = sourceGUID
				DEX_ReflectTimer = GetTime()
			end
			return
		end
	end

	if DEX_ReflectSpellID ~= 0 then
		if GetTime() - DEX_ReflectTimer < 1 then
			if destGUID == sourceGUID and sourceGUID == DEX_ReflectFromID then
				spellId, spellName, spellSchool = select(1,...)
				if spellId and DEX_ReflectSpellID == spellId then
					local fromTarget = false
					if destGUID == UnitGUID("target") then fromTarget = true;end
					if flag == "SPELL_DAMAGE" then
						amount,overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(4,...);
						DEX_AddText(amount..DEX_TXT_REFLECT,spellName,DEX_DAMAGE_TYPE_SPELL,critical,fromTarget,true,destGUID,destName)
						DEX_ReflectSpellID = 0
						return
					end
					if flag == "SPELL_MISSED" then
						missType = select(4,...)
						DEX_AddText(getglobal(missType)..DEX_TXT_REFLECT,spellName,DEX_DAMAGE_TYPE_SPELL,0,fromTarget,true,destGUID,destName)
						DEX_ReflectSpellID = 0
						return
					end
				end
			end
		else
			DEX_ReflectSpellID = 0
		end
	end


	--[[
	Prefixes

The Parameters listed with prefixes are numbered in the order they come after the base 8 parameters.
Prefix	1st Parameter	2nd Paramater	3rd Parameter
SWING
RANGE	spellId	spellName	spellSchool
SPELL	spellId	spellName	spellSchool
SPELL_PERIODIC	spellId	spellName	spellSchool
ENVIRONMENTAL	environmentalType
[edit] Suffixes

The Parameters listed with suffixes are numbered in the order they come after the prefix parameters.
Suffix	1st Param	2nd Param	3rd Param	4th Param	5th Param	6th Param	7th Param	8th Param
_DAMAGE	amount	school	resisted	blocked	absorbed	critical	glancing	crushing
_MISSED	missType
_HEAL	amount	critical
_ENERGIZE	amount	powerType
_DRAIN	amount	powerType	extraAmount
_LEECH	amount	powerType	extraAmount
_INTERRUPT	extraSpellID	extraSpellName	extraSpellSchool
_DISPEL_FAILED	extraSpellID	extraSpellName	extraSpellSchool
_AURA_DISPELLED	extraSpellID	extraSpellName	extraSpellSchool	auraType
_AURA_STOLEN	extraSpellID	extraSpellName	extraSpellSchool
_EXTRA_ATTACKS	amount
_AURA_APPLIED	auraType
_AURA_REMOVED	auraType
_AURA_APPLIED_DOSE	auraType	amount
_AURA_REMOVED_DOSE	auraType	amount
_CAST_START
_CAST_SUCCESS
_CAST_FAILED	failedType
_INSTAKILL
_DURABILITY_DAMAGE
_DURABILITY_DAMAGE_ALL
_CREATE
_SUMMON
	]]

	dexType = nil
	dexText = "0"
	dexSpell = ""
	dexCrit = 0

	--DEX_Debug(flag);
	spellId, spellName, spellSchool = ...

	if suffixes == "DAMAGE" then

		amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(DEX_PREFIXES[prefixes],...);
		dexText = tostring(amount)
		if critical then dexCrit = 1;end

		if prefixes == "SWING" then
			dexType = DEX_DAMAGE_TYPE_HIT
		elseif prefixes == "RANGE" then
			dexType = DEX_DAMAGE_TYPE_HIT
		elseif prefixes == "SPELL"then
			dexType = DEX_DAMAGE_TYPE_SPELL
			dexSpell = spellName
		elseif prefixes == "SPELL_PERIODIC" then
			dexType = DEX_DAMAGE_TYPE_PERIODIC
			dexSpell = spellName
		end
		DEX_ProcBlock()

	elseif suffixes == "MISSED" then
		missType = select(DEX_PREFIXES[prefixes],...);
		dexText = getglobal(missType)
		if prefixes == "SWING" then
			dexType = DEX_DAMAGE_TYPE_HIT
		elseif prefixes == "RANGE" then
			dexType = DEX_DAMAGE_TYPE_HIT
		elseif prefixes == "SPELL"then
			dexType = DEX_DAMAGE_TYPE_SPELL
			dexSpell = spellName
		elseif prefixes == "SPELL_PERIODIC" then
			dexType = DEX_DAMAGE_TYPE_PERIODIC
			dexSpell = spellName
		end

	elseif suffixes == "SHIELD_MISSED" then
		missType = select(4,...);
		dexText = getglobal(missType)
		if prefixes == "DAMAGE" then
			dexType = DEX_DAMAGE_TYPE_SPELL
			dexSpell = spellName
		end

	elseif suffixes == "HEAL" then
		amount, overDamage, critical = select(DEX_PREFIXES[prefixes],...);
		dexText = amount
		DEX_OverHeal = overDamage
		if critical and prefixes == "SPELL" and spellId ~= 143924 then dexCrit = 1;end		--Modify Heal Spell Critical,排除汲取效果
		--dexCrit = critical
		if prefixes == "SWING" then
			dexType = DEX_DAMAGE_TYPE_HEALTH
		else
			dexType = DEX_DAMAGE_TYPE_HEALTH
			dexSpell = spellName
		end


	elseif suffixes == "INTERRUPT" then 
		if DEX_Get("DEX_ShowInterrupt") == 1 then			-- Add Show Interupt Switch
			extraSpellId, extraSpellName, extraSpellSchool = select(DEX_PREFIXES[prefixes],...);
	--		dexText = DEX_TXT_INTERUPT
			dexSpell = extraSpellName
			dexText = DEX_TXT_INTERUPT     		            --Modify interupt text
			if DEX_Get("DEX_ShowInterruptCrit") == 1 then dexCrit = 1;end
			dexType = DEX_DAMAGE_TYPE_HONOR
		else
			dexText = ""
		end  
	elseif suffixes == "DRAIN" or suffixes == "LEECH" then
		amount,powerType,extraAmount = select(DEX_PREFIXES[prefixes],...)
		dexText = amount
		dexSpell = spellName
		if extraAmount ~= -2 then
			dexType = DEX_DAMAGE_TYPE_MANA
		else
			dexType = DEX_DAMAGE_TYPE_SPELL
		end

	elseif suffixes == "SHIELD" and DEX_Get("DEX_ShowDamageShield") == 1 then
		amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(4,...)
		if prefixes == "DAMAGE" then
			dexType = DEX_DAMAGE_TYPE_SPELL
			dexText = amount
			dexSpell = spellName
			DEX_ProcBlock()
		end
	elseif suffixes == "SPLIT" then
		if prefixes == "DAMAGE" then
			amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(DEX_PREFIXES[prefixes],...)
			dexText = tostring(amount)
			if critical then dexCrit = 1;end
			dexType = DEX_DAMAGE_TYPE_SPELL
			dexSpell = spellName
			DEX_ProcBlock()
		end
	--驅散
	elseif suffixes == "DISPEL" then
		extraSpellID,extraSpellName,extraSpellSchool,auraType = select(DEX_PREFIXES[prefixes],...)
		if DEX_DISPELLED_FILTER[extraSpellName] then
			return
		end

		dexType = DEX_DAMAGE_TYPE_HONOR
		dexText = DEX_TXT_DISPELLED..extraSpellName

	--偷取
	elseif suffixes == "STOLEN" then
		extraSpellID,extraSpellName,extraSpellSchool = select(DEX_PREFIXES[prefixes],...)
		dexType = DEX_DAMAGE_TYPE_HONOR
		dexText = DEX_TXT_STOLEN..extraSpellName

	end

	if dexType then
		if ISPET then
			if dexType == DEX_DAMAGE_TYPE_HEALTH then
				return
			end

			dexType = DEX_DAMAGE_TYPE_PET
		end

		if ISTARGET and dexType ~= DEX_DAMAGE_TYPE_PET then
			DEX_AddText(dexText,dexSpell,dexType,dexCrit,true,false,destGUID,destName)
		else
			DEX_AddText(dexText,dexSpell,dexType,dexCrit,false,false,destGUID,destName)
		end
	end
end

function DEX_GameUpdate(self)
	dex_bottom = 99999;
	dex_petbottom = 99999;
	if DEX_Get("DEX_ShowWithMess") == 0 then
		for key, value in pairs(dex_AniData) do
			if (value.Active == true) then
				DEX_doAni(value);
			end
		end
	else
		for key, value in pairs(dex_AniData) do
			if (value.Active == true) then
				DEX_doLog(value);
			end
		end
	end
end

function DEX_RefressBottom(ani)
	if ani.moveTyp == DEX_MOVTYP_NORMAL then
		if ani.posY < dex_bottom then dex_bottom = ani.posY;end
	end
	if ani.moveTyp == DEX_MOVTYP_PET then
		if ani.posY < dex_petbottom then dex_petbottom = ani.posY;end
	end
end

function DEX_doLog(ani)
	local thetime = GetTime() - ani.starttime;
	if thetime < DEX_logTime and thetime > 0 then
		ani.FObject:SetAlpha(1);
	else
		if thetime < DEX_logTime + 3 then
			ani.FObject:SetAlpha(1 - (thetime - DEX_logTime) / 3);
		else
			DEX_aniReset(ani);
		end
	end
end

function DEX_GetMovTypOtherPosY()
	local i
	local t = GetTime()
	for i = 1,5 do
		if DEX_MovTypOther_TimerSlot[i] == 0 or t - DEX_MovTypOther_TimerSlot[i] > 1 then
			DEX_MovTypOther_TimerSlot[i] = t
			return (i - 1) * (DEX_Get("DEX_FontSize") + 2) - 20
		end
	end
	DEX_MovTypOther_TimerSlot[1] = t
	return -20
end

function DEX_doAni(ani)
	local thetime = GetTime() - ani.starttime;
	if thetime < 1.5 and thetime > 0 then
		if thetime < 0.1 then
			ani.alpha = thetime * 10;
		elseif thetime < 1 then
			ani.alpha = 1;
		else
			ani.alpha = 1 - (thetime - 1) * 2;
		end
		if ani.Extra ~= 0 and thetime < 0.7 then
			if ani.Extra > 0 then
				ani.posX = ani.Extra + sin(thetime / 0.7 * 180) * 50;
			else
				ani.posX = ani.Extra - sin(thetime / 0.7 * 180) * 50;
			end
		end
		if ani.moveTyp == DEX_MOVTYP_NORMAL then
			ani.posY = thetime * DEX_Get("DEX_Speed") + ani.baseY;
			ani.posYbak	= ani.posY;
			DEX_RefressBottom(ani);
		elseif ani.moveTyp == DEX_MOVTYP_OTHER then
			ani.posX = sin(thetime / 2.1 * 180) * 30 + 75;
		elseif ani.moveTyp == DEX_MOVTYP_AOE then
			if thetime < 0.2 then ani.posY = thetime * 30 + 30;else ani.posY = thetime * 60 + 30;end		--Modify AOE ani mode
			if thetime < 0.1 then
				ani.alpha = thetime * 10;
			elseif thetime < 0.7 then
				ani.alpha = 1;
			else
				ani.alpha = 1 - (thetime - 0.7) * 5;
			end
			if thetime > 0.9 then DEX_aniClear(ani);return;end
		elseif ani.moveTyp == DEX_MOVTYP_PET then
			ani.posY = thetime * (DEX_Get("DEX_Speed") * 0.75) + ani.baseY;
			DEX_RefressBottom(ani);
		end
		if ani.crit == 1 then
			local baseSize = DEX_TEXTSIZE + 4 + ani.critId * 2;
			if ani.critTyp == 0 then
				if thetime < 0.05 then
					ani.height = DEX_TEXTSIZE * ani.zoom;
				elseif thetime < 0.30 then
					ani.height = (1 - (thetime - 0.05) / 0.25) * DEX_TEXTSIZE * ani.zoom + DEX_TEXTSIZE;
				elseif ani.height ~= baseSize then
					ani.height = baseSize;
					DEX_SetFontSize(ani,ani.height);
				end
			elseif ani.critTyp == 1 then
				if thetime < 0.1 then
					ani.height = baseSize * thetime / 0.1 + baseSize * ani.zoom;
				elseif thetime < 0.35 then
					ani.height = baseSize * ani.zoom * (1 - (thetime - 0.1) / 0.25) + baseSize;
				elseif ani.height ~= baseSize then
					ani.height = baseSize;
					DEX_SetFontSize(ani,ani.height);
				end
				ani.posY = ani.posYbak + ani.height / 2 - baseSize / 2;
			end
			ani.FObject:SetTextHeight(ani.height);
			if thetime < 0.2 then
				ani.alpha = thetime * 2.5 + 0.5
			end
		end
		ani.FObject:SetAlpha(ani.alpha);
		ani.FObject:SetPoint("CENTER", "UIParent", "CENTER", ani.posX + DEX_Get("DEX_PosX"), ani.posY + DEX_Get("DEX_PosY"));
		--DEX_RefressBottom(ani);
	else
		if thetime >= 1.5 then DEX_aniClear(ani);end
	end
end

function DEX_aniClear(ani)
	if ani.crit == 1 then
		if ani.critId < DEX_critFlag then DEX_critFlag = ani.critId;end
	end
	DEX_aniReset(ani);
end

function DEX_BuildText(damage,spell,color,colorSe)
	if DEX_Get("DEX_NumberFormat") == 1 and (tonumber(damage) or string.find(damage,"%(")) then
		if string.find(damage,"%(") then
			local healstart,_ = string.find(damage,"%(");
			local _,healend = string.find(damage,"%)");
			--damage = number_format(string.sub(damage,1,healstart-2),",").."("..number_format(string.sub(damage,healstart+1,healend-1),",")..")"
			--Edited by Farever
			damage = amount_format(string.sub(damage,1,healstart-2)).."("..amount_format(string.sub(damage,healstart+1,healend-1))..")"
		else
			--damage = number_format(damage, ",")
			--Edited by Farever
			damage = amount_format(damage)
		end
	end

	if DEX_Get("DEX_ShowSpellIcon") == 1 then				--Show Icons instead of Spell Name
		local icons = ""
		local iconsize = DEX_TEXTSIZE;
		if select(3,GetSpellInfo(spell))~=nil then icons ="|T"..select(3,GetSpellInfo(spell))..":"..(iconsize / 2.5).."|t";	end
		if DEX_Get("DEX_ColorMode") == 1 then
			return damage.." "..icons
		elseif DEX_Get("DEX_ColorMode") == 3 then
			return DEX_TranTxt(damage.." ",color,colorSe)..icons
		else
			return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..icons.."|r"
		end
	else
		if DEX_Get("DEX_ColorMode") == 1 then
			return damage.." "..spell
		elseif DEX_Get("DEX_ColorMode") == 3 then
			return DEX_TranTxt(damage.." "..spell,color,colorSe)
		else
			return damage.." "..DEX_ColorFlip(colorSe[1],colorSe[2],colorSe[3])..spell.."|r"
		end	
	end
end

function DEX_AddText(damage,spell,damagetype,crit,iscurTarget,coerciveShowSpell,...)
	if spell == nil then spell = "";end
	if damage == nil then damage = 0;end
	
	if DEX_ExtraAttCount > 0 then
		if GetTime() - DEX_ExtraTimer > 0.4 then
			DEX_ExtraAttCount = 0;
			DEX_ExtraAttCur = 1;
		end
	end
	local color = {1,1,1};
	local colorSe = {1,1,1};
	local isAOE = false
	local isNumber = false
	if tonumber(damage) then isNumber = true;end
	if aoeList and spell ~= "" then
		isAOE = aoeList[spell]
	end

	if damagetype == DEX_DAMAGE_TYPE_HIT then
		color = DEX_Get("DEX_ColorNormal");
		colorSe = DEX_Get("DEX_ColorNormalSe");
	elseif damagetype == DEX_DAMAGE_TYPE_SPELL then
		color = DEX_Get("DEX_ColorSkill");
		colorSe = DEX_Get("DEX_ColorSkillSe");
	elseif damagetype == DEX_DAMAGE_TYPE_PERIODIC then
		if DEX_Get("DEX_ShowDamagePeriodic") ~= 1 then return;end
		color = DEX_Get("DEX_ColorPeriodic");
		colorSe = DEX_Get("DEX_ColorPeriodicSe");
	elseif damagetype == DEX_DAMAGE_TYPE_HEALTH then
		if DEX_Get("DEX_ShowDamageHealth") ~= 1 then return;end
		color = DEX_Get("DEX_ColorHealth");
		colorSe = DEX_Get("DEX_ColorHealthSe");
		if DEX_OverHeal ~= 0 then
			if DEX_Get("DEX_ShowOverHeal") == 1 then
				damage = (damage - DEX_OverHeal).." ("..DEX_OverHeal..")";
			else
				damage = damage - DEX_OverHeal;
				if damage == 0 then return;end
			end
		end
	elseif damagetype == DEX_DAMAGE_TYPE_PET then
		if DEX_Get("DEX_ShowDamagePet") ~= 1 then return;end
		color = DEX_Get("DEX_ColorPet");
		colorSe = color;
	elseif damagetype == DEX_DAMAGE_TYPE_HONOR then
		color = DEX_Get("DEX_ColorSpec");
		colorSe = DEX_Get("DEX_ColorSpecSe");
	elseif damagetype == DEX_DAMAGE_TYPE_MANA then
		color = DEX_Get("DEX_ColorMana");
		colorSe = DEX_Get("DEX_ColorManaSe");
	end

	local ani = dex_AniData["aniText"..dex_lastani]
	DEX_aniReset(ani)

	if DEX_Get("DEX_UniteSpell") == 1 and tonumber(damage) then
		ani.spellbak = spell
		ani.damagebak = tonumber(damage)
		ani.destbak = select(1,...)
		if spell ~= "" then
			--查找有無可合併的傷害
			local anitmp;
			local t = GetTime()
			for i = 1,DEX_MAXANI do
				anitmp = dex_AniData["aniText"..i];
				if anitmp.Active then
					if t - anitmp.starttime < 0.2 then
--						if spell == anitmp.spellbak and anitmp.destbak == select(1,...) then
						if spell == anitmp.spellbak then						-- Modify include AOE
							ani.Active = false;
							if DEX_Get("DEX_ShowSpellName") ~= 1 or (DEX_Get("DEX_ShowSpellName") == 1 and DEX_Get("DEX_ShowNameOnCrit") == 1 and (crit ~= 1 and anitmp.crit ~= 1))  or isAOE then spell = "";end
							-- Modify conditions of show spell name . AOE force to hide spell name.
							anitmp.damagebak = anitmp.damagebak + tonumber(damage)
							anitmp.FObject:SetText(DEX_BuildText(anitmp.damagebak,spell,color,colorSe))
							if crit == 1 and anitmp.crit == 0 then
								anitmp.zoom = 0.8
								anitmp.crit = 1
								anitmp.moveTyp = DEX_MOVTYP_NONE
							end
							return
						end
					end
				end
			end
		end
	end

	if not coerciveShowSpell then
		if DEX_Get("DEX_ShowNameOnCrit") == 1 and crit ~= 1 and isNumber then spell = "";end
		if DEX_Get("DEX_ShowNameOnMiss") == 1 then
			if isNumber and DEX_Get("DEX_ShowNameOnCrit") ~= 1 then spell = "";end
		end
	end
	if DEX_Get("DEX_ShowSpellName") ~= 1 then spell = "";end


	if DEX_Get("DEX_ShowWithMess") == 1 then
		local Maxline = DEX_logLine;
		local anitmp;
		if crit == 1 then damage = DEX_TXT_CRIT..damage; end
		for i = 1,10 do
			anitmp = dex_AniData["aniText"..i];
			anitmp.posY = anitmp.posY + DEX_Get("DEX_FontSize");
			anitmp.FObject:SetPoint("CENTER", "UIParent", "CENTER", anitmp.posX + DEX_Get("DEX_PosX"), anitmp.posY + DEX_Get("DEX_PosY"));
		end
		anitmp = dex_AniData["aniText"..dex_lastani];
		DEX_aniReset(anitmp);
		anitmp.starttime = GetTime();
		anitmp.Active = true;
		anitmp.posY = 0;
		anitmp.posX = 0;
		anitmp.FObject:SetText(damage.." "..spell);
		anitmp.FObject:SetAlpha(1);
		anitmp.FObject:SetTextColor(color[1], color[2], color[3]);
		anitmp.FObject:SetPoint("CENTER", "UIParent", "CENTER", anitmp.posX + DEX_Get("DEX_PosX"), anitmp.posY + DEX_Get("DEX_PosY"));
		dex_lastani = dex_lastani + 1;
		if dex_lastani > DEX_logLine then dex_lastani = 1;end
		return;
	end

	ani.Active = true;
	ani.height = DEX_TEXTSIZE;
	ani.crit = crit;
	ani.uid = DEX_ANI_UID


	if damagetype == DEX_DAMAGE_TYPE_PET then
		ani.posX = ani.posX - DEX_TEXTSIZE * 2.5;
		ani.moveTyp = DEX_MOVTYP_PET;

		if dex_petbottom - ani.baseY < ani.height + 2 then
			local fixY = ani.height + 2 + ani.baseY - dex_petbottom;
			local anitmp;
			for i = 1,DEX_MAXANI do
				anitmp = dex_AniData["aniText"..i];
				if i ~= dex_lastani and anitmp.Active and anitmp.moveTyp == DEX_MOVTYP_PET then
					anitmp.baseY = anitmp.baseY + fixY;
				end
			end
		end
	end

	if ani.moveTyp == DEX_MOVTYP_NORMAL then
		if dex_bottom - ani.baseY < ani.height + 2 then
			local fixY = ani.height + 2 + ani.baseY - dex_bottom;
			local anitmp;
			for i = 1,DEX_MAXANI do
				anitmp = dex_AniData["aniText"..i];
				if i ~= dex_lastani and anitmp.Active and anitmp.moveTyp == DEX_MOVTYP_NORMAL then
					anitmp.baseY = anitmp.baseY + fixY;
				end
			end
		end
	end

	if crit == 1 then
		if damagetype ~= DEX_DAMAGE_TYPE_PET then
			if spell == "" then
				ani.zoom = 2;
			else
				ani.zoom = 0.6;
			end
		else
			ani.zoom = 1.5;
		end
		if DEX_Get("DEX_ShowSpellName") == 1 and DEX_Get("DEX_ShowNameOnCrit") == 1 and spell ~= "" then
			ani.zoom = 0.8;
		else
			ani.critTyp = 1;
		end
		if damagetype ~= DEX_DAMAGE_TYPE_PET then
			ani.critId = DEX_critFlag;
			--ani.posX = ani.posX + DEX_TEXTSIZE * 2 + DEX_critFlag * 30;
			--ani.posY = DEX_critFlag * DEX_TEXTSIZE;
			if DEX_ExtraAttCur > DEX_ExtraAttCount and DEX_ExtraAttCount == 0 then
				ani.moveTyp = DEX_MOVTYP_NONE;
			end

			ani.posYbak = ani.posY;

			DEX_critFlag = DEX_critFlag + 1;
			if DEX_critFlag > 3 then DEX_critFlag = 0;end
		end
	end

	if (crit == 1 and damagetype ~= DEX_DAMAGE_TYPE_PET)  or damagetype == DEX_DAMAGE_TYPE_HONOR then
		ani.posX = random(120) - 60;
		ani.posY = random(80) - 20;
		local f = DEX_Get("DEX_FontSize") + 2 + random(10);
		local i,j
		for i = 1,2 do

			if i == 1 then j = 2;else j = 1;end
			if dex_AniData["aniText"..DEX_CritFix[i].aid].Active and dex_AniData["aniText"..DEX_CritFix[i].aid].uid == DEX_CritFix[i].uid then
				if math.abs(ani.posY - DEX_CritFix[i].y) < 20 then
					if dex_AniData["aniText"..DEX_CritFix[j].aid].Active and dex_AniData["aniText"..DEX_CritFix[j].aid].uid == DEX_CritFix[j].uid then
						if DEX_CritFix[i].y < DEX_CritFix[j].y then
							ani.posY = DEX_CritFix[i].y - f;
						else
							ani.posY = DEX_CritFix[i].y + f;
						end
					else
						if random(2) == 1 then
							ani.posY = DEX_CritFix[i].y - f;
						else
							ani.posY = DEX_CritFix[i].y + f;
						end
					end
				end
			end
		end
		ani.posYbak = ani.posY;

		DEX_CritFix[2].y = DEX_CritFix[1].y
		DEX_CritFix[2].aid = DEX_CritFix[1].aid
		DEX_CritFix[2].uid = DEX_CritFix[1].uid
		DEX_CritFix[1].y = ani.posY
		DEX_CritFix[1].aid = dex_lastani
		DEX_CritFix[1].uid = DEX_ANI_UID

		ani.moveTyp = DEX_MOVTYP_NONE;
	end

	if damagetype == DEX_DAMAGE_TYPE_HONOR then
		ani.critTyp = 1
		ani.zoom = 1.35;
		ani.moveTyp = DEX_MOVTYP_NONE;
	end

	if isAOE then
		--ani.crit = 0;
		ani.moveTyp = DEX_MOVTYP_AOE;

		if DEX_aoeNew == 1 then	DEX_AoeReset();end

		if GetTime() - DEX_aoeStartTimer >= 0.7 then DEX_AoeReset(); end
		ani.posY = 30;
		if DEX_aoeDct == 0 then
			ani.posX = -DEX_TEXTSIZE * 2 * DEX_aoeId - 20;
		else
			ani.posX = DEX_TEXTSIZE * 2 * DEX_aoeId + 20;
		end
		ani.starttime = GetTime() + DEX_aoeId * 0.05;

		DEX_aoeDct = DEX_aoeDct + 1;
		if DEX_aoeDct >= 2 then
			DEX_aoeId = DEX_aoeId + 1;
			DEX_aoeDct = 0;
		end
		spell = "";
	end
	if DEX_ExtraAttCur <= DEX_ExtraAttCount and damagetype == DEX_DAMAGE_TYPE_HIT then
		DEX_ExtraAttList[DEX_ExtraAttCur] = dex_lastani;
		if DEX_ExtraAttCur > 0 then
			local tmpani;

			ani.FObject:SetText(damage);

			tmpani = dex_AniData["aniText"..DEX_ExtraAttList[0]];
			if DEX_ExtraAttCur == 1 then
				ani.posX = tmpani.posX + tmpani.FObject:GetStringWidth()/2 + ani.FObject:GetStringWidth()/2 + 4;
			else
				ani.posX = tmpani.posX - tmpani.FObject:GetStringWidth()/2 - ani.FObject:GetStringWidth()/2 - 4;
			end
			ani.posY = tmpani.posY;
			ani.baseY = tmpani.baseY;
			ani.Extra = ani.posX;

			ani.starttime = tmpani.starttime;
		end
		DEX_ExtraAttCur = DEX_ExtraAttCur + 1;
	else
		DEX_ExtraAttCount = 0;
		DEX_ExtraAttCur = 1;
	end

	if not iscurTarget and  damagetype ~= DEX_DAMAGE_TYPE_PET and ani.moveTyp ~= DEX_MOVTYP_AOE then
		ani.moveTyp = DEX_MOVTYP_OTHER
		ani.posY = DEX_GetMovTypOtherPosY()
		ani.posYbak = ani.posY
	end

	ani.FObject:SetText(DEX_BuildText(damage,spell,color,colorSe))

	DEX_RefressBottom(ani);
	ani.FObject:SetTextColor(color[1], color[2], color[3]);
	ani.FObject:SetPoint("CENTER", "UIParent", "CENTER", ani.posX + DEX_Get("DEX_PosX"), ani.posY + DEX_Get("DEX_PosY"));
	ani.FObject:SetAlpha(ani.alpha);
	ani.starttime = GetTime();

	DEX_ANI_UID = DEX_ANI_UID + 1
	dex_lastani = dex_lastani + 1;
	if dex_lastani > DEX_MAXANI then dex_lastani = tonumber(DEX_Get("DEX_LOGLINE")) * tonumber(DEX_Get("DEX_ShowWithMess")) + 1;end
end

function DEX_AoeReset()
	DEX_aoeNew = 0;
	DEX_aoeId = 1;
	DEX_aoeDct = 0;
	DEX_aoeStartTimer = GetTime();
end

function DEX_aniInit()
	DEX_OUTLINE = DEX_FONTEFF[DEX_Get("DEX_OutLine")].ol
	dex_lastani = 1

	DEX_FONTNAME = DEX_FontList[DEX_Get("DEX_Font") or 1]

	DEX_SHADOW = DEX_FONTEFF[DEX_Get("DEX_OutLine")].shadowOff

	DEX_TEXTSIZE = DEX_Get("DEX_FontSize");
	for key, value in pairs(dex_AniData) do
		value.FObject = getglobal("DEX"..key);
		DEX_aniReset(value);
	end
	DEX_Set_WOWDamage();
end

function DEX_staticInit()
	DEX_logLine = DEX_Get("DEX_LOGLINE");
	DEX_logTime = DEX_Get("DEX_LOGTIME");
end

function DEX_aniReset(aniData)
	aniData.Active = false;
	aniData.crit = false;
	aniData.starttime = 0
	aniData.moveTyp = DEX_MOVTYP_NORMAL;
	aniData.critId = 0;
	aniData.critTyp = 0;
	aniData.posY = 0;
	aniData.posX = 0;
	aniData.posYbak = 0;
	aniData.zoom = 0;
	aniData.baseY = 0;
	aniData.alpha = 0;
	aniData.height = DEX_TEXTSIZE;
	aniData.delay = 0;
	aniData.lastupdate = 0;
	aniData.Extra = 0
	aniData.spellbak = ""
	aniData.damagebak = 0
	aniData.destbak = 0

	DEX_SetFontSize(aniData,DEX_TEXTSIZE)
	aniData.FObject:SetText("");
	aniData.FObject:SetTextHeight(aniData.height);
	aniData.FObject:SetAlpha(aniData.alpha);
	aniData.FObject:SetPoint("CENTER", "UIParent", "CENTER", aniData.posX, aniData.posY);
end

function DEX_SetFontSize(ani,size)
	ani.FObject:SetFont(DEX_FONTNAME, size,DEX_OUTLINE);
	ani.FObject:SetShadowOffset(DEX_SHADOW,-DEX_SHADOW);
end

function DEX_ExtraAttack(num)
	DEX_ExtraAttCount = num;
	DEX_ExtraAttCur = 0;
	DEX_ExtraTimer = GetTime();
end

function DEX_Set_WOWDamage()
	if (DEX_Get("DEX_ShowDamageWoW") == 0) then
		SetCVar("floatingCombatTextCombatDamage", 0);
		--SetCVar("floatingCombatTextCombatHealing", 0);
	else
		SetCVar("floatingCombatTextCombatDamage", 1);
		--SetCVar("floatingCombatTextCombatHealing", 1);
	end
end

function DEX_ToDec(a)
	local i = 0;
	while a - i > 1 do
		i = i + 1;
	end
	return i;
end
function DEX_ToHEX(a)
	if a < 0 then a = 0;end
	if a > 1 then a = 1;end
	local b = a * 256;
	return ""..DEX_HEX_LIST[DEX_ToDec(b / 16) + 1]..DEX_HEX_LIST[ DEX_ToDec( ( b / 16 - DEX_ToDec(b / 16) ) * 16 ) + 1];
end
function DEX_ColorFlip(r,g,b)
	return "|cff"..DEX_ToHEX(r)..DEX_ToHEX(g)..DEX_ToHEX(b);
end

function DEX_TranTxt(txt,rgb1,rgb2)
	local tc = string.len(txt)
	local i
	local c = 0
	for i = 1,tc do
		if string.byte(txt,i,i) < 128 then
			if string.byte(txt,i,i) ~= 32 then c = c + 1;end
		else
			c = c + 1
			i = i + 2
		end
	end

	if c < 2 then return txt;end
	local re = ""
	local w = 1
	local rs,gs,bs
	rs = (rgb2[1] - rgb1[1]) / (c - 1)
	gs = (rgb2[2] - rgb1[2]) / (c - 1)
	bs = (rgb2[3] - rgb1[3]) / (c - 1)

	for i = 1,c + 1 do
		if w > 1 then
			w = w - 1
		else
			if string.byte(txt,i) < 128 then
				w = 1
			else
				w = 3
			end
			re = re..DEX_ColorFlip(rgb1[1] + rs * (i - 1),rgb1[2] + gs * (i - 1),rgb1[3] + bs * (i - 1))..string.sub(txt,i,i + w - 1).."|r"
		end
	end
	return re
end


function number_format(num,deperator)  
    local str1 =""  
    local str = tostring(num)  
    local strLen = string.len(str)  
          
    if deperator == nil then  
        deperator = ","  
    end  
    deperator = tostring(deperator)  
          
    for i=1,strLen do  
        str1 = string.char(string.byte(str,strLen+1 - i)) .. str1  
        if math.fmod(i,3) == 0 then  
            --下一个数 还有  
            if strLen - i ~= 0 then  
                str1 = ","..str1  
            end  
        end  
    end  
    return str1  
end 

--格式化数字:以W和E为单位 @author:Farever
function amount_format(num)
	local strReturn =""
	local str = tostring(num)
	local strLen = string.len(str)

	if strLen > 0 then
		local number = tonumber(num)
		--trans to number successfully
		if number then
			if number < 9999 then
				strReturn = number
			elseif number < 99999999 then
				strReturn = string.format("%.1f万",number / 10000)
			elseif number < 99999999999 then
				strReturn = string.format("%.2f亿",number / 100000000)
			end
		--if nil : fail to trans to number
		else
			strReturn = num
		end
	end
	return strReturn
end 