local SCT = SCT

--LUA calls
local pairs = pairs
local ipairs = ipairs
local strfind = strfind
local string_gsub = string.gsub
local string_gmatch = string.gmatch
local tremove = tremove
local table_sort = table.sort
local strupper = strupper
local tinsert = function(t,v)
  t[#t+1] = v
end

--API
local GetSpellInfo = GetSpellInfo
local UnitDebuff = function(unitToken, index, filter)
	-- since df 10.2.5
	if (C_UnitAuras) and (C_UnitAuras.GetDebuffDataByIndex) then
		local auraData = C_UnitAuras.GetDebuffDataByIndex(unitToken, index, filter);
		
		if (not auraData) then
			return nil;
		end

		return AuraUtil.UnpackAuraData(auraData);
	end
	
	-- before 10.2.5
	return UnitDebuff(unitToken, index, filter);
end


--Combat Log
local CombatLog_Object_IsA = CombatLog_Object_IsA
local COMBATLOG_OBJECT_NONE = COMBATLOG_OBJECT_NONE
local COMBATLOG_FILTER_HOSTILE = bit.bor(
						COMBATLOG_FILTER_HOSTILE_PLAYERS,
						COMBATLOG_FILTER_HOSTILE_UNITS,
						COMBATLOG_FILTER_NEUTRAL_UNITS)
local COMBATLOG_FILTER_ANY = bit.bor(
						COMBATLOG_OBJECT_AFFILIATION_MASK,
						COMBATLOG_OBJECT_REACTION_MASK,
						COMBATLOG_OBJECT_CONTROL_MASK,
						COMBATLOG_OBJECT_TYPE_MASK)

local CUSTOM_EVENTS = {
  "BUFF",
  "FADE",
  "MISS",
  "HEAL",
  "DAMAGE",
  "DEATH",
  "INTERRUPT",
  "POWER",
  "SUMMON",
  "DISPEL",
  "CAST",
}

local FLAG_LOOKUP = {
  ["SELF"] = COMBATLOG_FILTER_MINE,
  ["TARGET"] = COMBATLOG_OBJECT_TARGET,
  ["FOCUS"] = COMBATLOG_OBJECT_FOCUS,
  ["PET"] = COMBATLOG_FILTER_MY_PET,
  ["ENEMY"] = COMBATLOG_FILTER_HOSTILE,
  ["FRIEND"] = COMBATLOG_FILTER_FRIENDLY_UNITS,
  ["ANY"] = COMBATLOG_FILTER_ANY,
}

------------------------------
---Sort a table by its keys.
---stolen from http://www.lua.org/pil/19.3.html
function SCT:PairsByKeys(t, f)
  local a = {}
  for n in pairs(t) do tinsert(a, n) end
  table_sort(a, f)
  local i = 0      -- iterator variable
  local iter = function ()   -- iterator function
    i = i + 1
    if a[i] == nil then return nil
    else return a[i], t[a[i]]
    end
  end
  return iter
end

-------------------------
--Cache Custom Events
function SCT:CacheCustomEvents()
  local classfound, key, key2, class, value

  if self.CustomCombatEvents then
    for k in pairs(self.CustomCombatEvents) do
      self.CustomCombatEvents[k] = nil
    end
    for k,v in pairs(CUSTOM_EVENTS) do
      self.CustomCombatEvents[v] = {}
    end
  else
    self.CustomCombatEvents = {}
    for k,v in pairs(CUSTOM_EVENTS) do
      self.CustomCombatEvents[v] = {}
    end
  end

  for key, value in self:PairsByKeys(self.EventConfig) do
    --default class found to true
    classfound = true
    --check if they want to see it for this class
    if (value.class) then
      --if want to filter by class, default to false
      classfound = false
      for key2, class in pairs(value.class) do
        if (strlower(UnitClass("player")) == strlower(class)) then
          classfound = true
          break
        end
      end
    end
    if (classfound) then
      --seperate events based on type
      if self.CustomCombatEvents[value.type] then
        --set override
        if value.override ~= false then
          value.override = true
        end
        tinsert(self.CustomCombatEvents[value.type], value)
      end
    end
  end
end

----------------------
--Find a custom combat event
function SCT:CustomCombatEventSearch(etype, event, sourceName, sourceFlags, destName, destFlags, destRaidFlags, ...)
  --locals
  local texture, spellId, spellName, spellSchool, missType, auraType, powerType, extraSpellId, extraSpellName, extraSpellSchool
  local amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing

  --end if no special events for it
  if not self.CustomCombatEvents[etype] then return false end

  ---------damage-------------
  if etype == "DAMAGE" then
    if event == "SWING_DAMAGE" then
      amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
      spellName = ACTION_SWING
    else
      spellId, spellName, spellSchool, amount, overDamage, school, resisted, blocked, absorbed, critical, glancing, crushing = select(1, ...)
      texture = select(3, GetSpellInfo(spellId))
    end
    return self:DamageCustomEvent(self.CustomCombatEvents[etype], spellName, amount, resisted, blocked, absorbed, critical, glancing, crushing, sourceName, sourceFlags, destName, destFlags, texture)
  ---------buffs------------
  elseif etype == "BUFF" or etype == "FADE" then
    spellId, spellName, spellSchool, auraType, amount = select(1, ...)
    texture = select(3, GetSpellInfo(spellId))
    return self:AuraCustomEvent(self.CustomCombatEvents[etype], spellName, amount, auraType, sourceName, sourceFlags, destName, destFlags, texture)
  ---------heals-------------
  elseif etype == "HEAL" then
    spellId, spellName, spellSchool, amount,	critical = select(1, ...)
    texture = select(3, GetSpellInfo(spellId))
    return self:HealCustomEvent(self.CustomCombatEvents[etype], spellName, critical, amount, sourceName, sourceFlags, destName, destFlags, texture)
  ---------cast-------------
  elseif etype == "CAST" then
    spellId, spellName, spellSchool = select(1, ...)
    texture = select(3, GetSpellInfo(spellId))
    return self:GenericCustomEvent(self.CustomCombatEvents[etype], spellName, sourceName, sourceFlags, destName, destFlags, texture)
  ---------miss-------------
  elseif etype == "MISS" then
    if event == "SWING_MISSED" then
      missType = select(1, ...)
      spellName = ACTION_SWING
    else
      spellId, spellName, spellSchool, missType = select(1, ...)
      texture = select(3, GetSpellInfo(spellId))
    end
    return self:MissCustomEvent(self.CustomCombatEvents[etype], spellName, missType, sourceName, sourceFlags, destName, destFlags, texture)
  ---------power-------------
  elseif etype == "POWER" then
    spellId, spellName, spellSchool, amount, powerType = select(1, ...)
    texture = select(3, GetSpellInfo(spellId))
    return self:PowerCustomEvent(self.CustomCombatEvents[etype], spellName, powerType, amount, sourceName, sourceFlags, destName, destFlags, texture)
  ---------interrupt-------------
  elseif etype == "INTERRUPT" then
    spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool = select(1, ...)
    texture = select(3, GetSpellInfo(extraSpellId))
    return self:GenericCustomEvent(self.CustomCombatEvents[etype], extraSpellName, sourceName, sourceFlags, destName, destFlags, texture)
  ---------summon-------------
  elseif etype == "SUMMON" then
    spellId, spellName, spellSchool = select(1, ...)
    texture = select(3, GetSpellInfo(spellId))
    return self:GenericCustomEvent(self.CustomCombatEvents[etype], spellName, sourceName, sourceFlags, destName, destFlags, texture)
  ---------dispel-------------
  elseif etype == "DISPEL" then
    spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool, auraType = select(1, ...)
    texture = select(3, GetSpellInfo(extraSpellId))
    return self:GenericCustomEvent(self.CustomCombatEvents[etype], extraSpellName, sourceName, sourceFlags, destName, destFlags, texture)
  ---------death-------------
  elseif etype == "DEATH" then
    return self:DeathCustomEvent(self.CustomCombatEvents[etype], sourceName, sourceFlags, destName, destFlags)
  end
end

----------------------
--Find a aura custom event
function SCT:AuraCustomEvent(tab, spellName, count, auraType, sourceName, sourceFlags, destName, destFlags, icon)
  --loop through each buff
  for key, value in ipairs(tab) do
    --see if its to what they care about
    if CombatLog_Object_IsA(destFlags, FLAG_LOOKUP[value.target]) and
    --if they care about skill and skill is found
    (not value.search or (spellName and strfind(spellName, value.search))) and
    --if they want self only debuffs then
    (not value.source or (value.source == "SELF" and auraType == "DEBUFF" and self:CheckSelfDebuff(spellName, "target"))) and
    --if they care about count
    (not value.buffcount or value.buffcount == count) then
      --then send custom event
      self:FormatCustomEvent(value, icon, spellName, sourceName, destName, count)
      return value.override
    end
  end
  return false
end

----------------------
--Find a aura custom event
function SCT:MissCustomEvent(tab, spellName, missType, sourceName, sourceFlags, destName, destFlags, icon)
  --loop through each miss
  for key, value in ipairs(tab) do
    found = true
    --see if its to what they care about
    if CombatLog_Object_IsA(destFlags, FLAG_LOOKUP[value.target]) and
    --if they care about source
    (not value.source or CombatLog_Object_IsA(sourceFlags, FLAG_LOOKUP[value.source])) and
    --if they care about skill and skill is found
    (not value.search or (spellName and strfind(spellName, value.search))) and
    --if they care about miss type and miss type is found
    (not value.misstype or strupper(value.misstype) == missType) then
      -- then send custom event
      self:FormatCustomEvent(value, icon, spellName, sourceName, destName, missType)
      return value.override
    end
  end
  return false
end

----------------------
--Find a heal custom event
function SCT:DamageCustomEvent(tab, spellName, amount, resisted, blocked, absorbed, critical, glancing, crushing, sourceName, sourceFlags, destName, destFlags, icon)
  --loop through each event
  for key, value in ipairs(tab) do
    --see if its to what they care about
    if CombatLog_Object_IsA(destFlags, FLAG_LOOKUP[value.target]) and
    --if they care about source
    (not value.source or CombatLog_Object_IsA(sourceFlags, FLAG_LOOKUP[value.source])) and
    --if they care about skill and skill is found
    (not value.search or (spellName and strfind(spellName, value.search))) and
    --if they care about crits and crit is found
    (not value.critical or critical) and
    --if they care about resists and resist is found
    (not value.resisted or resisted) and
    --if they care about blocks and block is found
    (not value.blocked or blocked) and
    --if they care about absorbed and absorb is found
    (not value.absorbed or absorbed) and
    --if they care about glacing and glancing is found
    (not value.glancing or glancing) and
    --if they care about crushing and crushing is found
    (not value.crushing or crushing) then
      --then send custom event
      self:FormatCustomEvent(value, icon, spellName, sourceName, destName, amount)
      return value.override
    end
  end
  return false
end

----------------------
--Find a heal custom event
function SCT:HealCustomEvent(tab, spellName, critical, amount, sourceName, sourceFlags, destName, destFlags, icon)
  --loop through each event
  for key, value in ipairs(tab) do
    --see if its to what they care about
    if CombatLog_Object_IsA(destFlags, FLAG_LOOKUP[value.target]) and
    --if they care about source
    (not value.source or CombatLog_Object_IsA(sourceFlags, FLAG_LOOKUP[value.source])) and
    --if they care about skill and skill is found
    (not value.search or (spellName and strfind(spellName, value.search))) and
    --if they care about crits and crit is found
    (not value.critical or critical) then
      --then send custom event
      self:FormatCustomEvent(value, icon, spellName, sourceName, destName, amount)
      return value.override
    end
  end
  return false
end

----------------------
--Find a Power custom event
function SCT:PowerCustomEvent(tab, spellName, powerType, amount, sourceName, sourceFlags, destName, destFlags, icon)
  --loop through each event
  for key, value in ipairs(tab) do
    --see if its to what they care about
    if CombatLog_Object_IsA(destFlags, FLAG_LOOKUP[value.target]) and
    --if they care about source
    (not value.source or CombatLog_Object_IsA(sourceFlags, FLAG_LOOKUP[value.source])) and
    --if they care about skill and skill is found
    (not value.search or (spellName and strfind(spellName, value.search))) and
    --if they care about power and power matches
    (not value.power or value.power == powerType) then
      --then send custom event
      self:FormatCustomEvent(value, icon, spellName, sourceName, destName, amount, powerType)
      return value.override
    end
  end
  return false
end

----------------------
--Find a Generic custom event
function SCT:GenericCustomEvent(tab, spellName, sourceName, sourceFlags, destName, destFlags, icon)
  --loop through each event
  for key, value in ipairs(tab) do
    --see if its to what they care about
    if (CombatLog_Object_IsA(destFlags, COMBATLOG_OBJECT_NONE) or CombatLog_Object_IsA(destFlags, FLAG_LOOKUP[value.target])) and
    --if they care about source
    (not value.source or CombatLog_Object_IsA(sourceFlags, COMBATLOG_OBJECT_NONE) or CombatLog_Object_IsA(sourceFlags, FLAG_LOOKUP[value.source])) and
    --if they care about skill and skill is not found
    (not value.search or (spellName and strfind(spellName, value.search))) then
      --then send custom event
      self:FormatCustomEvent(value, icon, spellName, sourceName, destName)
      return value.override
    end
  end
  return false
end


----------------------
--Find a Death custom event
function SCT:DeathCustomEvent(tab, sourceName, sourceFlags, destName, destFlags)
  --loop through each event
  for key, value in ipairs(tab) do
    --see if its to what they care about
    if destFlags and CombatLog_Object_IsA(destFlags, FLAG_LOOKUP[value.target]) and
    --if they care about source
    (not value.source or (sourceFlags and CombatLog_Object_IsA(sourceFlags, FLAG_LOOKUP[value.source]))) then
      --then send custom event
      self:FormatCustomEvent(value, nil, nil, sourceName, destName)
      return value.override
    end
  end
  return false
end


----------------------
--See if the debuff is ours
function SCT:CheckSelfDebuff(spellName, unit)
  local i = 1
  while true do
    local name, rank, icon, count, dispelType, duration, timeLeft, caster = UnitDebuff(unit, i)
    if not name then break end
    if name == spellName and caster == "player" then
      return true
    end
    i = i + 1
  end
  return false
end

----------------------
--Format and print a custom event
local currentcolor = {r = 1.0, g = 1.0, b = 1.0}
function SCT:FormatCustomEvent(value, icon, carg1, carg2, carg3, carg4, carg5)
  local strTempMessage, replace, count = value.display, false, 0
  --if there are capture args
  if carg1 then
     strTempMessage, count = string_gsub(strTempMessage, "*1", carg1)
     if count > 0 then replace = true end
  end
  if carg2 then
     strTempMessage, count = string_gsub(strTempMessage, "*2", carg2)
     if count > 0 then replace = true end
  end
  if carg3 then
     strTempMessage, count = string_gsub(strTempMessage, "*3", carg3)
     if count > 0 then replace = true end
  end
  if carg4 then
     strTempMessage, count = string_gsub(strTempMessage, "*4", carg4)
     if count > 0 then replace = true end
  end
  if carg5 then
     strTempMessage, count = string_gsub(strTempMessage, "*5", carg5)
     if count > 0 then replace = true end
  end
  --check for dupes, filters out duplicate skills
  if not replace and self:CheckSkill(strTempMessage) then return end
  --get color
  currentcolor.r,currentcolor.g,currentcolor.b = 1.0,1.0,1.0
  if (value.r and value.g and value.b) then
    currentcolor.r,currentcolor.g,currentcolor.b = value.r,value.g,value.b
  end
  --show icon
  if not value.icon then icon = nil end
  --play sound
  if value.sound then PlaySound(value.sound) end
  --play soundwave
  if value.soundwave then PlaySoundFile(value.soundwave) end
  --display
  self:DisplayCustomEvent(strTempMessage, currentcolor, value.iscrit, value.frame or 1, value.anitype, icon)
end

----------------------
--Display the Text based on message flag for custom events
function SCT:DisplayCustomEvent(msg1, color, iscrit, frame, anitype, icon)
  if (frame == SCT.MSG) then
    self:DisplayMessage( msg1, color, icon )
  else
    self:DisplayText(msg1 , color, iscrit, "event", frame or 1, anitype, nil, icon)
  end
end
