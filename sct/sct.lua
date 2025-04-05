--[[
  ****************************************************************
  Scrolling Combat Text

  Author: Grayhoof
  ****************************************************************

  Official Site:
    http://grayhoof.wowinterface.com

  ****************************************************************]]
SCT = LibStub("AceAddon-3.0"):NewAddon("SCT", "AceEvent-3.0", "AceTimer-3.0", "AceConsole-3.0", "AceHook-3.0")
local SCT = SCT
local db

SCT.title = "sct"
SCT.version = GetAddOnMetadata(SCT.title, "Version")

--embedded libs
local media = LibStub("LibSharedMedia-3.0")

--Table Constants
SCT.SPELL_COLORS_TABLE = "SPELLCOLORS"
SCT.COLORS_TABLE = "COLORS"
SCT.CRITS_TABLE = "CRITS"
SCT.FRAMES_TABLE = "FRAMES"
SCT.FRAMES_DATA_TABLE = "FRAMESDATA"
SCT.FRAME1 = 1
SCT.FRAME2 = 2
SCT.MSG = 10

-- local constants
local last_hp_percent = 0
local last_hp_target_percent = 0
local last_mana_percent = 0
local last_mana_full = 0
local last_cp_full = 0
local menuloaded = false

local RUNETYPE_BLOOD = 1; -- see RuneFrame.lua
local RUNETYPE_FROST = 2;
local RUNETYPE_UNHOLY = 3;
local RUNETYPE_DEATH = 4;
local MAX_RUNE_CAPACITY = 7
local last_runes_usable = {}

local FrameForOnUpdate = CreateFrame("FRAME")
local FrameForOnUpdate_updateInterval = 0.1
local FrameForOnUpdate_timeSinceLastUpdate = 0

local CD_cooldowns, CD_watching, CD_ignoredSpells = {}, {}, {}

-- classic support
local isWoWClassic, isWoWBcc, isWoWWotlkc, isWoWSl, isWoWRetail = false, false, false, false, false;
if (_G["WOW_PROJECT_ID"] == _G["WOW_PROJECT_CLASSIC"]) then
	isWoWClassic = true;
elseif (_G["WOW_PROJECT_ID"] == _G["WOW_PROJECT_BURNING_CRUSADE_CLASSIC"]) then
	isWoWBcc = true;
elseif (_G["WOW_PROJECT_ID"] == _G["WOW_PROJECT_WRATH_CLASSIC"]) then
	isWoWWotlkc = true;
else -- retail
	if (_G["LE_EXPANSION_LEVEL_CURRENT"] == _G["LE_EXPANSION_SHADOWLANDS"]) then
		isWoWSl = true;
	else
		isWoWRetail = true;
	end
end

--Blizzard APi calls
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitName = UnitName
local UnitIsFriend = UnitIsFriend
local UnitIsDead = UnitIsDead
local UnitIsCorpse = UnitIsCorpse
local UnitIsFeignDeath = UnitIsFeignDeath
local UnitGUID = UnitGUID
local UnitPowerType = UnitPowerType
local PlaySound = PlaySound
local PlaySoundFile = PlaySoundFile
local GetActionInfo = GetActionInfo
local GetActionTexture = GetActionTexture
local GetInventoryItemID = GetInventoryItemID
local GetInventoryItemTexture = GetInventoryItemTexture
local GetItemCooldown = GetItemCooldown
local GetItemInfo = GetItemInfo
local GetNumRaidMembers = GetNumRaidMembers
local GetNumPartyMembers = GetNumPartyMembers
local GetPetActionCooldown = GetPetActionCooldown
local GetPetActionInfo = GetPetActionInfo
local GetRuneCooldown = GetRuneCooldown
local GetRuneType = GetRuneType
local GetSpellCooldown = GetSpellCooldown
local GetSpellInfo = GetSpellInfo
local GetSpellTexture = GetSpellTexture
local GetTime = GetTime
local IsInInstance = IsInInstance

local C_Container_GetContainerItemID
if C_Container and C_Container.GetContainerItemID then -- since df 10.0.2
	C_Container_GetContainerItemID = C_Container.GetContainerItemID
else -- before df 10.0.2
	C_Container_GetContainerItemID = GetContainerItemID
end


-- see "Blizzard_Deprecated.lua" for 10.0.0
local InterfaceOptions_AddCategory = InterfaceOptions_AddCategory;

if (not InterfaceOptions_AddCategory) then
	InterfaceOptions_AddCategory = function(frame, addOn, position)
		-- cancel is no longer a default option. May add menu extension for this.
		frame.OnCommit = frame.okay;
		frame.OnDefault = frame.default;
		frame.OnRefresh = frame.refresh;

		if frame.parent then
			local category = Settings.GetCategory(frame.parent);
			local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, frame, frame.name, frame.name);
			subcategory.ID = frame.name;
			return subcategory, category;
		else
			local category, layout = Settings.RegisterCanvasLayoutCategory(frame, frame.name, frame.name);
			category.ID = frame.name;
			Settings.RegisterAddOnCategory(category);
			return category;
		end
	end
end

--LUA calls
local pairs = pairs
local tonumber = tonumber
local strsub = strsub
local strlen = strlen
local gsub = gsub
local string_match = string.match
local string_format = string.format
local string_find = string.find
local string_split = string.split
local function string_nil(val)
  if val then
    return val
  else
    return UNKNOWN
  end
end

local function shortenValue(value)
  if value >= 10000000 then
    value = string_format("%.0fm", value / 1000000)
  elseif value >= 1000000 then
    value = string_format("%.1fm", value / 1000000)
  elseif value >= 100000 then
    value = string_format("%.0fk",value / 1000)
  elseif value >= 10000 then
    value = string_format("%.0fk", value / 1000)
  elseif value >= 1000 then
    value = string_format("%.1fk", value / 1000)
  end
  return value
end

--combat log locals
local CombatLog_Object_IsA = CombatLog_Object_IsA
local skillmsg = gsub(gsub(gsub(SKILL_RANK_UP, '%d%$', ''), '%%s', '(.+)'), '%%d', '(%%d+)')

local COMBATLOG_OBJECT_NONE = COMBATLOG_OBJECT_NONE
local COMBATLOG_FILTER_MINE = COMBATLOG_FILTER_MINE
local COMBATLOG_FILTER_MY_PET = COMBATLOG_FILTER_MY_PET
local COMBATLOG_FILTER_HOSTILE = bit.bor(
            COMBATLOG_FILTER_HOSTILE_PLAYERS,
            COMBATLOG_FILTER_HOSTILE_UNITS)
local COMBATLOG_FILTER_PLAYER = bit.bor(
            COMBATLOG_OBJECT_AFFILIATION_MASK,
            COMBATLOG_OBJECT_REACTION_MASK,
            COMBATLOG_OBJECT_TYPE_PLAYER,
            COMBATLOG_OBJECT_CONTROL_PLAYER)

