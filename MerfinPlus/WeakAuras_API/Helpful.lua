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
