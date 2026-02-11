Merfin = Merfin or {}

-- Localizing functions
local GetTime, GetInstanceInfo, GetSpellInfo = GetTime, GetInstanceInfo, Merfin.GetSpellInfo
local select, wipe, bband, pairs = select, wipe, bit.band, pairs
local stformat = string.format
local UnitTokenFromGUID, UnitDetailedThreatSituation = UnitTokenFromGUID, UnitDetailedThreatSituation
local UnitHealth, UnitHealthMax, UnitExists = UnitHealth, UnitHealthMax, UnitExists
local GetNameplates = C_NamePlate.GetNamePlates

Merfin.RAID = {
  CORE = {},
  -- Defaults
  settings = {
    cooldown = {
      visibility = true,
      hold = true,
      alpha = true,
      customNames = true,
    },
  },
}

local settings = Merfin.RAID.settings
local CORE = Merfin.RAID.CORE

local difficulty

CORE.mechanics = {
  berserk = { 26662 },
}

local mainEvent = "WA_MERFIN_RAID"

local GetClassColorName = function(unit)
  if unit and UnitExists(unit) then
    local name = UnitName(unit)
    local _, class = UnitClass(unit)
    if not class then
      return name
    else
      local classData = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
      local coloredName = ("|c%s%s|r"):format(classData.colorStr, name)
      return coloredName
    end
  else
    return ""
  end
end

local BuildValuesString = function(names)
  local str = ""
  for i, name in pairs(names) do
    local formattedName = GetClassColorName(name) or name
    if str == "" then
      str = formattedName
    else
      str = stformat("%s, %s", str, formattedName)
    end
  end
  return str
end

-- Function to assist iterating group members whether in a party or raid.
local WA_IterateGroupMembers = function(reversed, forceParty)
  local unit = (not forceParty and IsInRaid()) and "raid" or "party"
  local numGroupMembers = unit == "party" and GetNumSubgroupMembers() or GetNumGroupMembers()
  local i = reversed and numGroupMembers or (unit == "party" and 0 or 1)
  return function()
    local ret
    if i == 0 and unit == "party" then
      ret = "player"
    elseif i <= numGroupMembers and i > 0 then
      ret = unit .. i
    end
    i = i + (reversed and -1 or 1)
    return ret
  end
end

CORE.GetSettings = function(t1, t2)
  -- todo: replace cooldowns with cooldown in all boss cds
  --local t1 = t1 == 'cooldowns' and 'cooldown' or
  return settings[t1][t2]
end

CORE.SendMRTNote = function(customEvent)
  if GMRT and GMRT.F and GMRT.F.Note_Timer then
    GMRT.F.Note_Timer(customEvent)
  end
end

CORE.PlayerGUID = UnitGUID("player")

CORE.IsNPC = function(destFlags)
  return bband(destFlags, COMBATLOG_OBJECT_TYPE_NPC) ~= 0
end

CORE.IsPlayer = function(args)
  if args.destGUID and (args.destGUID == CORE.PlayerGUID) then
    return true
  end
end

CORE.IsTanking = function(sourceUnitId, destUnitId, destGUID)
  if not destUnitId and destGUID and UnitTokenFromGUID then
    destUnitId = UnitTokenFromGUID(destGUID)
  end
  if destUnitId then
    local isTanking = UnitDetailedThreatSituation(sourceUnitId, destUnitId)
    return isTanking
  end
end