local COMBAT_EVENTS = {
  ["SWING_DAMAGE"] = "DAMAGE",
  ["RANGE_DAMAGE"] = "DAMAGE",
  ["SPELL_DAMAGE"] = "DAMAGE",
  ["SPELL_PERIODIC_DAMAGE"] = "DAMAGE",
  ["ENVIRONMENTAL_DAMAGE"] = "DAMAGE",
  ["DAMAGE_SHIELD"] = "DAMAGE",
  ["DAMAGE_SPLIT"] = "DAMAGE",
  ["SPELL_HEAL"] = "HEAL",
  ["SPELL_PERIODIC_HEAL"] = "HEAL",
  ["SWING_MISSED"] = "MISS",
  ["RANGE_MISSED"] = "MISS",
  ["SPELL_MISSED"] = "MISS",
  ["SPELL_PERIODIC_MISSED"] = "MISS",
  ["DAMAGE_SHIELD_MISSED"] = "MISS",
  ["SPELL_DRAIN"] = "DRAIN",
  ["SPELL_LEECH"] = "DRAIN",
  ["SPELL_PERIODIC_DRAIN"] = "DRAIN",
  ["SPELL_PERIODIC_LEECH"] = "DRAIN",
  ["SPELL_ENERGIZE"] = "POWER",
  ["SPELL_PERIODIC_ENERGIZE"] = "POWER",
  ["SPELL_INTERRUPT"] = "INTERRUPT",
  ["PARTY_KILL"] = "DEATH",
  ["UNIT_DIED"] = "DEATH",
  ["UNIT_DESTROYED"] = "DEATH",
  ["SPELL_AURA_APPLIED"] = "BUFF",
  ["SPELL_PERIODIC_AURA_APPLIED"] = "BUFF",
  ["SPELL_AURA_APPLIED_DOSE"] = "BUFF",
  ["SPELL_PERIODIC_AURA_APPLIED_DOSE"] = "BUFF",
  ["SPELL_AURA_REMOVED"] = "FADE",
  ["SPELL_PERIODIC_AURA_REMOVED"] = "FADE",
  ["SPELL_AURA_REMOVED_DOSE"] = "FADE",
  ["SPELL_PERIODIC_AURA_REMOVED_DOSE"] = "FADE",
  ["ENCHANT_APPLIED"] = "ENCHANT_APPLIED",
  ["ENCHANT_REMOVED"] = "ENCHANT_REMOVED",
  ["SPELL_SUMMON"] = "SUMMON",
  ["SPELL_CREATE"] = "SUMMON",
  ["SPELL_DISPEL"] = "DISPEL",
  ["SPELL_STOLEN"] = "DISPEL",
  ["SPELL_CAST_START"] = "CAST",
  ["SPELL_CAST_SUCCESS"] = "CAST",
}

local SCHOOL_STRINGS
if (Enum.Damageclass) then -- not available in classic
  SCHOOL_STRINGS = {
    [Enum.Damageclass.MaskPhysical] = SPELL_SCHOOL0_CAP,
    [Enum.Damageclass.MaskHoly] = SPELL_SCHOOL1_CAP,
    [Enum.Damageclass.MaskFire] = SPELL_SCHOOL2_CAP,
    [Enum.Damageclass.MaskNature] = SPELL_SCHOOL3_CAP,
    [Enum.Damageclass.MaskFrost] = SPELL_SCHOOL4_CAP,
    [Enum.Damageclass.MaskShadow] = SPELL_SCHOOL5_CAP,
    [Enum.Damageclass.MaskArcane] = SPELL_SCHOOL6_CAP,
  }
else
  SCHOOL_STRINGS = {
    [SCHOOL_MASK_PHYSICAL] = SPELL_SCHOOL0_CAP,
    [SCHOOL_MASK_HOLY] = SPELL_SCHOOL1_CAP,
    [SCHOOL_MASK_FIRE] = SPELL_SCHOOL2_CAP,
    [SCHOOL_MASK_NATURE] = SPELL_SCHOOL3_CAP,
    [SCHOOL_MASK_FROST] = SPELL_SCHOOL4_CAP,
    [SCHOOL_MASK_SHADOW] = SPELL_SCHOOL5_CAP,
    [SCHOOL_MASK_ARCANE] = SPELL_SCHOOL6_CAP,
  }
end

local POWER_STRINGS = {
  [Enum.PowerType.Mana] = MANA,
  [Enum.PowerType.Rage] = RAGE,
  [Enum.PowerType.Focus] = FOCUS,
  [Enum.PowerType.Energy] = ENERGY,
  [Enum.PowerType.ComboPoints] = COMBO_POINTS,
  [Enum.PowerType.Runes] = RUNES,
  [Enum.PowerType.RunicPower] = RUNIC_POWER,
  [Enum.PowerType.SoulShards] = SOUL_SHARDS,
  [Enum.PowerType.LunarPower] = LUNAR_POWER,
  [Enum.PowerType.HolyPower] = HOLY_POWER,
  [Enum.PowerType.Alternate] = ALTERNATE_RESOURCE_TEXT,
  [Enum.PowerType.Maelstrom] = MAELSTROM_POWER,
  [Enum.PowerType.Chi] = CHI_POWER,
  [Enum.PowerType.Insanity] = INSANITY_POWER,
  [Enum.PowerType.ArcaneCharges] = ARCANE_CHARGES_POWER,
  [Enum.PowerType.Fury] = FURY,
  [Enum.PowerType.Pain] = PAIN,
}

local POWER_TOKEN = {
  [Enum.PowerType.Mana] = "MANA",
  [Enum.PowerType.Rage] = "RAGE",
  [Enum.PowerType.Focus] = "FOCUS",
  [Enum.PowerType.Energy] = "ENERGY",
  [Enum.PowerType.ComboPoints] = "COMBO_POINTS",
  [Enum.PowerType.Runes] = "RUNES",
  [Enum.PowerType.RunicPower] = "RUNIC_POWER",
  [Enum.PowerType.SoulShards] = "SOUL_SHARDS",
  [Enum.PowerType.LunarPower] = "LUNAR_POWER",
  [Enum.PowerType.HolyPower] = "HOLY_POWER",
  [Enum.PowerType.Alternate] = "ALTERNATE_RESOURCE_TEXT",
  [Enum.PowerType.Maelstrom] = "MAELSTROM_POWER",
  [Enum.PowerType.Chi] = "CHI_POWER",
  [Enum.PowerType.Insanity] = "INSANITY_POWER",
  [Enum.PowerType.ArcaneCharges] = "ARCANE_CHARGES_POWER",
  [Enum.PowerType.Fury] = "FURY",
  [Enum.PowerType.Pain] = "PAIN",
}

local SHADOW_STRINGS = {
  [1] = "",
  [2] = "OUTLINE",
  [3] = "THICKOUTLINE"
}

