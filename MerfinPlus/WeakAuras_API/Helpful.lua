local strsplit, tonumber = strsplit, tonumber

Merfin.GetSpellInfo = GetSpellInfo
  or function(spellId)
    if C_Spell and C_Spell.GetSpellInfo then
      return C_Spell.GetSpellInfo(spellId).name
    end
  end

Merfin.GetIconCropped = function(iconId, iconSize)
  local cropped = "|T" .. iconId .. ":" .. iconSize .. ":" .. iconSize .. ":0:0:64:64:4:60:4:60|t"
  return cropped
end

local classIcons = {
  ["WARRIOR"] = 626008,
  ["PALADIN"] = 626003,
  ["HUNTER"] = 626000,
  ["ROGUE"] = 626005,
  ["PRIEST"] = 626004,
  ["DEATHKNIGHT"] = 135771,
  ["SHAMAN"] = 626006,
  ["MAGE"] = 626001,
  ["WARLOCK"] = 626007,
  ["MONK"] = 626002,
  ["DRUID"] = 625999,
  ["DEMONHUNTER"] = 1278301,
  ["EVOKER"] = 4514681,
}

Merfin.GetClassIcon = function(className)
  return classIcons[className]
end

local roleIcons = {
  TANK = "|A:groupfinder-icon-role-large-tank:14:14:0:0|a",
  DPS = "|A:groupfinder-icon-role-large-dps:14:14:0:0|a",
  HEALER = "|A:groupfinder-icon-role-large-heal:16:16:0:0|a",
}

Merfin.GetRoleIcon = function(role)
  return role and roleIcons[role] or ""
end

Merfin.GetShortColoredName = function(name, class, len)
  local shortName = string.sub(name, 1, len)
  local classColor = RAID_CLASS_COLORS[class]
  if not classColor then
    return shortName
  end
  return string.format("|cff%02x%02x%02x%s|r", classColor.r * 255, classColor.g * 255, classColor.b * 255, shortName)
end

Merfin.GetTitleEJ = function(ID)
  local section = C_EncounterJournal.GetSectionInfo(ID)
  if section then
    return section.title
  end
end

Merfin.GetBar1KeybindText = function(buttonIndex)
  if type(buttonIndex) ~= "number" or buttonIndex < 1 or buttonIndex > 12 then
    return nil
  end
  local cmd = "ACTIONBUTTON" .. buttonIndex
  local k1, k2 = GetBindingKey(cmd)
  if not k1 and not k2 then
    return nil
  end
  local function pretty(k)
    return GetBindingText(k, "KEY_", 1)
  end
  return (k1 and k2) and (pretty(k1) .. ", " .. pretty(k2)) or pretty(k1 or k2)
end

Merfin.GetNPCIDFromGUID = function(GUID)
  local guidType, _, _, _, _, id = strsplit("-", GUID or "")
  if guidType == "Creature" or guidType == "Vehicle" or guidType == "Pet" then
    return tonumber(id) or 0
  end
  return 0
end

Merfin = Merfin or {}

Merfin._spellCache = Merfin._spellCache or {
  ready = false,
  byName = {},
  manaCostBySpellID = {},
}

local function ParseRank(subText)
  if type(subText) ~= "string" then
    return 0
  end
  local r = subText:match("(%d+)")
  return r and (tonumber(r) or 0) or 0
end

Merfin.RebuildSpellCache = function()
  local cache = Merfin._spellCache
  cache.byName = {}
  cache.manaCostBySpellID = {}

  local numTabs = GetNumSpellTabs() or 0
  for tab = 1, numTabs do
    local _, _, offset, numSpells = GetSpellTabInfo(tab)
    offset = offset or 0
    numSpells = numSpells or 0

    for i = 1, numSpells do
      local index = offset + i
      local spellType = GetSpellBookItemInfo(index, BOOKTYPE_SPELL)
      if spellType == "SPELL" then
        local name, subText = GetSpellBookItemName(index, BOOKTYPE_SPELL)
        if name then
          local id = select(2, GetSpellBookItemInfo(index, BOOKTYPE_SPELL))
          local rank = ParseRank(subText)

          local prev = cache.byName[name]
          if not prev or rank > prev.rank then
            cache.byName[name] = { id = id, rank = rank }
          end
        end
      end
    end
  end

  for _, v in pairs(cache.byName) do
    local spellID = v.id
    local costs = GetSpellPowerCost(spellID)
    local manaCost = nil

    if type(costs) == "table" then
      for _, costInfo in ipairs(costs) do
        if costInfo and costInfo.type == Enum.PowerType.Mana then
          manaCost = costInfo.cost or 0
          break
        end
      end
    end

    if manaCost ~= nil then
      cache.manaCostBySpellID[spellID] = manaCost
    end
  end

  cache.ready = true