CORE.IsDestTypePlayer = function(flags)
  if flags and COMBATLOG_OBJECT_TYPE_PLAYER then
    return bband(flags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
  end
end

CORE.GetGuidCreatureId = function(GUID)
  local guidType, _, playerdbID, _, _, cid, _ = strsplit("-", GUID or "")
  if guidType and (guidType == "Creature" or guidType == "Vehicle" or guidType == "Pet") then
    return tonumber(cid)
  elseif type and (guidType == "Player" or guidType == "Item") then
    return tonumber(playerdbID)
  end
  return 0
end

CORE.CetUnitCreatureId = function(unitId)
  if not UnitExists(unitId) then
    return 0
  end
  local unitGUID = UnitGUID(unitId)
  return CORE.GetGuidCreatureId(unitGUID)
end

local UnitIDPool = { "target", "focus", "mouseover", "boss1", "boss2", "boss3", "boss4", "boss5" }
CORE.GetTarget = function(byGUID, byNpcId, context)
  local func = byGUID and UnitGUID or CORE.CetUnitCreatureId
  for _, unitID in ipairs(UnitIDPool) do
    if UnitExists(unitID) and func(unitID) == context then
      local targetUnitID = stformat("%starget", unitID)
      return targetUnitID
    end
  end
  local nameplates = GetNameplates()
  for _, plateData in pairs(nameplates) do
    local namePlateContext = byGUID and plateData.namePlateUnitGUID or plateData.namePlateNpcId
    if namePlateContext == context then
      local nameplateId = plateData.UnitFrame.displayedUnit
      local targetUnitID = stformat("%starget", nameplateId)
      return targetUnitID
    end
  end
  for unitID in WA_IterateGroupMembers() do
    local targetUnitID = stformat("%starget", unitID)
    if UnitExists(targetUnitID) and func(targetUnitID) == context then
      return stformat("%starget", targetUnitID)
    end
  end
end

CORE.GetNpcIdTarget = function(cid)
  return CORE.GetTarget(false, true, cid)
end
CORE.GetGuidTarget = function(guid)
  return CORE.GetTarget(true, false, guid)
end

CORE.GetRaidUnitByName = function(unitName)
  for i = 1, 40 do
    local unitId = "raid" .. i
    if not UnitExists(unitId) then
      return
    end
    local uName = UnitName(unitId)
    if unitName == uName then
      return unitId
    end
  end
end

CORE.TargettedCast = function(sourceGUID, e)
  local targetUnit = CORE.GetGuidTarget(sourceGUID)
  local unitName = targetUnit and UnitName(targetUnit)
  if unitName then
    local raidId = CORE.GetRaidUnitByName(unitName)
    WeakAuras.ScanEvents(e, raidId, unitName)
  end
end

CORE.GetUnitHealthPercent = function(unitId)
  if not UnitExists(unitId) then
    return
  end
  local percent = 100 * UnitHealth(unitId) / UnitHealthMax(unitId)
  return percent
end

CORE.GetSpellCache = function(ENTRY, spellId)
  if not spellId then
    return
  end
  if not ENTRY.cache[spellId] then
    ENTRY.cache[spellId] = {}
    local name, _, icon = GetSpellInfo(spellId)
    ENTRY.cache[spellId].spellName = name
    ENTRY.cache[spellId].icon = icon
  end
  return ENTRY.cache[spellId].spellName, ENTRY.cache[spellId].icon
end

CORE.IsSpellId = function(spellId, ...)
  for i = 1, select("#", ...) do
    if spellId == select(i, ...) then
      return true
    end
  end
end

CORE.IsDifficulty = function(...)
  for i = 1, select("#", ...) do
    if CORE.difficulty == select(i, ...) then
      return true
    end
  end
end

CORE.IsHeroic = function()
  return difficulty == 2
    or difficulty == 5
    or difficulty == 6
    or difficulty == 15
    or difficulty == 24
    or difficulty == 174
end

CORE.IsNormal = function()
  return difficulty == 1
    or difficulty == 3
    or difficulty == 4
    or difficulty == 14
    or difficulty == 173
    or difficulty == 205
end

CORE.ResetFields = function(ENTRY)
  local tables = { "counter", "schedulers", "antispams", "cache", "CASTS", "ctx" }
  for _, t in pairs(tables) do
    if ENTRY[t] then
      wipe(ENTRY[t])
    else
      ENTRY[t] = {}
    end
  end
end

CORE.CancelScheduler = function(ENTRY, mechanic)
  local timer = ENTRY.schedulers[mechanic]
  if timer then
    WeakAuras.timer:CancelTimer(timer)
    ENTRY.schedulers[mechanic] = nil
  end
end

CORE.WipeSchedulers = function(ENTRY)
  if ENTRY.schedulers then
    for mechanic, timer in pairs(ENTRY.schedulers) do
      CORE.CancelScheduler(ENTRY, mechanic)
    end
  end
end

CORE.Schedule = function(ENTRY, mechanic, after, func, ...)
  if ENTRY.schedulers[mechanic] then
    WeakAuras.timer:CancelTimer(ENTRY.schedulers[mechanic])
  end
  ENTRY.schedulers[mechanic] = WeakAuras.timer:ScheduleTimer(func, after, ...)
end

CORE.WipeCounter = function(type, mechanic)
  ENTRY.counter[type] = ENTRY.counter[type] or {}
  ENTRY.counter[type][mechanic] = 0
  return ENTRY.counter[type][mechanic]
end

CORE.AntiSpam = function(ENTRY, mechanic, timer)
  local t = GetTime()
  if not ENTRY.antispams[mechanic] or t - ENTRY.antispams[mechanic] > timer then
    ENTRY.antispams[mechanic] = t
    return true
  end
end

CORE.SetStage = function(ENTRY, n)
  ENTRY.stage = n
  WeakAuras.ScanEvents("PHASE_" .. n)
  CORE.SendMRTNote("Merfin_P" .. n .. "_Start")
end

CORE.GetStage = function(ENTRY)
  return ENTRY.stage
end

CORE.IsStage = function(ENTRY, n)
  if not ENTRY.stage then
    return true
  end
  return ENTRY.stage == n
end

local IncrMechanic = function(ENTRY, type, mechanic)
  ENTRY.counter[type] = ENTRY.counter[type] or {}
  local count = ENTRY.counter[type][mechanic]
  ENTRY.counter[type][mechanic] = (count or 0) + 1
  return ENTRY.counter[type][mechanic]
end

local GetAutoHide = function()
  if not WeakAuras.CurrentEncounter then
    return true
  else
    return not CORE.GetSettings("cooldown", "hold")
  end
end

local GetMechanicInfo = function(ENTRY, mechanic)
  local mechanicData = ENTRY.mechanics and ENTRY.mechanics[mechanic] or CORE.mechanics[mechanic]
  if mechanicData then
    local spellId = mechanicData[1]
    local spellName, icon = CORE.GetSpellCache(ENTRY, spellId)
    return spellName, icon
  end
end

--> Handlers & Prototype

local WA_HandlerEvent = "WA_MERFIN_RAID_HANDLER"
local SendEvent = function(...)
  WeakAuras.ScanEvents(WA_HandlerEvent, ...)
end

local SetState = function(duration, autoHide, name, icon, counter, destName, stacks)
  return {
    show = true,
    changed = true,
    progressType = "timed",
    duration = duration,
    expirationTime = duration + GetTime(),
    autoHide = autoHide,
    name = name,
    icon = icon,
    counter = counter,
    destName = destName,
    stacks = stacks,
    CORE = CORE,
  }
end

local Handlers = {

  CANCEL = function(a, caller, mechanic, cancelType, name)
    if mechanic == caller.mechanic and (cancelType == "ALL" or caller.type == cancelType) then
      local changed = false
      for stateName, state in pairs(a) do
        if not name or stateName == name then
          state.show = false
          state.changed = true
          changed = true
        end
      end
      return changed
    end
  end,

  WARNING = function(a, caller, mechanic, name, icon, counter, destName, stacks)
    if mechanic == caller.mechanic and caller.type == "WARNING" then
      local duration = 4
      local stateName = destName or ""
      a[stateName] = SetState(duration, true, name, icon, counter, destName, stacks)
      return true
    end
  end,

  SPECIAL_WARNING = function(a, caller, mechanic, ...)
    if mechanic == caller.mechanic and caller.type == "SPECIAL_WARNING" then
      local duration = 4
      local stateName = ""
      a[stateName] = SetState(duration, true, ...)
      return true
    end
  end,

  PRE_WARNING = function(a, caller, mechanic, duration, ...)
    if mechanic == caller.mechanic and caller.type == "PRE_WARNING" then
      local stateName = ""
      a[stateName] = SetState(duration, true, ...)
      return true
    end
  end,

  WARNING_MULTIPLY = function(a, caller, mechanic, name, icon, targets)
    if mechanic == caller.mechanic and caller.type == "WARNING_MULTIPLY" then
      local duration = 4
      local stateName = ""
      a[stateName] = SetState(duration, true, name, icon)
      a[stateName].names = BuildValuesString(targets)
      return true
    end
  end,

  COOLDOWN = function(a, caller, mechanic, duration, name, icon, counter, sourceName, forceHide)
    if mechanic == caller.mechanic and caller.type == "COOLDOWN" then
      local autoHide = forceHide or GetAutoHide()
      local stateName = sourceName or ""
      a[stateName] = SetState(duration, autoHide, name, icon, counter, sourceName)
      a[stateName].alphaOn = CORE.GetSettings("cooldown", "alpha")
      return true
    end
  end,

  TIMER = function(a, caller, mechanic, duration, ...)
    if mechanic == caller.mechanic and caller.type == "TIMER" then
      local stateName = ""
      a[stateName] = SetState(duration, true, ...)
      return true
    end
  end,

  PHASE = function(a, caller, mechanic, ...)
    if mechanic == caller.mechanic and caller.type == "PHASE" then
      local duration = 3
      local stateName = ""
      a[stateName] = SetState(duration, true, ...)
      return true
    end
  end,

  GTFO = function(a, caller, mechanic, ...)
    if mechanic == caller.mechanic and caller.type == "GTFO" then
      local duration = 1.5
      local stateName = ""
      a[stateName] = SetState(duration, true, ...)
      return true
    end
  end,
}

local Prototype = {

  CANCEL = function(ENTRY, mechanic, cancelType, name)
    if cancelType == "ALL" or cancelType == "PRE_WARNING" then
      if ENTRY.schedulers[mechanic] then
        WeakAuras.timer:CancelTimer(ENTRY.schedulers[mechanic])
      end
    end
    SendEvent(Handlers.CANCEL, mechanic, cancelType, name)
  end,

  WARNING = function(ENTRY, mechanic, destName, stacks)
    local spellName, icon = GetMechanicInfo(ENTRY, mechanic)
    local counter = IncrMechanic(ENTRY, "WARNING", mechanic)
    SendEvent(Handlers.WARNING, mechanic, spellName, icon, counter, destName, stacks)
  end,

  SPECIAL_WARNING = function(ENTRY, mechanic, destName, stacks)
    local spellName, icon = GetMechanicInfo(ENTRY, mechanic)
    local counter = IncrMechanic(ENTRY, "SPECIAL_WARNING", mechanic)
    SendEvent(Handlers.SPECIAL_WARNING, mechanic, spellName, icon, counter, destName, stacks)
  end,

  PRE_WARNING = function(ENTRY, mechanic, showIn, duration, counter)
    local spellName, icon = GetMechanicInfo(ENTRY, mechanic)
    if ENTRY.schedulers[mechanic] then
      WeakAuras.timer:CancelTimer(ENTRY.schedulers[mechanic])
    end
    ENTRY.schedulers[mechanic] = WeakAuras.timer:ScheduleTimer(
      SendEvent,
      showIn,
      Handlers.PRE_WARNING,
      mechanic,
      duration or 5,
      spellName,
      icon,
      counter or 0
    )
  end,

  WARNING_MULTIPLY = function(ENTRY, mechanic, targets)
    local spellName, icon = GetMechanicInfo(ENTRY, mechanic)
    SendEvent(Handlers.WARNING_MULTIPLY, mechanic, spellName, icon, targets)
  end,

  COOLDOWN = function(ENTRY, mechanic, duration, sourceName, forceHide, count)
    --[[
        if GMRT and GMRT.F and GMRT.F.Note_Timer then
            local customEvent = 'Merfin_'..mechanic..'_'..count
            GMRT.F.Note_Timer(customEvent)
        end
        ]]
    --
    if not CORE.GetSettings("cooldown", "visibility") then
      return
    end
    local spellName, icon = GetMechanicInfo(ENTRY, mechanic)
    local counter = count or IncrMechanic(ENTRY, "COOLDOWN", mechanic)
    SendEvent(Handlers.COOLDOWN, mechanic, duration, spellName, icon, counter, sourceName, forceHide)
  end,

  TIMER = function(ENTRY, mechanic, duration, destName, stacks, counter)
    local spellName, icon = GetMechanicInfo(ENTRY, mechanic)
    SendEvent(Handlers.TIMER, mechanic, duration, spellName, icon, counter, destName, stacks)
  end,

  PHASE = function(ENTRY, mechanic)
    local spellName, icon = GetMechanicInfo(ENTRY, mechanic)
    SendEvent(Handlers.PHASE, mechanic, spellName, icon)
  end,

  GTFO = function(ENTRY, mechanic)
    local spellName, icon = GetMechanicInfo(ENTRY, mechanic)
    SendEvent(Handlers.GTFO, mechanic, spellName, icon)
  end,
}

CORE.Prototype = function(ENTRY, TYPE, ...)
  Prototype[TYPE](ENTRY, ...)
end

CORE.SetDifficulty = function()
  difficulty = select(3, GetInstanceInfo())
  CORE.difficulty = (difficulty == 3 and "10_NORMAL")
    or (difficulty == 4 and "25_NORMAL")
    or (difficulty == 5 and "10_HEROIC")
    or (difficulty == 6 and "25_HEROIC")
end

-- Difficulty Changer
local Dungeon = CreateFrame("Frame")
Dungeon:RegisterEvent("PLAYER_ENTERING_WORLD")
Dungeon:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
Dungeon:SetScript("OnEvent", function(self, event, ...)
  if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_DIFFICULTY_CHANGED" then
    C_Timer.After(3, function()
      CORE.SetDifficulty()
    end)
  end
end)