local RUNE_STRINGS = {
	[RUNETYPE_BLOOD] = { text = COMBAT_TEXT_RUNE_BLOOD, icon = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood", color = { r=1,g=0,b=0 } },
	[RUNETYPE_UNHOLY] = { text = COMBAT_TEXT_RUNE_UNHOLY, icon = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Unholy", color = { r=0,g=.5,b=0 } },
	[RUNETYPE_FROST] = { text = COMBAT_TEXT_RUNE_FROST, icon = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Frost", color = { r=0,g=1,b=1 } },
	[RUNETYPE_DEATH] = { text = COMBAT_TEXT_RUNE_DEATH, icon = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death", color = { r=.8,g=.1,b=1 } },
}

----------------------
--Called on login
function SCT:OnEnable()
  self:RegisterSelfEvents()
end

----------------------
-- called on standby
function SCT:OnDisable()
  self:DisableAll()
end

----------------------
-- Disable all events
function SCT:DisableAll()
  -- no more events to handle
  self:UnregisterAllEvents()
end

----------------------
-- Show the Option Menu
local function openOptions(categoryName, subcategoryName)
	if Settings and Settings.OpenToCategory then -- since df
		for index, tbl in ipairs(SettingsPanel:GetCategoryList().groups) do -- see SettingsPanelMixin:OpenToCategory() in "Blizzard_SettingsPanel.lua"
			for index, category in ipairs(tbl.categories) do
				if category:GetName() == categoryName then
					Settings.OpenToCategory(category:GetID(), category:GetName())
					if subcategoryName then
						for index, subcategory in ipairs(category:GetSubcategories()) do
							if subcategory:GetName() == subcategoryName then
								SettingsPanel:SelectCategory(subcategory)
								return
							end
						end
					end
					return
				end
			end
		end
	else -- before df
		if (not InterfaceOptionsFrame:IsShown()) then
			InterfaceOptionsFrame_Show()
		end
		InterfaceOptionsFrame_OpenToCategory(categoryName)
		if subcategoryName then
			InterfaceOptionsFrame_OpenToCategory(subcategoryName)
		end
	end
end

function SCT:ShowMenu(makeBlizzOptionsOnly)
  local loaded, message = LoadAddOn("sct_options")
  if (loaded) then
    PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
    if not menuloaded then
      SCT:MakeBlizzOptions()
      menuloaded = true
    else
      SCT:OptionsFrame_OnShow()
    end
	if (not makeBlizzOptionsOnly) then
	  openOptions("SCT", "SCT "..SCT.LOCALS.OPTION_MISC21.name)
	end
  else
    PlaySound(SOUNDKIT.TELL_MESSAGE)
    SCT:Print(SCT.LOCALS.Load_Error.." "..message)
  end
end

----------------------
--Hide the Option Menu
function SCT:HideMenu()
  PlaySound(SOUNDKIT.IG_MAINMENU_CLOSE)
  HideUIPanel(SCTOptions)
end

local slashHandler = function(option)
  local self = SCT
  if option == "menu" then
    self:ShowMenu()
  elseif option == "reset" then
    self:Reset()
  else
    self:Print(self.version)
    self:Print("/sct menu")
    self:Print("/sct reset")
    self:Print("/sctdisplay")
  end
end

----------------------
--Called when Addon loaded
function SCT:OnInitialize()
  last_runes_usable = SCT:InitializeTable(last_runes_usable, true, 1, MAX_RUNE_CAPACITY)
  
  self.db = LibStub("AceDB-3.0"):New("SCT_CONFIG", self:GetDefaultConfig())
  self.eventdb = LibStub("AceDB-3.0"):New("SCT_EVENT_CONFIG", nil, "Global")

  self.db.RegisterCallback(self, "OnProfileChanged", "OnConfigRefreshed")
  self.db.RegisterCallback(self, "OnProfileCopied", "OnConfigRefreshed")
  self.db.RegisterCallback(self, "OnProfileReset", "OnConfigRefreshed")

  --local the profile table
  db = self.db.profile

  --set event defaults (not using a AceDB default table because how it handles nil values doesn't work well with custom events)
  if not self.eventdb.global.firstload or self.AlwaysLoadEvents then
    self.eventdb.global.firstload = true
    self.eventdb.global.events = {}
    for k,v in pairs(self.Events) do
      self.eventdb.global.events[k] = v
    end
  end
  self.EventConfig = self.eventdb.global.events
  
  -- On Config Refreshed
  self:OnConfigRefreshed()
  
  self:RegisterChatCommand("sct", slashHandler)
  self:RegisterChatCommand("sctmenu", function() self:ShowMenu() end)
  self:RegisterChatCommand("sctdisplay", function(x) self:CmdDisplay(x) end)

  --Shared Media
  for key, value in pairs(SCT.LOCALS.FONTS) do
    media:Register("font", value.name, value.path)
  end

  --register with other mods
  self:RegisterOtherMods()

  --setup animations
  self:AniInit()

  --cache custome events
  self:CacheCustomEvents()

  --disable healing flags on first load
  self:DisableHealingFlags()

  --setup Unit name plate tracking
  if (db["NAMEPLATES"]) then
    self:EnableNameplate()
  end
end

-------------------------
--Refresh config
function SCT:OnConfigRefreshed()
  --Fill CD_ignoredSpells for cooldown handling
  self:FillCdIgnoredSpells()
end

-------------------------
--Fill CD_ignoredSpells for cooldown handling
function SCT:FillCdIgnoredSpells()
  CD_ignoredSpells = {}
  for _, value in ipairs({strsplit(",", db["CDLIST"])}) do
    CD_ignoredSpells[strtrim(value)] = true
  end
end

----------------------
--Hook Function to show event
function SCT:AddMessage(frame, text, r, g, b, id)
    self.hooks[frame].AddMessage(frame, text.." |cff00ff00["..tostring(event).."]|r", r, g, b, id)
end

----------------------
--Reset everything to default
function SCT:Reset()
  self.db:ResetProfile()
  self:AniInit()
  self:HideMenu()
  self:ShowMenu()
  self:ShowExample()
  self:Print(SCT.LOCALS.PROFILE_NEW..self.db:GetCurrentProfile())
end

----------------------
--Get a value from player config
function SCT:Get(option, table)
  if (table) then
    return db[table][option]
  else
    return db[option]
  end
end

----------------------
--Set a value in player config
function SCT:Set(option, value, table)
  if (table) then
    db[table][option] = value
  else
    db[option] = value
  end
end

----------------------
--Display for any partial blocks
function SCT:DisplayBlock(blocked)
  SCT:Display_Event("SHOWBLOCK", string_format("%s (%s)", BLOCK, tostring(self:ShortenValue(blocked))))
end

----------------------
--Display for any partial absorbs
function SCT:DisplayAbsorb(absorbed)
  SCT:Display_Event("SHOWABSORB", string_format("%s (%s)", ABSORB, tostring(self:ShortenValue(absorbed))))
end


----------------------
--Player Health
function SCT:UNIT_HEALTH(event, larg1)
  if (larg1 ~= "player") then return end
  local warnlevel = db["LOWHP"] / 100
  local HPPercent = UnitHealth("player") / UnitHealthMax("player")
  if (HPPercent < warnlevel) and (last_hp_percent >= warnlevel) and (not UnitIsFeignDeath("player")) then
    if (db["PLAYSOUND"] and db["SHOWLOWHP"]) then
      PlaySound(PlaySoundKitID and "bind2_Impact_Base" or 3961)
    end
    self:Display_Event("SHOWLOWHP", string_format("%s (%s)", SCT.LOCALS.LowHP, tostring(self:ShortenValue(UnitHealth("player")))))
  end
  last_hp_percent = HPPercent
  return
end

----------------------
--Player Runes
function SCT:RUNE_POWER_UPDATE(event, runeIndex)
  if db["SHOWRUNES"] then
    --local usable = select(3, GetRuneCooldown(runeIndex))
	local usable = false --workaround for internal blizzard bug: runeIndex is set wrong if rune cooldown is finished
	local runeType = RUNETYPE_DEATH
	for ri=1, MAX_RUNE_CAPACITY do
	  local usableRuneRi = select(3, GetRuneCooldown(ri))
	  if (usableRuneRi and last_runes_usable[ri] == false) then
	    usable = true
		if (GetRuneType) then
			runeType = GetRuneType(ri)
		end
	  end
	  last_runes_usable[ri] = usableRuneRi
	end -- end of workaround
    local crit = db[self.CRITS_TABLE]["SHOWRUNES"]
    local showmsg = db[self.FRAMES_TABLE]["SHOWRUNES"] or 1
    if usable and (not UnitIsDead("player")) then
      if (showmsg == SCT.MSG) then
        self:DisplayMessage(RUNE_STRINGS[runeType].text, RUNE_STRINGS[runeType].color, RUNE_STRINGS[runeType].icon)
      else
        self:DisplayCustomEvent(RUNE_STRINGS[runeType].text, RUNE_STRINGS[runeType].color, crit, showmsg, nil, RUNE_STRINGS[runeType].icon)
      end
    end
  end
end

----------------------
--Player Mana / Combo Points
function SCT:UNIT_POWER_UPDATE(event, larg1, powerToken)
  if (larg1 ~= "player") then return end
  local powerType = self:GetKeyFromValue(POWER_TOKEN, powerToken)
  --warning for low mana
  if (powerType == Enum.PowerType.Mana) then
    if (UnitPowerType("player") == Enum.PowerType.Mana) then
      local warnlevel = db["LOWMANA"] / 100
      local ManaPercent = UnitPower("player") / UnitPowerMax("player")
      if (ManaPercent < warnlevel) and (last_mana_percent >= warnlevel) and (not UnitIsFeignDeath("player")) then
        if (db["PLAYSOUND"] and db["SHOWLOWMANA"]) then
          PlaySound(PlaySoundKitID and "ShaysBell" or 6555)
        end
        SCT:Display_Event("SHOWLOWMANA", string_format("%s (%s)", SCT.LOCALS.LowMana, tostring(self:ShortenValue(UnitPower("player")))))
      end
      last_mana_percent = ManaPercent
	end
  --combo points
  elseif (powerType == Enum.PowerType.ComboPoints) then
	if not db["SHOWCOMBOPOINTS"] then return end
	local sct_CP = UnitPower("player", Enum.PowerType.ComboPoints)
	local sct_CP_Max = UnitPowerMax("player", Enum.PowerType.ComboPoints)
	if (sct_CP ~= 0 and sct_CP > last_cp_full) then
	  local sct_CP_Message = string_format("%d %s", sct_CP, SCT.LOCALS.ComboPoint)
	  if (sct_CP == sct_CP_Max) then
		sct_CP_Message = sct_CP_Message.." "..SCT.LOCALS.CPMaxMessage
      end
      self:Display_Event("SHOWCOMBOPOINTS", sct_CP_Message)
	end
    last_cp_full = sct_CP
  --show all power
  elseif db["SHOWALLPOWER"] then
    local ManaFull = UnitPower("player")
    if (ManaFull > last_mana_full) then
      self:Display_Event("SHOWPOWER", string_format("+%d %s", ManaFull-last_mana_full, string_nil(POWER_STRINGS[UnitPowerType("player")])))
    end
    last_mana_full = ManaFull
  end
end

----------------------
--Player target change
function SCT:PLAYER_TARGET_CHANGED(event)
  if (not UnitIsFriend("target", "player") and (UnitIsDead("target")~=true) and (UnitIsCorpse("target")~=true)) then
    last_hp_target_percent = UnitHealth("target")
  else
    last_hp_target_percent = 100
  end
end

----------------------
--Power Change
function SCT:UNIT_DISPLAYPOWER(event, larg1)
  if (larg1 ~= "player") then return end
  last_mana_percent = UnitPower("player") / UnitPowerMax("player")
  last_mana_full = UnitPower("player")
end

----------------------
--Player Combat
function SCT:PLAYER_REGEN_DISABLED(event)
  self:Display_Event("SHOWCOMBAT", SCT.LOCALS.Combat)
end

----------------------
--Player NoCombat
function SCT:PLAYER_REGEN_ENABLED(event)
  self:Display_Event("SHOWCOMBAT", SCT.LOCALS.NoCombat)
end

----------------------
-- Skill Gains
function SCT:CHAT_MSG_SKILL(event, larg1)
  local skill, rank = string_match(larg1, skillmsg)
  if skill then
    self:Display_Event("SHOWSKILL", string_format("%s: %d", skill, rank))
  end
end

----------------------
--Player Entering World event
function SCT:PLAYER_ENTERING_WORLD(event)
  -- reset cooldowns
  local inInstance, instanceType = IsInInstance()
  if (inInstance and instanceType == "arena") then
    wipe(CD_cooldowns)
    wipe(CD_watching)
  end
end

----------------------
--Spell Update Cooldown event
function SCT:SPELL_UPDATE_COOLDOWN(event)
  -- reset cooldown details
  for i, getCooldownDetails in pairs(CD_cooldowns) do
    getCooldownDetails.resetCache()
  end
end

----------------------
--Unit Spellcast Succeeded event
function SCT:UNIT_SPELLCAST_SUCCEEDED(event, unitTarget, castGUID, spellId)
  -- watch cooldown
  if (unitTarget == "player") then
    CD_watching[spellId] = {GetTime(), "spell", spellId}
  end
end

----------------------
-- Displays Parsed info based on type
function SCT:ParseCombat(larg1, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destRaidFlags, ...)
  local etype = COMBAT_EVENTS[event]
  if not etype then return end

  --custom search first
  if (db["CUSTOMEVENTS"]) and (self:CustomCombatEventSearch(etype, event, sourceName, sourceFlags, destName, destFlags, destRaidFlags, ...) == true) then
    return
  end

  --check for reflect damage
  if self.ReflectTarget and self.ReflectSkill and event == "SPELL_DAMAGE" and sourceName == destName and CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_HOSTILE) then
    self:ParseReflect(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
    return
  end

  local toPlayer, fromPlayer, toPet, fromPet
  if (sourceName and not CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_NONE) ) then
    fromPlayer = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE)
    fromPet = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MY_PET)
  end
  if (destName and not CombatLog_Object_IsA(destFlags, COMBATLOG_OBJECT_NONE) ) then
    toPlayer = CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_MINE)
    toPet = CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_MY_PET)
  end

  --if it was only a custom event, then end
  if not fromPlayer and not toPlayer and not fromPet and not toPet then return end

  local healtot, healamt, parent
  local amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing
  local spellId, spellName, spellSchool, missType, powerType, extraAmount, environmentalType, extraSpellId, extraSpellName, extraSpellSchool, auraType, overHeal
  local overEnergize
  local text, texture, message, inout, color

  ------------damage------------------
  if etype == "DAMAGE" then
    if event == "SWING_DAMAGE" then
      amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
    elseif event == "ENVIRONMENTAL_DAMAGE" then
      environmentalType, amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
    else
      spellId, spellName, spellSchool, amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
      texture = GetSpellTexture(isWoWClassic and spellName or spellId)
    end
    text = tostring(self:ShortenValue(amount))

    if toPlayer then
      if (amount < db["DMGFILTER"]) then return end
      if (crushing and db["SHOWGLANCE"]) then text = self.LOCALS.Crushchar..text..self.LOCALS.Crushchar end
      if (glancing and db["SHOWGLANCE"]) then text = self.LOCALS.Glancechar..text..self.LOCALS.Glancechar end
      if (absorbed) then self:DisplayAbsorb(absorbed) end
      if (blocked) then self:DisplayBlock(blocked) end
      if event == "SWING_DAMAGE" or event == "RANGE_DAMAGE" then
        self:Display_Event("SHOWHIT", "-"..text, critical)
      else
        self:Display_Event("SHOWSPELL", "-"..text, critical, SCHOOL_STRINGS[school], resisted, nil, nil, nil, spellName, texture)
      end
    end
  ------------buff/debuff gain--------
  elseif etype == "BUFF" then
    spellId, spellName, spellSchool, auraType, amount = select(1, ...)
    texture = GetSpellTexture(isWoWClassic and spellName or spellId)
    if toPlayer then
      if amount and amount > 1 then
        self:Display_Event("SHOW"..auraType, string_format("[%s %d]", self:ShortenString(spellName), amount), nil, nil, nil, nil, nil, nil, nil, texture)
      else
        self:Display_Event("SHOW"..auraType, "["..self:ShortenString(spellName).."]", nil, nil, nil, nil, nil, nil, nil, texture)
      end
    end
  ------------buff/debuff lose--------
  elseif etype == "FADE" then
    spellId, spellName, spellSchool, auraType, amount = select(1, ...)
    texture = GetSpellTexture(isWoWClassic and spellName or spellId)
    if toPlayer then
      if db["SHOWFADE"] then
        self:Display_Event("SHOWFADE", "-["..self:ShortenString(spellName).."]", nil, nil, nil, nil, nil, nil, nil, texture)
      end
    end
  ------------heals-------------------
  elseif etype == "HEAL" then
    spellId, spellName, spellSchool, amount, overHeal, absorbed, critical = select(1, ...)
    text = amount
    texture = GetSpellTexture(isWoWClassic and spellName or spellId)

    healtot = tostring(self:ShortenValue(amount))
    --heal filter
    if (amount < db["HEALFILTER"]) then return end

    if toPlayer then
      --self heals
      if toPlayer and fromPlayer then
        if (db["SHOWOVERHEAL"]) and overHeal > 0 then healtot = string_format("%s {%s}", tostring(self:ShortenValue(amount-overHeal)), tostring(self:ShortenValue(overHeal))) end
        self:Display_Event("SHOWHEAL", "+"..healtot, critical, nil, nil, nil, nil, nil, self:ShortenString(spellName), texture)
      --incoming heals
      else
        self:Display_Event("SHOWHEAL", "+"..healtot, critical, nil, nil, sourceName, nil, nil, spellName, texture)
      end
    --outgoing heals
    elseif fromPlayer then
      if event == "SPELL_PERIODIC_HEAL" and (not db["SHOWHOTS"]) then return end
      if (db["SHOWOVERHEAL"]) and overHeal > 0 then healtot = string_format("%s {%s}", tostring(self:ShortenValue(amount-overHeal)), tostring(self:ShortenValue(overHeal))) end
      local healtext = destName..": +"..healtot
      if (db["NAMEPLATES"]) then parent = self:GetNameplate(destGUID) end
      if parent then healtext = "+"..healtot end
      self:Display_Event("SHOWSELFHEAL", healtext, critical, nil, nil, nil, nil, parent, spellName, texture)
    end
  ------------misses------------------
  elseif etype == "MISS" then
    if event == "SWING_MISSED" or event == "RANGE_MISSED" then
      missType = select(1, ...)
    else
      spellId, spellName, spellSchool, missType = select(1, ...)
      texture = GetSpellTexture(isWoWClassic and spellName or spellId)
    end
    text = _G[missType]

    if toPlayer then
      if (missType == "REFLECT") then
        self:Display_Event("SHOWABSORB", text.." ("..spellName..")", nil, nil, nil, nil, text.." ("..spellName..")", nil, spellName, texture)
        self:SetReflect(sourceName, spellName)
      elseif (missType == "ABSORB" or missType == "DEFLECT" or missType == "IMMUNE" or missType == "EVADE") then
        self:Display_Event("SHOWABSORB", text, nil, nil, nil, nil, text, nil, spellName, texture)
      elseif missType then
        self:Display_Event("SHOW"..missType, text, nil, nil, nil, nil, text, nil, spellName, texture)
      end
    end
  ------------leech and drains--------
  elseif etype == "DRAIN" then
    spellId, spellName, spellSchool, amount, powerType, extraAmount = select(1, ...)
    texture = GetSpellTexture(isWoWClassic and spellName or spellId)
    if toPlayer then
      self:Display_Event("SHOWPOWER", string_format("-%d %s", amount, string_nil(POWER_STRINGS[powerType])), nil, nil, nil, nil, nil, nil, spellName, texture)
    elseif fromPlayer and extraAmount then
      if (extraAmount < db["MANAFILTER"]) then return end
      self:Display_Event("SHOWPOWER", string_format("+%d %s", extraAmount, string_nil(POWER_STRINGS[powerType])), nil, nil, nil, nil, nil, nil, spellName, texture)
    elseif fromPlayer then
      return
      --for showing your drain damage
      --self:Display_Event("SHOWSPELL", string_format("%d %s", extraAmount, string_nil(POWER_STRINGS[powerType])), nil, nil, nil, nil, nil, nil, spellName, texture)
    end
  ------------power gains-------------
  elseif etype == "POWER" then
    spellId, spellName, spellSchool, amount, overEnergize, powerType = select(1, ...)
    texture = GetSpellTexture(isWoWClassic and spellName or spellId)
	if powerType == Enum.PowerType.ComboPoints then
	  if not db["SHOWCOMBOPOINTS"] or not toPlayer then return end
	  local sct_CP = UnitPower("player", Enum.PowerType.ComboPoints)
	  local sct_CP_Max = UnitPowerMax("player", Enum.PowerType.ComboPoints)
	  if (sct_CP ~= 0) then
	    local sct_CP_Message = string_format("%d %s", sct_CP, SCT.LOCALS.ComboPoint)
		if (sct_CP == sct_CP_Max) then
		  sct_CP_Message = sct_CP_Message.." "..SCT.LOCALS.CPMaxMessage
          self:Display_Event("SHOWCOMBOPOINTS", sct_CP_Message)
		end
	  end
	else
      if (amount < db["MANAFILTER"]) then return end
      if toPlayer then
        self:Display_Event("SHOWPOWER", string_format("+%d %s", amount, string_nil(POWER_STRINGS[powerType])), nil, nil, nil, nil, nil, nil, spellName, texture)
      end
	end
  ------------interrupts--------------
  elseif etype == "INTERRUPT" then
    spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool = select(1, ...)
    texture = GetSpellTexture(isWoWClassic and extraSpellName or extraSpellId)
    if toPlayer then
      self:Display_Event("SHOWINTERRUPT", self.LOCALS.Interrupted, nil, nil, nil, nil, nil, nil, extraSpellName, texture)
    end
  ------------dispels-----------------
  elseif etype == "DISPEL" then
    spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool, auraType = select(1, ...)
    texture = GetSpellTexture(isWoWClassic and extraSpellName or extraSpellId)
    if fromPlayer then
      self:Display_Event("SHOWDISPEL", self.LOCALS.Dispel, nil, nil, nil, nil, nil, nil, extraSpellName, texture)
    end
  ------------deaths------------------
  elseif etype == "DEATH" then
    if fromPlayer then
      self:Display_Event("SHOWKILLBLOW", self.LOCALS.KillingBlow)
    end
  ------------enchants----------------
  elseif etype == "ENCHANT_APPLIED" then
    spellName = select(1, ...)
    self:Display_Event("SHOWBUFF", "["..self:ShortenString(spellName).."]", nil, nil, nil, nil, nil, nil, nil, texture)
  elseif etype == "ENCHANT_REMOVED" then
    if db["SHOWFADE"] then
      spellName = select(1, ...)
      self:Display_Event("SHOWBUFF", "-["..self:ShortenString(spellName).."]", nil, nil, nil, nil, nil, nil, nil, texture)
    end
  ------------casts-------------------
  elseif etype == "CAST" then
    spellId, spellName, spellSchool = select(1, ...)
    if event == "SPELL_CAST_SUCCESS" then
      if (bit.band(sourceFlags, COMBATLOG_OBJECT_TYPE_PET) == COMBATLOG_OBJECT_TYPE_PET and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) == COMBATLOG_OBJECT_AFFILIATION_MINE) then
        local petActionIndex = self:GetPetActionIndexByName(spellName)
        if (petActionIndex and not select(7, GetPetActionInfo(petActionIndex))) then
          CD_watching[spellId] = {GetTime(), "pet", petActionIndex}
        elseif (not petActionIndex and spellId) then
          CD_watching[spellId] = {GetTime(), "spell", spellId, spellName}
        end
      end
	end
  ------------anything else-----------
  end