end

Merfin.GetHighestRankSpellID = function(spellID)
  local name = GetSpellInfo(spellID)
  if not name then
    return nil
  end

  local cache = Merfin._spellCache
  if not cache.ready then
    Merfin.RebuildSpellCache()
  end

  local entry = cache.byName[name]
  return (entry and entry.id) or spellID
end

Merfin.HasEnoughManaForSpell = function(spellID)
  if not spellID then
    return false
  end

  local cache = Merfin._spellCache
  local manaCost = cache.manaCostBySpellID[spellID]

  if manaCost == nil then
    local costs = GetSpellPowerCost(spellID)
    if type(costs) == "table" then
      for _, costInfo in ipairs(costs) do
        if costInfo and costInfo.type == Enum.PowerType.Mana then
          manaCost = costInfo.cost or 0
          break
        end
      end
    end
    if manaCost ~= nil then
      cache.manaCostBySpellID[spellID] = manaCost
    end
  end

  if manaCost == nil then
    return true
  end

  local currentMana = UnitPower("player", Enum.PowerType.Mana)
  return currentMana >= manaCost
end

Merfin.InsufficientResources = function(spellID)
  local maxRankID = Merfin.GetHighestRankSpellID(spellID)
  return not (maxRankID and Merfin.HasEnoughManaForSpell(maxRankID))
end

do
  local f = CreateFrame("Frame")
  f:RegisterEvent("PLAYER_LOGIN")
  f:RegisterEvent("SPELLS_CHANGED")
  f:RegisterEvent("PLAYER_TALENT_UPDATE")
  f:SetScript("OnEvent", function()
    Merfin.RebuildSpellCache()
  end)
end

Merfin.IsMacroSameByName = function(macroName, macroBody)
  if type(macroName) ~= "string" or macroName == "" then
    return false
  end
  if type(macroBody) ~= "string" then
    return false
  end

  local numGlobal, numChar = GetNumMacros()
  local maxGlobal = MAX_ACCOUNT_MACROS or 120

  local function CheckRange(fromIndex, toIndex)
    for i = fromIndex, toIndex do
      local name, _, body = GetMacroInfo(i)
      if name == macroName then
        return body == macroBody
      end
    end
    return false
  end

  local charFrom = maxGlobal + 1
  local charTo = maxGlobal + (numChar or 0)

  if (numChar or 0) > 0 and CheckRange(charFrom, charTo) then
    return true
  end

  if (numGlobal or 0) > 0 and CheckRange(1, numGlobal) then
    return true
  end

  return false
end

Merfin.UpdateMacroByName = function(macroName, macroBody)
  if type(macroName) ~= "string" or macroName == "" then
    return false
  end
  if type(macroBody) ~= "string" then
    return false
  end
  if InCombatLockdown() then
    return false
  end

  -- If macro already has the same body, do nothing
  if Merfin.IsMacroSameByName(macroName, macroBody) then
    return true
  end

  local numGlobal, numChar = GetNumMacros()
  local maxGlobal = MAX_ACCOUNT_MACROS or 120

  local function TryRange(fromIndex, toIndex)
    for i = fromIndex, toIndex do
      local name = GetMacroInfo(i)
      if name == macroName then
        EditMacro(i, nil, nil, macroBody)
        return true
      end
    end
    return false
  end

  local charFrom = maxGlobal + 1
  local charTo = maxGlobal + (numChar or 0)

  if (numChar or 0) > 0 and TryRange(charFrom, charTo) then
    return true
  end

  if (numGlobal or 0) > 0 and TryRange(1, numGlobal) then
    return true
  end

  return false
end
