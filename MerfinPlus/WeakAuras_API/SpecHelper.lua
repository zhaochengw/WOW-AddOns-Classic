local specData = {
  DRUID = { -- Balance / Feral / Restoration
    "RANGED",
    "MELEE",
    "HEALER",
  },

  DEATHKNIGHT = { -- Blood / Frost / Unholy
    "TANK",
    "MELEE",
    "MELEE",
  },

  HUNTER = { -- Beast Mastery / Marksmanship / Survival
    "RANGED",
    "RANGED",
    "RANGED",
  },

  MAGE = { -- Arcane / Fire / Frost
    "RANGED",
    "RANGED",
    "RANGED",
  },

  PALADIN = { -- Holy / Protection / Retribution
    "HEALER",
    "TANK",
    "MELEE",
  },

  PRIEST = { -- Discipline / Holy / Shadow
    "HEALER",
    "HEALER",
    "RANGED",
  },

  ROGUE = { -- Assassination / Combat / Subtlety
    "MELEE",
    "MELEE",
    "MELEE",
  },

  SHAMAN = { -- Elemental / Enhancement / Restoration
    "RANGED",
    "MELEE",
    "HEALER",
  },

  WARLOCK = { -- Affliction / Demonology / Destruction
    "RANGED",
    "RANGED",
    "RANGED",
  },

  WARRIOR = { -- Arms / Fury / Protection
    "MELEE",
    "MELEE",
    "TANK",
  },
}

Merfin.GetPlayerRole = function()
  local class = select(2, UnitClass("player"))
  local specList = specData[class]
  if not specList then
    return nil
  end

  local maxPoints = -1
  local maxIndex = 1
  local maxSpecID = 1

  for i = 1, 3 do
    local specID, _, _, _, pointsSpent = GetTalentTabInfo(i)
    if pointsSpent and pointsSpent > maxPoints then
      maxPoints = pointsSpent
      maxIndex = i
      maxSpecID = specID
    end
  end

  return specList[maxIndex], maxSpecID
end