end

----------------------
--Handle Blizzard events
function SCT:COMBAT_TEXT_UPDATE(event, larg1)
  local larg2, larg3 = GetCurrentCombatTextEventInfo()
  --Normal Events
  if (larg1=="SPELL_ACTIVE") then
    --check for redundant display info
    if not self:CheckSkill(larg2.."!")  then
      local texture = GetSpellTexture(isWoWClassic and larg3 or larg2)
      self:Display_Event("SHOWEXECUTE", larg2.."!", nil, nil, nil, nil, nil, nil, nil, texture)
    end
  elseif (larg1=="FACTION") then
    local sign = "+"
    if (tonumber(larg3) < 0) then sign = "" end
    self:Display_Event("SHOWREP", string_format("%s%d %s (%s)", sign, larg3, REPUTATION, larg2))
  elseif (larg1=="HONOR_GAINED") then
    self:Display_Event("SHOWHONOR", string_format("+%d %s", larg2, HONOR))
  elseif (larg1=="EXTRA_ATTACKS") then
    if ( tonumber(larg2) > 1 ) then
      self:Display_Event("SHOWEXECUTE", string_format("%s (%d)", self.LOCALS.ExtraAttack, larg2))
    else
      self:Display_Event("SHOWEXECUTE", self.LOCALS.ExtraAttack)
    end
  end
