local GetSpellCooldown = GetSpellCooldown

local interruptSpells = {
  [1766] = true, -- Rogue Kick
  [2139] = true, -- Mage Counterspell
  [6552] = true, -- Warrior Pummel
  [15487] = true, -- Priest Silence
  [19647] = true, -- Warlock pet Spell Lock
  [47528] = true, -- Death Knight Mind Freeze
  [57994] = true, -- Shaman Wind Shear
  [78675] = true, -- Druid Solar Beam
  [89766] = true, -- Warlock Pet Axe Toss
  [96231] = true, -- Paldin Rebuke
  [106839] = true, -- Druid Skull Bash
  [116705] = true, -- Monk Spear Hand Strike
  [147362] = true, -- Hunter Countershot
  [183752] = true, -- Demon hunter Disrupt
  [351338] = true, -- Evoker Quell
}

Merfin.RP = {
  cooldowns = {},
}

Merfin.InterruptIcon = "|TInterface\\EncounterJournal\\UI-EJ-Icons.blp:16:16:0:0:255:66:198:214:7:27|t"

Merfin.GetCDTime = function(ID)
  if Merfin.RP.cooldowns[ID] and Merfin.RP.cooldowns[ID].expirationTime then
    return Merfin.RP.cooldowns[ID].expirationTime - GetTime()
  end
  return 0
end

Merfin.SaveCD = function(cooldown)
  if cooldown and cooldown.ID then
    local ID = cooldown.ID
    Merfin.RP.cooldowns[ID] = Merfin.RP.cooldowns[ID] or {}
    Merfin.RP.cooldowns[ID].expirationTime = cooldown.expirationTime
  end
end

Merfin.IsBossModOn = function()
  if C_AddOns.IsAddOnLoaded("BigWigs") then
    return true
  end
end

Merfin.CheckInterrupt = function(checkCooldown)
  for spellID in pairs(interruptSpells) do
    if IsSpellKnown(spellID) then
      return not checkCooldown or GetSpellCooldown(spellID) == 0
    end
  end
end