end

----------------------
-- Use Action event
function SCT:EVENT_UseAction(slot)
  local actionType, itemId = GetActionInfo(slot)
  if (actionType == "item") then
    local texture = GetActionTexture(slot)
    CD_watching[itemId] = {GetTime(), "item", texture}
  end
end

----------------------
-- Use Inventory Item event
function SCT:EVENT_UseInventoryItem(slot)
  local itemId = GetInventoryItemID("player", slot);
  if (itemId) then
    local texture = GetInventoryItemTexture("player", slot)
    CD_watching[itemId] = {GetTime(), "item", texture}
  end
end

----------------------
-- Use Container Item event
function SCT:EVENT_UseContainerItem(bag, slot)
  local itemId = C_Container_GetContainerItemID(bag, slot)
  if (itemId) then
    local texture = GetItemIcon(itemId)
    CD_watching[itemId] = {GetTime(), "item", texture}
  end
end

----------------------
-- On Update event
function SCT:EVENT_OnUpdate(elapsed)
  FrameForOnUpdate_timeSinceLastUpdate = FrameForOnUpdate_timeSinceLastUpdate + elapsed;
  if (FrameForOnUpdate_timeSinceLastUpdate >= FrameForOnUpdate_updateInterval) then
	SCT:CheckIfCooldownIsFinished()
	FrameForOnUpdate_timeSinceLastUpdate = FrameForOnUpdate_timeSinceLastUpdate % FrameForOnUpdate_updateInterval
  end
end

-------------------------
--Check if Cooldown is finished
function SCT:CheckIfCooldownIsFinished()
  if not db["SHOWCOOLDOWNS"] then return end
  for spellOrItemId, value in pairs(CD_watching) do
    if (GetTime() >= value[1] + 0.5) then
      local getCooldownDetails
      if (value[2] == "spell") then
		getCooldownDetails = self:Memoize(function()
          local start, duration, enabled = GetSpellCooldown(isWoWClassic and value[4] or value[3])
		  return {
			name = (isWoWClassic and value[4] or GetSpellInfo(value[3])),
			texture = GetSpellTexture(isWoWClassic and value[4] or value[3]),
			start = start,
			duration = duration,
			enabled = enabled
		  }
		end)
      elseif (value[2] == "item") then
        getCooldownDetails = self:Memoize(function()
          local start, duration, enabled = GetItemCooldown(spellOrItemId)
          return {
            name = GetItemInfo(spellOrItemId),
            texture = value[3],
            start = start,
            duration = duration,
            enabled = enabled
          }
        end)
      elseif (value[2] == "pet") then
        getCooldownDetails = self:Memoize(function()
          local name, texture = GetPetActionInfo(value[3])
          local start, duration, enabled = GetPetActionCooldown(value[3])
          return {
            name = name,
            texture = texture,
            isPet = true,
            start = start,
            duration = duration,
            enabled = enabled
          }
        end)
      end

      local cooldown = getCooldownDetails()
      if ((CD_ignoredSpells[cooldown.name] ~= nil) == (db["CDBLACKWHITELIST"] == 1)) then
        CD_watching[spellOrItemId] = nil
      else
        if (cooldown.enabled ~= 0) then
          if (cooldown.duration and cooldown.duration > 2.0 and cooldown.duration >= db["CDFILTER"] and cooldown.texture) then
            CD_cooldowns[spellOrItemId] = getCooldownDetails
          end
        end
        if (not (cooldown.enabled == 0 and value[2] == "spell")) then
          CD_watching[spellOrItemId] = nil
        end
      end
    end
  end
  for spellOrItemId, getCooldownDetails in pairs(CD_cooldowns) do
    local cooldown = getCooldownDetails()
    local remaining = cooldown.duration - (GetTime() - cooldown.start)
    if (remaining <= 0) then
	  self:Display_Event("SHOWCOOLDOWNS", "[" .. cooldown.name .. "] " .. SCT.LOCALS.Ready, nil, nil, nil, nil, nil, nil, nil, cooldown.texture)
      CD_cooldowns[spellOrItemId] = nil
    end
  end
end

-------------------------
--Set last reflection
function SCT:ParseReflect(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
  local spellId, spellName, spellSchool, amount, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
  local texture = GetSpellTexture(isWoWClassic and spellName or spellId)
  --reflected events
  if (self.ReflectTarget == sourceName and sourceName == destName and self.ReflectSkill == spellName) then
    local parent
    if (db["NAMEPLATES"]) then parent = self:GetNameplate(destGUID) end
    if SCTD then
      SCTD:DisplayText("SCTD_SHOWSPELL", string_format("%s: %s", REFLECT, tostring(self:ShortenValue(amount))), critical, SCHOOL_STRINGS[school], resisted, destName, spellName, texture, destFlags)
    else
      self:Display_Event("SHOWABSORB", string_format("%s: %s (%s)", spellName, tostring(self:ShortenValue(amount)), REFLECT), critical,nil,nil,nil,nil,parent,nil,texture)
    end
    self:ClearReflect()
  end
end

-------------------------
--Set last reflection
function SCT:SetReflect(target, skill)
  self.ReflectTarget = target
  self.ReflectSkill = skill
  --clear reflection after 3 seconds.
  self:ScheduleTimer(self.ClearReflect, 3, self)
end

-------------------------
--Clear last reflection
function SCT:ClearReflect()
  self.ReflectTarget = nil
  self.ReflectSkill = nil
end

-------------------------
--Clean server name from players names
function SCT:CleanName(name, destFlags)
  if (CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_PLAYER)) then
    local rname = select(1, string_split("-", name))
    return rname
  end
  return name
end

----------------------
--Display for mainly combat events
--Mainly used for short messages
function SCT:Display_Event(option, msg1, crit, damagetype, resisted, target, msg2, parent, skill, icon)
  local rbgcolor, showcrit, showmsg, event
  --if option is on
  if (db[option]) then
    --get options
    rbgcolor = db[self.COLORS_TABLE][option]
    showcrit = db[self.CRITS_TABLE][option]
    showmsg = db[self.FRAMES_TABLE][option] or 1
    --if skill name
    if ((skill) and (db["SKILLNAME"])) then
      msg1 = msg1.." ("..self:ShortenString(skill)..")"
    end
    --if damage type
    if ((damagetype) and (db["SPELLTYPE"])) then
      msg1 = msg1.." <"..damagetype..">"
    end
    --if spell color
    if ((damagetype) and (db["SPELLCOLOR"])) then
      rbgcolor = db[self.SPELL_COLORS_TABLE][damagetype] or rbgcolor
    end
    --if resisted
    if ((resisted) and (db["SHOWRESIST"])) then
      msg1 = string_format("%s (%d %s)", msg1, resisted, ERR_FEIGN_DEATH_RESISTED)
    end
    --if target label
    if ((target) and (db["SHOWTARGETS"])) then
      msg1 = msg1.." ("..target..")"
    end
    --If they want to tag all self events
    if (db["SHOWSELF"]) then
      msg1 = SCT.LOCALS.SelfFlag..msg1..SCT.LOCALS.SelfFlag
    end
    --if messages
    if (showmsg == SCT.MSG) then
      --if 2nd msg
      if (msg2) then msg1 = msg2 end
      --display message
      self:DisplayMessage( msg1, rbgcolor, icon )
    else
      event = "event"
      --set event type
      if (option == "SHOWHIT" or option == "SHOWSPELL" or option == "SHOWHEAL" or option == "SHOWSELFHEAL") then
        event = "damage"
      end
      --see if crit override
      if (showcrit) then crit = 1 end
      --display
      self:DisplayText(msg1, rbgcolor, crit, event, showmsg, nil, parent, icon)
    end
  end
end

----------------------
--Displays a message at the top of the screen
function SCT:DisplayMessage(msg, color, icon)
    self:SetMsgFont(SCT_MSG_FRAME)
    if icon and db["ICON"] then msg = "|T"..icon..":"..(db[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGSIZE"]).."|t "..msg end
    SCT_MSG_FRAME:AddMessage(msg, color.r, color.g, color.b, 1)
end

----------------------
--Display text from a command line
function SCT:CmdDisplay(msg)
  local message = nil
  local colors = nil
  --If there are not parameters, display useage
  if strlen(msg) == 0 then
    self:Print(SCT.LOCALS.DISPLAY_USEAGE)
  --Get message anf colors if quotes used
  elseif strsub(msg,1,1) == "'" then
    local location = string_find(strsub(msg,2),"'")
    if location and (location>1) then
      message = strsub(msg,2,location)
      colors = strsub(msg,location+1)
    end
  --Get message anf colors if single word used
  else
    local idx = string_find(msg," ")
    if (idx) then
      message = strsub(msg,1,idx-1)
      colors = strsub(msg,idx+1)
    else
      message = msg
    end
  end
  --if they sent colors, grab them
  local firsti, lasti, red, green, blue = nil
  if (colors ~= nil) then
    firsti, lasti, red, green, blue = string_find (colors, "(%w+) (%w+) (%w+)")
  end
  local color = {r = 1.0, g = 1.0, b = 1.0}
  --if they sent 3 colors use them, else use default white
  if (red) and (green) and (blue) then
    color.r,color.g,color.b = (tonumber(red)/10),(tonumber(green)/10),(tonumber(blue)/10)
  end
  self:DisplayText(message, color, nil, "event", 1)
end

-------------------------
--Set the font of an object using msg vars
function SCT:SetMsgFont(object)
  --set font
  object:SetFont(media:Fetch("font", db[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGFONT"]),
                 db[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGSIZE"],
                 SHADOW_STRINGS[db[self.FRAMES_DATA_TABLE][SCT.MSG]["MSGFONTSHADOW"]])
end

-------------------------
--Set the font of the built in damage font
function SCT:SetDmgFont()
  if (SCT.db.profile["DMGFONT"]) then
    DAMAGE_TEXT_FONT = media:Fetch("font",SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME1]["FONT"])
  end
end

-------------------------
--Set the font of an object
function SCT:SetFontSize(object, font, textsize, fontshadow)
  object:SetFont(media:Fetch("font",font), textsize, SHADOW_STRINGS[fontshadow])
end

-------------------------
--Regsiter SCT with other mods
function SCT:RegisterOtherMods()
  local frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer or SettingsCanvas)
  frame:SetScript("OnShow", function() SCT:ShowMenu(true) end)
  frame.name = "SCT"
  frame:Hide()

  InterfaceOptions_AddCategory(frame)
end

-------------------------
--Get the default Config
function SCT:GetDefaultConfig()
  local default = {
    profile = {
      ["VERSION"] = SCT.version,
      ["ENABLED"] = true,
      ["SHOWHIT"] = 1,
      ["SHOWMISS"] = 1,
      ["SHOWDODGE"] = 1,
      ["SHOWPARRY"] = 1,
      ["SHOWBLOCK"] = 1,
      ["SHOWSPELL"] = 1,
      ["SHOWHEAL"] = 1,
      ["SHOWRESIST"] = 1,
      ["SHOWDEBUFF"] = 1,
      ["SHOWBUFF"] = 1,
      ["SHOWFADE"] = false,
      ["SHOWABSORB"] = 1,
      ["SHOWLOWHP"] = 1,
      ["SHOWLOWMANA"] = 1,
      ["SHOWPOWER"] = 1,
      ["SHOWCOMBAT"] = false,
      ["SHOWCOMBOPOINTS"] = false,
      ["SHOWHONOR"] = 1,
      ["SHOWEXECUTE"] = 1,
      ["SHOWREP"] = 1,
      ["SHOWSELFHEAL"] = 1,
      ["SHOWSKILL"] = 1,
      ["SHOWTARGETS"] = 1,
      ["SHOWSELF"] = false,
      ["SHOWGLANCE"] = 1,
      ["SHOWOVERHEAL"] = 1,
      ["SHOWHOTS"] = false,
      ["SHOWKILLBLOW"] = 1,
      ["SHOWINTERRUPT"] = 1,
      ["SHOWDISPEL"] = 1,
      ["SHOWRUNES"] = 1,
      ["SHOWCOOLDOWNS"] = false,
      ["STICKYCRIT"] = 1,
      ["FLASHCRIT"] = 1,
      ["SKILLNAME"] = false,
      ["SPELLTYPE"] = false,
      ["SPELLCOLOR"] = false,
      ["DMGFONT"] = false,
      ["SHOWALLPOWER"] = false,
      ["ANIMATIONSPEED"] = 15,
      ["MOVEMENT"] = 2,
      ["LOWHP"] = 40,
      ["LOWMANA"] = 40,
      ["HEALFILTER"] = 0,
      ["MANAFILTER"] = 0,
      ["DMGFILTER"] = 0,
      ["CDFILTER"] = 0,
	  ["CDBLACKWHITELIST"] = 1,
	  ["CDLIST"] = "",
      ["PLAYSOUND"] = 1,
      ["CUSTOMEVENTS"] = 1,
      ["NAMEPLATES"] = false,
      ["TRUNCATETYPE"] = 1,
      ["TRUNCATESIZE"] = 30,
      ["INITWOWFCTHEAL"] = true,
      ["ICON"] = 1,
      ["SHORTAMOUNT"] = 1,
      [SCT.FRAMES_DATA_TABLE] = {
        [SCT.FRAME1] = {
          ["FONT"] = "Friz Quadrata TT",
          ["FONTSHADOW"] = 2,
          ["ALPHA"] = 100,
          ["ANITYPE"] = 1,
          ["ANISIDETYPE"] = 1,
          ["XOFFSET"] = 0,
          ["YOFFSET"] = 0,
          ["DIRECTION"] = false,
          ["TEXTSIZE"] = 24,
          ["GAPDIST"] = 40,
          ["ALIGN"] = 2,
          ["ICONSIDE"] = 2,
        },
        [SCT.FRAME2] = {
          ["FONT"] = "Friz Quadrata TT",
          ["FONTSHADOW"] = 2,
          ["ALPHA"] = 100,
          ["ANITYPE"] = 1,
          ["ANISIDETYPE"] = 1,
          ["XOFFSET"] = 0,
          ["YOFFSET"] = -150,
          ["DIRECTION"] = true,
          ["TEXTSIZE"] = 24,
          ["GAPDIST"] = 40,
          ["ALIGN"] = 2,
          ["ICONSIDE"] = 2,
        },
        [SCT.MSG] = {
          ["MSGFADE"] = 1.5,
          ["MSGFONT"] = "Friz Quadrata TT",
          ["MSGFONTSHADOW"] = 2,
          ["MSGSIZE"] = 24,
          ["MSGYOFFSET"] = -280,
          ["MSGXOFFSET"] = 0,
        }
      },
      [SCT.COLORS_TABLE] = {
        ["SHOWHIT"] =  {r = 1.0, g = 0.0, b = 0.0},
        ["SHOWMISS"] =  {r = 0.0, g = 0.0, b = 1.0},
        ["SHOWDODGE"] =  {r = 0.0, g = 0.0, b = 1.0},
        ["SHOWPARRY"] =  {r = 0.0, g = 0.0, b = 1.0},
        ["SHOWBLOCK"] =  {r = 0.0, g = 0.0, b = 1.0},
        ["SHOWSPELL"] =  {r = 0.5, g = 0.0, b = 0.5},
        ["SHOWHEAL"] =  {r = 0.0, g = 1.0, b = 0.0},
        ["SHOWRESIST"] =  {r = 0.5, g = 0.0, b = 0.5},
        ["SHOWDEBUFF"] =  {r = 0.0, g = 0.5, b = 0.5},
        ["SHOWABSORB"] =  {r = 1.0, g = 1.0, b = 0.0},
        ["SHOWLOWHP"] =  {r = 1.0, g = 0.5, b = 0.5},
        ["SHOWLOWMANA"] =  {r = 0.5, g = 0.5, b = 1.0},
        ["SHOWPOWER"] =  {r = 1.0, g = 1.0, b = 0.0},
        ["SHOWCOMBAT"] =  {r = 1.0, g = 1.0, b = 1.0},
        ["SHOWCOMBOPOINTS"] =  {r = 1.0, g = 0.5, b = 0.0},
        ["SHOWHONOR"] =  {r = 0.5, g = 0.5, b = 0.7},
        ["SHOWBUFF"] =  {r = 0.7, g = 0.7, b = 0.0},
        ["SHOWFADE"] =  {r = 0.7, g = 0.7, b = 0.0},
        ["SHOWEXECUTE"] =  {r = 0.7, g = 0.7, b = 0.7},
        ["SHOWREP"] =  {r = 0.5, g = 0.5, b = 1},
        ["SHOWSELFHEAL"] = {r = 0, g = 0.7, b = 0},
        ["SHOWSKILL"] = {r = 0, g = 0, b = 0.7},
        ["SHOWKILLBLOW"] = {r = 0.7, g = 0.1, b = 0.1},
        ["SHOWINTERRUPT"] = {r = 0.3, g = 0.3, b = 0.5},
        ["SHOWDISPEL"] = {r = 0.8, g = 0.8, b = 1},
        ["SHOWRUNES"] = {r = 0, g = 1, b = 1}, -- not used
        ["SHOWCOOLDOWNS"] = {r = 0.4, g = 0.7, b = 1},
      },
      [SCT.SPELL_COLORS_TABLE] = {
        [SPELL_SCHOOL0_CAP] = {r=1,g=1,b=0},
        [SPELL_SCHOOL1_CAP] = {r=1,g=0.9,b=0.5},
        [SPELL_SCHOOL2_CAP] = {r=1,g=0.5,b=0},
        [SPELL_SCHOOL3_CAP] = {r=0.3,g=1,b=0.3},
        [SPELL_SCHOOL4_CAP] = {r=0.5,g=1,b=1},
        [SPELL_SCHOOL5_CAP] = {r=0.5,g=0.5,b=1},
        [SPELL_SCHOOL6_CAP] = {r=1,g=0.5,b=1},
      },
      [SCT.CRITS_TABLE] = {
        ["SHOWEXECUTE"] = 1,
        ["SHOWLOWHP"] = 1,
        ["SHOWLOWMANA"] = 1,
        ["SHOWKILLBLOW"] = 1,
        ["SHOWINTERRUPT"] = 1,
        ["SHOWRUNES"] = 1,
        ["SHOWCOOLDOWNS"] = 1,
      },
      [SCT.FRAMES_TABLE] = {
        ["SHOWHIT"] = SCT.FRAME1,
        ["SHOWMISS"] = SCT.FRAME1,
        ["SHOWDODGE"] = SCT.FRAME1,
        ["SHOWPARRY"] = SCT.FRAME1,
        ["SHOWBLOCK"] = SCT.FRAME1,
        ["SHOWSPELL"] = SCT.FRAME1,
        ["SHOWHEAL"] = SCT.FRAME2,
        ["SHOWRESIST"] = SCT.FRAME1,
        ["SHOWDEBUFF"] = SCT.FRAME1,
        ["SHOWABSORB"] = SCT.FRAME1,
        ["SHOWLOWHP"] = SCT.FRAME1,
        ["SHOWLOWMANA"] = SCT.FRAME1,
        ["SHOWPOWER"] = SCT.FRAME2,
        ["SHOWCOMBAT"] = SCT.FRAME2,
        ["SHOWCOMBOPOINTS"] = SCT.FRAME1,
        ["SHOWHONOR"] = SCT.MSG,
        ["SHOWBUFF"] = SCT.MSG,
        ["SHOWFADE"] = SCT.FRAME1,
        ["SHOWEXECUTE"] = SCT.FRAME1,
        ["SHOWREP"] = SCT.MSG,
        ["SHOWSELFHEAL"] = SCT.FRAME2,
        ["SHOWSKILL"] = SCT.FRAME2,
        ["SHOWKILLBLOW"] = SCT.FRAME1,
        ["SHOWINTERRUPT"] = SCT.FRAME1,
        ["SHOWDISPEL"] = SCT.FRAME2,
        ["SHOWRUNES"] = SCT.FRAME1,
        ["SHOWCOOLDOWNS"] = SCT.FRAME2,
      }
    }
  }
  return default
end

-------------------------
--Register SCT with all events
function SCT:RegisterSelfEvents()

  --Register Main Events
  self:RegisterEvent("CHAT_MSG_SKILL")
  self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", function()
    self:ParseCombat("COMBAT_LOG_EVENT_UNFILTERED", CombatLogGetCurrentEventInfo())
  end)
  self:RegisterEvent("COMBAT_TEXT_UPDATE")
  self:RegisterEvent("PLAYER_ENTERING_WORLD")
  self:RegisterEvent("PLAYER_REGEN_ENABLED")
  self:RegisterEvent("PLAYER_REGEN_DISABLED")
  self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
  self:RegisterEvent("UNIT_DISPLAYPOWER")
  self:RegisterEvent("UNIT_HEALTH")
  self:RegisterEvent("UNIT_POWER_UPDATE")
  self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
  pcall(self.RegisterEvent, self, "RUNE_POWER_UPDATE") -- catch error because event didn't exist in tbc classic

  hooksecurefunc("UseAction", function(slot)
    self:EVENT_UseAction(slot)
  end)
  hooksecurefunc("UseInventoryItem", function(slot)
    self:EVENT_UseInventoryItem(slot)
  end)
  if C_Container and C_Container.UseContainerItem then -- since df 10.0.2
    hooksecurefunc(C_Container, "UseContainerItem", function(bag, slot)
      self:EVENT_UseContainerItem(bag, slot)
    end)
  else -- before df 10.0.2
    hooksecurefunc("UseContainerItem", function(bag, slot)
      self:EVENT_UseContainerItem(bag, slot)
    end)
  end

  FrameForOnUpdate:SetScript("OnUpdate", self.EVENT_OnUpdate)
  
  --Create event to load up correct font
  --when another mod loads. Incase they try to change
  --the font (super inspect, etc...)
  self:RegisterEvent("ADDON_LOADED", SCT.SetDmgFont)
end

------------------------------
---Shorten a spell/buff
function SCT:ShortenString(strString)
  if strlen(strString) > db["TRUNCATESIZE"] then
    if (db["TRUNCATETYPE"] == 1) then
      return strsub(strString, 1, db["TRUNCATESIZE"]).."..."
    else
      return gsub(gsub(gsub(strString," of ","O"),"%s",""), "(%u)%l*", "%1")
    end
  else
    return strString
  end
end

------------------------------
---Shorten an amount
function SCT:ShortenValue(value)
  if db["SHORTAMOUNT"] then
    value = shortenValue(value)
  end
  return value
end

------------------------
--Disable Healing Flags based on Options
function SCT:DisableHealingFlags()
  --disable WoW Healing Flags on first load
  if (SCT.db.profile["INITWOWFCTHEAL"]) then
    SetCVar("floatingCombatTextCombatHealing", 0)
    SCT.db.profile["INITWOWFCTHEAL"] = false
  end
end

------------------------
--Get key from value
function SCT:GetKeyFromValue(t, str)
  for k, v in pairs(t) do
    if (v == str) then
	  return k
	end
  end
  return nil
end

------------------------
--Initialize table with value
function SCT:InitializeTable(tab, value, firstIndex, lastIndex)
    firstIndex = firstIndex or 1
    lastIndex = lastIndex or firstIndex
    for i = firstIndex, lastIndex do
        tab[i] = value
    end
    return tab
end

------------------------
--Memoization function
function SCT:Memoize(f)
  local cache = nil
  local memoized = {}
  local function get()
    if (cache == nil) then
      cache = f()
    end
    return cache
  end
  memoized.resetCache = function()
    cache = nil
  end
  setmetatable(memoized, {__call = get})
  return memoized
end

------------------------
--Get pet action index by name
function SCT:GetPetActionIndexByName(name)
  for i=1, NUM_PET_ACTION_SLOTS, 1 do
    if (GetPetActionInfo(i) == name) then
      return i
    end
  end
  return nil
end
