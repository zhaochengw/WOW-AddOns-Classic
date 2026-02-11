---@type string, AddonTable
local _, addonTable = ...
local L = addonTable.L
local ReforgeLite = addonTable.ReforgeLite
local GUI = addonTable.GUI

local SPEC_IDS = addonTable.SPEC_IDS

local StatHit = addonTable.statIds.HIT
local StatCrit = addonTable.statIds.CRIT
local StatHaste = addonTable.statIds.HASTE
local StatExp = addonTable.statIds.EXP

local SPELL_HASTE_BUFFS = {
  51470,  -- Elemental Oath
  135678, -- Energizing Spores
  49868,  -- Mind Quickening
  24907,  -- Moonkin Aura
}

local MELEE_HASTE_BUFFS = {
  128432, -- Cackling Howl
  128433, -- Serpent's Swiftness
  113742, -- Swiftblade's Cunning
  55610,  -- Unholy Aura
  30809,  -- Unleashed Rage
}

local MASTERY_BUFFS = {
  19740,  -- Blessing of Might
  116956, -- Grace of Air
  93435,  -- Roar of Courage
  128997, -- Spirit Beast Blessing
}

local CRIT_BUFFS = {
  1459,   -- Arcane Brilliance
  24604,  -- Furious Howl
  17007,  -- Leader of the Pack
  116781, -- Legacy of the White Tiger
  126309, -- Still Water
  90309,  -- Terrifying Roar
}

local function CheckForPlayerAura(buffTable)
  return ContainsIf(buffTable, C_UnitAuras.GetPlayerAuraBySpellID)
end

---Checks if player has a spell haste buff active
---@return boolean hasSpellHaste True if any spell haste buff is active
function ReforgeLite:PlayerHasSpellHasteBuff()
  return CheckForPlayerAura(SPELL_HASTE_BUFFS)
end

---Checks if player has a melee haste buff active
---@return boolean hasMeleeHaste True if any melee haste buff is active
function ReforgeLite:PlayerHasMeleeHasteBuff()
  return CheckForPlayerAura(MELEE_HASTE_BUFFS)
end

---Checks if player has a mastery buff active
---@return boolean hasMastery True if any mastery buff is active
function ReforgeLite:PlayerHasMasteryBuff()
  return CheckForPlayerAura(MASTERY_BUFFS)
end

---Checks if player has a crit buff active
---@return boolean hasCrit True if any crit buff is active
function ReforgeLite:PlayerHasCritBuff()
  return CheckForPlayerAura(CRIT_BUFFS)
end

---Gets the rating required per 1% of a stat at a given level
---@param stat number The stat ID
---@param level? number The target level (defaults to player level)
---@return number rating Rating points needed per 1% of stat
function ReforgeLite:RatingPerPoint (stat, level)
  level = level or UnitLevel("player")
  if stat == addonTable.statIds.SPELLHIT then
    stat = StatHit
  end
  return addonTable.ScalingTable[stat][level] or 0
end
---Gets the melee hit bonus from talents and other sources
---@return number bonus Melee hit percentage bonus
function ReforgeLite:GetMeleeHitBonus ()
  return GetHitModifier () or 0
end
---Gets the spell hit bonus from talents and other sources
---@return number bonus Spell hit percentage bonus
function ReforgeLite:GetSpellHitBonus ()
  return GetSpellHitModifier () or 0
end
---Gets the expertise bonus from talents and racials
---@return number bonus Expertise percentage bonus
function ReforgeLite:GetExpertiseBonus()
  local mhExpertise, _, rangedExpertise = GetExpertise()
  local expertise = addonTable.playerClass == "HUNTER" and rangedExpertise or mhExpertise
  return RoundToSignificantDigits(expertise - GetCombatRatingBonus(CR_EXPERTISE), 4)
end
---Calculates haste bonus from buffs for melee/ranged haste
---@param hasteFunc function Function to get base haste (GetMeleeHaste or GetRangedHaste)
---@param ratingBonusId number Combat rating type (CR_HASTE_MELEE or CR_HASTE_RANGED)
---@return number bonus Haste multiplier bonus from buffs
function ReforgeLite:GetNonSpellHasteBonus(hasteFunc, ratingBonusId)
  local baseBonus = RoundToSignificantDigits((hasteFunc()+100)/(GetCombatRatingBonus(ratingBonusId)+100), 4)
  if self.pdb.meleeHaste and not self:PlayerHasMeleeHasteBuff() then
    baseBonus = baseBonus * 1.1
  end
  return baseBonus
end
---Gets melee haste bonus multiplier from buffs
---@return number bonus Melee haste multiplier from buffs
function ReforgeLite:GetMeleeHasteBonus()
  return self:GetNonSpellHasteBonus(GetMeleeHaste, CR_HASTE_MELEE)
end
---Gets ranged haste bonus multiplier from buffs
---@return number bonus Ranged haste multiplier from buffs
function ReforgeLite:GetRangedHasteBonus()
  return self:GetNonSpellHasteBonus(GetRangedHaste, CR_HASTE_RANGED)
end
function ReforgeLite:GetMasteryBonus()
  local mastery, bonusCoeff = GetMasteryEffect()
  return mastery - GetCombatRatingBonus(CR_MASTERY) * bonusCoeff, bonusCoeff
end
---Gets spell haste bonus multiplier from buffs
---@return number bonus Spell haste multiplier from buffs
function ReforgeLite:GetSpellHasteBonus()
  local baseBonus = (UnitSpellHaste('PLAYER')+100)/(GetCombatRatingBonus(CR_HASTE_SPELL)+100)
  if self.pdb.spellHaste and not self:PlayerHasSpellHasteBuff() then
    baseBonus = baseBonus * 1.05
  end
  return RoundToSignificantDigits(baseBonus, 6)
end
---Gets all haste bonus multipliers (melee, ranged, spell)
---@return number meleeBonus Melee haste multiplier
---@return number rangedBonus Ranged haste multiplier
---@return number spellBonus Spell haste multiplier
function ReforgeLite:GetHasteBonuses()
  return self:GetMeleeHasteBonus(), self:GetRangedHasteBonus(), self:GetSpellHasteBonus()
end
---Calculates effective haste with a given bonus multiplier
---@param haste number Base haste rating
---@param hasteBonus number Haste multiplier from buffs
---@return number effectiveHaste Effective haste percentage
function ReforgeLite:CalcHasteWithBonus(haste, hasteBonus)
  return ((hasteBonus - 1) * 100) + haste * hasteBonus
end
---Calculates effective haste for all types (melee, ranged, spell)
---@param haste number Base haste rating
---@return number meleeHaste Effective melee haste percentage
---@return number rangedHaste Effective ranged haste percentage
---@return number spellHaste Effective spell haste percentage
function ReforgeLite:CalcHasteWithBonuses(haste)
  local meleeBonus, rangedBonus, spellBonus = self:GetHasteBonuses()
  return self:CalcHasteWithBonus(haste, meleeBonus), self:CalcHasteWithBonus(haste, rangedBonus), self:CalcHasteWithBonus(haste, spellBonus)
end

---Calculates required melee hit percentage for target level
---@return number hitPercent Required melee hit percentage
function ReforgeLite:GetNeededMeleeHit ()
  return max(0, 3 + 1.5 * self.pdb.targetLevel)
end
---Calculates required spell hit percentage for target level
---@return number hitPercent Required spell hit percentage
function ReforgeLite:GetNeededSpellHit ()
  local diff = self.pdb.targetLevel
  if diff <= 3 then
    return max(0, 6 + 3 * diff)
  else
    return 11 * diff - 18
  end
end

---Calculates required expertise percentage for soft cap (dodge)
---@return number expertisePercent Required expertise percentage for soft cap
function ReforgeLite:GetNeededExpertiseSoft()
  return max(0, 3 + 1.5 * self.pdb.targetLevel)
end

---Calculates required expertise percentage for hard cap (parry)
---@return number expertisePercent Required expertise percentage for hard cap
function ReforgeLite:GetNeededExpertiseHard()
  return max(0, 6 + 3 * self.pdb.targetLevel)
end

local function CreateIconMarkup(icon)
  return CreateTextureMarkup(icon, 64, 64, 18, 18, 0.07, 0.93, 0.07, 0.93, 0, 0) .. " "
end
addonTable.CreateIconMarkup = CreateIconMarkup

local AtLeast = addonTable.StatCapMethods.AtLeast
local AtMost = addonTable.StatCapMethods.AtMost
local CAPS = EnumUtil.MakeEnum("ManualCap", "MeleeHitCap", "SpellHitCap", "MeleeDWHitCap", "ExpSoftCap", "ExpHardCap")

ReforgeLite.capPresets = {
  {
    value = CAPS.ManualCap,
    name = TRACKER_SORT_MANUAL,
    getter = nil
  },
  {
    value = CAPS.MeleeHitCap,
    name = L["Melee hit cap"],
    getter = function ()
      return ReforgeLite:RatingPerPoint(StatHit) * (ReforgeLite:GetNeededMeleeHit() - ReforgeLite:GetMeleeHitBonus())
    end,
    category = StatHit
  },
  {
    value = CAPS.SpellHitCap,
    name = L["Spell hit cap"],
    getter = function ()
      return ReforgeLite:RatingPerPoint (addonTable.statIds.SPELLHIT) * (ReforgeLite:GetNeededSpellHit () - ReforgeLite:GetSpellHitBonus ())
    end,
    category = StatHit
  },
  {
    value = CAPS.MeleeDWHitCap,
    name = L["Melee DW hit cap"],
    getter = function ()
      return ReforgeLite:RatingPerPoint(StatHit) * (ReforgeLite:GetNeededMeleeHit() + 19 - ReforgeLite:GetMeleeHitBonus())
    end,
    category = StatHit
  },
  {
    value = CAPS.ExpSoftCap,
    name = L["Expertise soft cap"],
    getter = function ()
      return ReforgeLite:RatingPerPoint (StatExp) * (ReforgeLite:GetNeededExpertiseSoft() - ReforgeLite:GetExpertiseBonus())
    end,
    category = StatExp
  },
  {
    value = CAPS.ExpHardCap,
    name = L["Expertise hard cap"],
    getter = function ()
      return ReforgeLite:RatingPerPoint (StatExp) * (ReforgeLite:GetNeededExpertiseHard() - ReforgeLite:GetExpertiseBonus())
    end,
    category = StatExp
  },
}

local function GetSpellHasteRequired(percentNeeded)
  return function()
    local hasteMod = ReforgeLite:GetSpellHasteBonus()
    return ceil((percentNeeded - (hasteMod - 1) * 100) * ReforgeLite:RatingPerPoint(addonTable.statIds.HASTE) / hasteMod)
  end
end

local function AddHasteBreakpoint(name, getter, classID, specID)
  if classID ~= addonTable.playerClass then return CAPS.ManualCap end
  local newIndex = #ReforgeLite.capPresets + 1
  tinsert(ReforgeLite.capPresets, {
    category = StatHaste,
    name = name,
    getter = getter,
    classID = classID,
    specID = specID,
    value = newIndex
  })
  return newIndex
end

local nameFormat = "%s%s%% +%s %s "
local nameFormatWithTicks = nameFormat..L["ticks"]

local HASTE_BREAKS = setmetatable({}, {
  __index = function(t, k)
    rawset(t,k, {})
    return t[k]
  end
})

HASTE_BREAKS.DRUID.WILD_MUSHROOM = AddHasteBreakpoint(
  ("%s%s %s%%"):format(CreateIconMarkup(236152), C_Spell.GetSpellName(79577), 24.22),
  GetSpellHasteRequired(24.215),
  "DRUID",
  SPEC_IDS.DRUID.balance
)
HASTE_BREAKS.DRUID.REJUV_LIFEBLOOM = AddHasteBreakpoint(
  nameFormatWithTicks:format(CreateIconMarkup(136081)..CreateIconMarkup(136107), 12.52, 1, C_Spell.GetSpellName(774) .. " / " .. C_Spell.GetSpellName(740)),
  GetSpellHasteRequired(12.52),
  "DRUID",
  SPEC_IDS.DRUID.restoration
)

local eternalFlame, eternalFlameMarkup = C_Spell.GetSpellName(114163), CreateIconMarkup(135433)
local sacredShield, sacredShieldMarkup = C_Spell.GetSpellName(20925), CreateIconMarkup(236249)
AddHasteBreakpoint(
  nameFormatWithTicks:format(eternalFlameMarkup, 4.99, 1, eternalFlame),
  GetSpellHasteRequired(4.986880),
  "PALADIN",
  SPEC_IDS.PALADIN.holy
)
AddHasteBreakpoint(
  nameFormatWithTicks:format(sacredShieldMarkup, 10.00, 1, sacredShield),
  GetSpellHasteRequired(10.000919),
  "PALADIN",
  SPEC_IDS.PALADIN.holy
)
AddHasteBreakpoint(
  nameFormatWithTicks:format(eternalFlameMarkup, 15.01, 2, eternalFlame),
  GetSpellHasteRequired(15.008630),
  "PALADIN",
  SPEC_IDS.PALADIN.holy
)
HASTE_BREAKS.PALADIN.ETERNAL_FLAME_3 = AddHasteBreakpoint(
  nameFormatWithTicks:format(eternalFlameMarkup, 25.03, 3, eternalFlame),
  GetSpellHasteRequired(25.026052),
  "PALADIN",
  SPEC_IDS.PALADIN.holy
)
AddHasteBreakpoint(
  nameFormatWithTicks:format(sacredShieldMarkup, 30.00, 2, sacredShield),
  GetSpellHasteRequired(29.996753),
  "PALADIN",
  SPEC_IDS.PALADIN.holy
)
AddHasteBreakpoint(
  nameFormatWithTicks:format(eternalFlameMarkup, 34.99, 4, eternalFlame),
  GetSpellHasteRequired(34.983133),
  "PALADIN",
  SPEC_IDS.PALADIN.holy
)

local renew, renewMarkup = C_Spell.GetSpellName(139), CreateIconMarkup(135953)
AddHasteBreakpoint(
  nameFormatWithTicks:format(renewMarkup, 12.51, 1, renew),
  GetSpellHasteRequired(12.51),
  "PRIEST"
)
AddHasteBreakpoint(
  nameFormatWithTicks:format(renewMarkup, 37.52, 2, renew),
  GetSpellHasteRequired(37.52),
  "PRIEST"
)
AddHasteBreakpoint(
  nameFormatWithTicks:format(renewMarkup, 62.53, 3, renew),
  GetSpellHasteRequired(62.53),
  "PRIEST"
)
AddHasteBreakpoint(
  nameFormatWithTicks:format(renewMarkup, 87.44, 4, renew),
  GetSpellHasteRequired(87.44),
  "PRIEST"
)

local doom, doomMarkup = C_Spell.GetSpellName(603), CreateIconMarkup(136122)
AddHasteBreakpoint( -- Doom
  nameFormatWithTicks:format(doomMarkup, 12.50, 1, doom),
  GetSpellHasteRequired(12.498595),
  "WARLOCK",
  SPEC_IDS.WARLOCK.demonology
)
AddHasteBreakpoint( -- Doom
  nameFormatWithTicks:format(doomMarkup, 24.92, 2, doom),
  GetSpellHasteRequired(24.921939),
  "WARLOCK",
  SPEC_IDS.WARLOCK.demonology
)
AddHasteBreakpoint( -- Shadowflame
  nameFormatWithTicks:format(CreateIconMarkup(425954), 37.50, 2, C_Spell.GetSpellName(47960)),
  GetSpellHasteRequired(37.494845),
  "WARLOCK",
  SPEC_IDS.WARLOCK.demonology
)
local immolate, immolateMarkup = C_Spell.GetSpellName(348), CreateIconMarkup(135817)
AddHasteBreakpoint( -- Immolate
  nameFormatWithTicks:format(immolateMarkup, 9.99, 1, immolate),
  GetSpellHasteRequired(9.990838),
  "WARLOCK",
  SPEC_IDS.WARLOCK.destruction
)
AddHasteBreakpoint( -- Immolate
  nameFormatWithTicks:format(immolateMarkup, 30.01, 2, immolate),
  GetSpellHasteRequired(30.010840),
  "WARLOCK",
  SPEC_IDS.WARLOCK.destruction
)
local unstableAffliction, unstableAfflictionMarkup = C_Spell.GetSpellName(30108), CreateIconMarkup(136228)
AddHasteBreakpoint( -- Unstable Affliction
  nameFormatWithTicks:format(unstableAfflictionMarkup, 21.40, 2, unstableAffliction),
  GetSpellHasteRequired(21.396062),
  "WARLOCK",
  SPEC_IDS.WARLOCK.affliction
)
local agony, agonyMarkup = C_Spell.GetSpellName(980), CreateIconMarkup(136139)
AddHasteBreakpoint( -- Agony
  nameFormatWithTicks:format(agonyMarkup, 29.16, 4, agony),
  GetSpellHasteRequired(29.157257),
  "WARLOCK",
  SPEC_IDS.WARLOCK.affliction
)
AddHasteBreakpoint( -- Unstable Affliction
  nameFormatWithTicks:format(unstableAfflictionMarkup, 35.73, 3, unstableAffliction),
  GetSpellHasteRequired(35.731261),
  "WARLOCK",
  SPEC_IDS.WARLOCK.affliction
)
AddHasteBreakpoint( -- Agony
  nameFormatWithTicks:format(agonyMarkup, 37.51, 5, agony),
  GetSpellHasteRequired(37.504306),
  "WARLOCK",
  SPEC_IDS.WARLOCK.affliction
)
AddHasteBreakpoint( -- Corruption
  nameFormatWithTicks:format(CreateIconMarkup(136118), 38.94, 4, C_Spell.GetSpellName(172)),
  GetSpellHasteRequired(38.937141),
  "WARLOCK",
  SPEC_IDS.WARLOCK.affliction
)

local HitCap = { stat = StatHit, points = { { method = AtLeast, preset = CAPS.MeleeHitCap } } }

local HitCapSpell = { stat = StatHit, points = { { method = AtLeast, preset = CAPS.SpellHitCap } } }

local SoftExpCap = { stat = StatExp, points = { { method = AtLeast, preset = CAPS.ExpSoftCap } } }

local HardExpCap = { stat = StatExp, points = { { method = AtLeast, preset = CAPS.ExpHardCap } } }

local MeleeCaps = { HitCap, SoftExpCap }

local AtMostMeleeCaps = {
  { stat = StatHit, points = { { method = AtMost, preset = CAPS.MeleeHitCap } } },
  { stat = StatExp, points = { { method = AtMost, preset = CAPS.ExpSoftCap } } }
}

local TankCaps = { HitCap, HardExpCap }

local CasterCaps = { HitCapSpell }

-- Preset builder functions
local function Preset(spirit, dodge, parry, hit, crit, haste, exp, mastery, caps, icon)
  return {
    weights = {spirit or 0, dodge or 0, parry or 0, hit or 0, crit or 0, haste or 0, exp or 0, mastery or 0},
    caps = caps,
    icon = icon,
  }
end

local function MeleePreset(hit, crit, haste, exp, mastery)
  return Preset(0, 0, 0, hit, crit, haste, exp, mastery, MeleeCaps)
end

local function TankPreset(spirit, dodge, parry, hit, crit, haste, exp, mastery, caps)
  return Preset(spirit, dodge, parry, hit, crit, haste, exp, mastery, caps or TankCaps)
end

local function CasterPreset(hit, crit, haste, mastery)
  return Preset(0, 0, 0, hit, crit, haste, 0, mastery, CasterCaps)
end

local function HealerPreset(spirit, crit, haste, mastery)
  return Preset(spirit, 0, 0, 0, crit, haste, 0, mastery)
end

local specInfo
local function UpdateSpecInfo(ids)
  for _, id in pairs(ids) do
    local _, tabName, _, icon = GetSpecializationInfoByID(id)
    specInfo[id] = { name = tabName, icon = icon }
  end
end

---Initializes class-specific stat weight and cap presets
---Loads presets for all specs of the player's class (or all classes in debug mode)
---@return nil
function ReforgeLite:InitClassPresets()

  local presets = {
    ["DEATHKNIGHT"] = {
      [SPEC_IDS.DEATHKNIGHT.blood] = {
        [L["Defensive"]] = Preset(0, 140, 150, 100, 50, 75, 95, 200, AtMostMeleeCaps),
        [L["Balanced"]] = Preset(0, 140, 150, 200, 100, 125, 200, 25, MeleeCaps),
        [L["Offensive"]] = {
          weights = {0, 90, 100, 200, 150, 125, 200, 0},
          caps = {
            HitCap,
            { stat = StatExp, points = { { method = AtLeast, preset = CAPS.ExpSoftCap, after = 50 } } }
          },
        },
      },
      [SPEC_IDS.DEATHKNIGHT.frost] = {
        [C_Spell.GetSpellName(49020)] = Preset(0, 0, 0, 82, 44, 45, 82, 35, MeleeCaps, 135771), -- Obliterate
        [L["Masterfrost"]] = Preset(0, 0, 0, 84, 36, 37, 83, 53, MeleeCaps, 135833),
      },
      [SPEC_IDS.DEATHKNIGHT.unholy] = MeleePreset(73, 47, 43, 73, 40),
    },
    ["DRUID"] = {
      [SPEC_IDS.DRUID.balance] = {
        weights = {0, 0, 0, 88, 54, 55, 0, 46},
        caps = {
          HitCapSpell,
          {
            stat = StatHaste,
            points = {
              {
                method = AtLeast,
                preset = HASTE_BREAKS.DRUID.WILD_MUSHROOM,
                after = 46,
              }
            }
          }
        },
      },
      [SPEC_IDS.DRUID.feralcombat] = Preset(0, 0, 0, 44, 49, 42, 44, 39, AtMostMeleeCaps),
      [SPEC_IDS.DRUID.guardian] = TankPreset(0, 53, 0, 116, 105, 37, 116, 73),
      [SPEC_IDS.DRUID.restoration] = {
        weights = {150, 0, 0, 0, 100, 200, 0, 150},
        caps = {
          {
            stat = StatHaste,
            points = {
              {
                method = AtLeast,
                preset = HASTE_BREAKS.DRUID.REJUV_LIFEBLOOM,
                after = 50,
              }
            }
          }
        },
      },
    },
    ["HUNTER"] = {
      [SPEC_IDS.HUNTER.beastmastery] = MeleePreset(30, 28, 29, 30, 25),
      [SPEC_IDS.HUNTER.marksmanship] = MeleePreset(44, 43, 35, 44, 19),
      [SPEC_IDS.HUNTER.survival] = MeleePreset(33, 32, 27, 33, 21),
    },
    ["MAGE"] = {
      [SPEC_IDS.MAGE.arcane] = CasterPreset(145, 59, 64, 70),
      [SPEC_IDS.MAGE.fire] = CasterPreset(121, 94, 95, 59),
      [SPEC_IDS.MAGE.frost] = CasterPreset(155, 54, 81, 52),
    },
    ["MONK"] = {
      [SPEC_IDS.MONK.brewmaster] = {
        [PET_DEFENSIVE] = TankPreset(0, 0, 0, 150, 50, 50, 130, 100),
        [PET_AGGRESSIVE] = TankPreset(0, 0, 0, 141, 46, 57, 99, 39),
      },
      [SPEC_IDS.MONK.mistweaver] = HealerPreset(80, 200, 40, 30),
      [SPEC_IDS.MONK.windwalker] = {
        [C_Spell.GetSpellName(114355)] = Preset(0, 0, 0, 141, 44, 49, 99, 39, MeleeCaps, 132147), -- Dual Wield
        [AUCTION_SUBCATEGORY_TWO_HANDED] = Preset(0, 0, 0, 141, 64, 63, 141, 62, MeleeCaps, 135145), -- Two-Handed
      },
    },
    ["PALADIN"] = {
      [SPEC_IDS.PALADIN.holy] = {
        weights = {200, 0, 0, 0, 50, 125, 0, 100},
        caps = {
          {
            stat = StatHaste,
            points = {
              {
                method = AtLeast,
                preset = HASTE_BREAKS.PALADIN.ETERNAL_FLAME_3,
                after = 75,
              }
            }
          }
        },
      },
      [SPEC_IDS.PALADIN.protection] = {
        [PET_DEFENSIVE] = TankPreset(0, 50, 50, 200, 25, 100, 200, 125),
        [PET_AGGRESSIVE] = TankPreset(0, 5, 5, 200, 75, 125, 200, 25),
      },
      [SPEC_IDS.PALADIN.retribution] = MeleePreset(100, 50, 52, 87, 51),
    },
    ["PRIEST"] = {
      [SPEC_IDS.PRIEST.discipline] = HealerPreset(120, 120, 40, 80),
      [SPEC_IDS.PRIEST.holy] = HealerPreset(150, 120, 40, 80),
      [SPEC_IDS.PRIEST.shadow] = CasterPreset(85, 46, 59, 44),
    },
    ["ROGUE"] = {
      [SPEC_IDS.ROGUE.assassination] = MeleePreset(46, 37, 35, 42, 41),
      [SPEC_IDS.ROGUE.combat] = MeleePreset(70, 29, 39, 56, 32),
      [SPEC_IDS.ROGUE.subtlety] = MeleePreset(54, 31, 32, 35, 26),
    },
    ["SHAMAN"] = {
      [SPEC_IDS.SHAMAN.elemental] = {
        [L["Single Target"]] = Preset(0, 0, 0, 110, 37, 47, 0, 44, CasterCaps, 136048),
        [L["AoE"]] = Preset(0, 0, 0, 118, 71, 48, 0, 73, CasterCaps, 136015),
      },
      [SPEC_IDS.SHAMAN.enhancement] = MeleePreset(97, 41, 42, 97, 46),
      [SPEC_IDS.SHAMAN.restoration] = HealerPreset(120, 100, 150, 75),
    },
    ["WARLOCK"] = {
      [SPEC_IDS.WARLOCK.affliction] = CasterPreset(90, 56, 73, 68),
      [SPEC_IDS.WARLOCK.destruction] = CasterPreset(93, 55, 50, 61),
      [SPEC_IDS.WARLOCK.demonology] = CasterPreset(400, 60, 66, 63),
    },
    ["WARRIOR"] = {
      [SPEC_IDS.WARRIOR.arms] = MeleePreset(188, 65, 30, 139, 49),
      [SPEC_IDS.WARRIOR.fury] = {
        [C_Spell.GetSpellName(46917)] = Preset(0, 0, 0, 162, 107, 41, 142, 70, MeleeCaps, 236316), -- Titan's Grip
        [C_Spell.GetSpellName(81099)] = Preset(0, 0, 0, 137, 94, 41, 119, 59, MeleeCaps, 458974), -- Single-Minded Fury
      },
      [SPEC_IDS.WARRIOR.protection] = TankPreset(0, 140, 150, 200, 25, 50, 200, 100),
    },
  }

  self.presets = wipe(self.presets or {})
  specInfo = wipe(specInfo or {})
  if self.db.debug then
    for classFile, className in pairs(LOCALIZED_CLASS_NAMES_MALE) do
      self.presets[className] = presets[classFile]
    end
    TableUtil.Execute(SPEC_IDS, UpdateSpecInfo)
  else
    self.presets = presets[addonTable.playerClass]
    UpdateSpecInfo(SPEC_IDS[addonTable.playerClass])
  end
end

local DYNAMIC_PRESETS = tInvert( { "Pawn", CUSTOM } )

---Initializes custom user-created presets from saved variables
---@return nil
function ReforgeLite:InitCustomPresets()
  local customPresets = {}
  for k, v in pairs(self.cdb.customPresets) do
    local preset = CopyTable(v)
    preset.name = k
    tinsert(customPresets, preset)
  end
  self.presets[CUSTOM] = customPresets
end

---Initializes all dynamic presets (class and custom)
---@return nil
function ReforgeLite:InitDynamicPresets()
  self:InitClassPresets()
  self:InitCustomPresets()
end

---Initializes all presets including Pawn integration and preset menu
---Sets up class presets, custom presets, Pawn integration, and menu generator
---@return nil
function ReforgeLite:InitPresets()
  self:InitDynamicPresets()
  if PawnVersion then
    self.presets["Pawn"] = function ()
      if not PawnCommon or not PawnCommon.Scales then return {} end
      local result = {}
      for k, v in pairs (PawnCommon.Scales) do
        if v.ClassID == addonTable.playerClassID then
          local preset = {name = v.LocalizedName or k}
          preset.weights = {}
          local raw = v.Values or {}
          preset.weights[addonTable.statIds.SPIRIT] = raw["Spirit"] or 0
          preset.weights[addonTable.statIds.DODGE] = raw["DodgeRating"] or 0
          preset.weights[addonTable.statIds.PARRY] = raw["ParryRating"] or 0
          preset.weights[StatHit] = raw["HitRating"] or 0
          preset.weights[StatCrit] = raw["CritRating"] or 0
          preset.weights[StatHaste] = raw["HasteRating"] or 0
          preset.weights[StatExp] = raw["ExpertiseRating"] or 0
          preset.weights[addonTable.statIds.MASTERY] = raw["MasteryRating"] or 0
          local total = 0
          local average = 0
          for i = 1, addonTable.itemStatCount do
            if preset.weights[i] ~= 0 then
              total = total + 1
              average = average + preset.weights[i]
            end
          end
          if total > 0 and average > 0 then
            local factor = 1
            while factor * average / total < 10 do
              factor = factor * 100
            end
            while factor * average / total > 1000 do
              factor = factor / 10
            end
            for i = 1, addonTable.itemStatCount do
              preset.weights[i] = preset.weights[i] * factor
            end
            tinsert(result, preset)
          end
        end
      end
      return result
    end
  end

  self.presetMenuGenerator = function(owner, rootDescription)
    GUI:ClearEditFocus()

    local saveButton = rootDescription:CreateButton(SAVE, function()
      GUI.CreateStaticPopup("REFORGE_LITE_SAVE_PRESET",
        L["Enter the preset name"],
        function(popup)
          self.cdb.customPresets[popup:GetEditBox():GetText()] = {
            caps = CopyTable(self.pdb.caps),
            weights = CopyTable(self.pdb.weights)
          }
          self:InitCustomPresets()
        end, { hasEditBox = 1 })
      StaticPopup_Show("REFORGE_LITE_SAVE_PRESET")
    end)

    saveButton:SetTitleAndTextTooltip(L["Save current stat weights and caps as a custom preset"], L["Custom presets are shared across all characters of this class"])

    rootDescription:CreateDivider()

    local function GetCapPresetName(presetValue)
      local value = FindValueInTableIf(self.capPresets, function(preset) return preset.value == presetValue end) or {}
      return value.name
    end

    local function FormatWeightsTooltip(tooltip, element, preset)
      if not preset or not preset.weights then return end
      local statWeights = {}
      for i, weight in ipairs(preset.weights) do
        if weight and weight > 0 then
          tinsert(statWeights, {stat = addonTable.itemStats[i].long, weight = weight, index = i})
        end
      end
      local rightR, rightG, rightB = addonTable.COLORS.white:GetRGB()
      if statWeights[1] then
        tooltip:AddLine(element.text, rightR, rightG, rightB)
        sort(statWeights, function(a, b)
          if a.weight == b.weight then
            return a.index < b.index
          end
          return a.weight > b.weight
        end)
        for _, entry in ipairs(statWeights) do
          tooltip:AddDoubleLine(entry.stat, entry.weight, nil, nil, nil, rightR, rightG, rightB)
        end
      end
      if preset.caps then
        local methodNames = {
          [addonTable.StatCapMethods.AtLeast] = L["At least"],
          [addonTable.StatCapMethods.AtMost] = L["At most"],
          [addonTable.StatCapMethods.Exactly] = L["Exactly"],
        }
        for i, cap in ipairs(preset.caps) do
          if cap and cap.stat and cap.stat > 0 and cap.points and cap.points[1] then
            local statName = addonTable.itemStats[cap.stat] and addonTable.itemStats[cap.stat].long or ""
            local pt = cap.points[1]
            local presetName = GetCapPresetName(pt.preset)
            local methodName = methodNames[pt.method] or ""
            local capText
            if presetName and pt.preset ~= CAPS.ManualCap then
              capText = ("%s %s"):format(methodName, presetName)
            else
              capText = ("%s %d"):format(methodName, pt.value or 0)
            end
            tooltip:AddLine(L["Cap %d - %s"]:format(i, statName))
            tooltip:AddLine("  " .. capText, rightR, rightG, rightB)
          end
        end
      end
    end

    local function AddPresetButton(desc, info)
      if info.hasDelete then
        local button = desc:CreateButton(info.text, function(mouseButton)
          if IsShiftKeyDown() then
            GUI.CreateStaticPopup("REFORGE_LITE_DELETE_PRESET",
              L["Delete preset '%s'?"]:format(info.presetName),
              function()
                self.cdb.customPresets[info.presetName] = nil
                self:InitCustomPresets()
              end, { button1 = DELETE })
            StaticPopup_Show("REFORGE_LITE_DELETE_PRESET")
          else
            if info.value.targetLevel then
              self.pdb.targetLevel = info.value.targetLevel
              self.targetLevel:SetValue(info.value.targetLevel)
            end
            self:SetStatWeights(info.value.weights, info.value.caps or {})
          end
        end)
        button:SetTooltip(function(tooltip, element)
          FormatWeightsTooltip(tooltip, element, info.value)
          tooltip:AddLine(" ")
          GameTooltip_AddColoredLine(tooltip, L["Shift+Click to delete"], addonTable.COLORS.red)
        end)
      else
        local button = desc:CreateButton(info.text, function()
          if info.value.targetLevel then
            self.pdb.targetLevel = info.value.targetLevel
            self.targetLevel:SetValue(info.value.targetLevel)
          end
          self:SetStatWeights(info.value.weights, info.value.caps or {})
        end)
        button:SetTooltip(function(tooltip, element)
          FormatWeightsTooltip(tooltip, element, info.value)
        end)
      end
    end

    local menuList = {}
    for k in pairs(self.presets) do
      local v = GetValueOrCallFunction(self.presets, k)
      local isClassMenu = type(v) == "table" and not v.weights and not v.caps

      if isClassMenu then
        local classInfo = {
          sortKey = specInfo[k] and specInfo[k].name or k,
          text = specInfo[k] and specInfo[k].name or k,
          prioritySort = DYNAMIC_PRESETS[k] or 0,
          key = k,
          isSubmenu = true,
          submenuItems = {}
        }
        if specInfo[k] then
          classInfo.text = CreateIconMarkup(specInfo[k].icon) .. specInfo[k].name
        end

        for specId, preset in pairs(v) do
          local hasSubPresets = type(preset) == "table" and not preset.weights and not preset.caps

          if hasSubPresets then
            local specSubmenu = {
              sortKey = (specInfo[specId] and specInfo[specId].name) or tostring(specId),
              text = (specInfo[specId] and specInfo[specId].name) or tostring(specId),
              prioritySort = 0,
              isSubmenu = true,
              submenuItems = {}
            }
            if specInfo[specId] then
              specSubmenu.text = CreateIconMarkup(specInfo[specId].icon) .. specInfo[specId].name
            end

            for subK, subPreset in pairs(preset) do
              if type(subPreset) == "table" and (subPreset.weights or subPreset.caps) then
                local subSubInfo = {
                  sortKey = subK,
                  text = subK,
                  prioritySort = DYNAMIC_PRESETS[subK] or 0,
                  value = subPreset,
                }
                if subPreset.icon then
                  subSubInfo.text = CreateIconMarkup(subPreset.icon) .. subSubInfo.text
                end
                tinsert(specSubmenu.submenuItems, subSubInfo)
              end
            end

            if #specSubmenu.submenuItems > 0 then
              sort(specSubmenu.submenuItems, function (a, b)
                if a.prioritySort ~= b.prioritySort then
                  return a.prioritySort > b.prioritySort
                end
                return tostring(a.sortKey) < tostring(b.sortKey)
              end)
              tinsert(classInfo.submenuItems, specSubmenu)
            end
          else
            local subInfo = {
              sortKey = preset.name or (specInfo[specId] and specInfo[specId].name) or tostring(specId),
              text = preset.name or (specInfo[specId] and specInfo[specId].name) or tostring(specId),
              prioritySort = DYNAMIC_PRESETS[k] or 0,
              value = preset,
              hasDelete = (k == CUSTOM),
              presetName = preset.name,
            }
            if specInfo[specId] then
              subInfo.text = CreateIconMarkup(specInfo[specId].icon) .. specInfo[specId].name
              subInfo.sortKey = specInfo[specId].name
            end
            if preset.icon then
              subInfo.text = CreateIconMarkup(preset.icon) .. subInfo.text
            end
            tinsert(classInfo.submenuItems, subInfo)
          end
        end

        sort(classInfo.submenuItems, function (a, b)
          if a.prioritySort ~= b.prioritySort then
            return a.prioritySort > b.prioritySort
          end
          return tostring(a.sortKey) < tostring(b.sortKey)
        end)

        tinsert(menuList, classInfo)
      else
        local info = {
          sortKey = v.name or k,
          text = v.name or k,
          prioritySort = DYNAMIC_PRESETS[k] or 0,
          value = v,
        }
        if specInfo[k] then
          info.text = CreateIconMarkup(specInfo[k].icon) .. specInfo[k].name
          info.sortKey = specInfo[k].name
        end
        if v.icon then
          info.text = CreateIconMarkup(v.icon) .. info.text
        end
        tinsert(menuList, info)
      end
    end

    sort(menuList, function (a, b)
      if a.prioritySort ~= b.prioritySort then
        return a.prioritySort > b.prioritySort
      end
      return tostring(a.sortKey) < tostring(b.sortKey)
    end)

    local function AddMenuItems(desc, items)
      for _, info in ipairs(items) do
        if info.isSubmenu then
          local submenu = desc:CreateButton(info.text)
          if #info.submenuItems == 0 then
            submenu:SetEnabled(false)
          end
          AddMenuItems(submenu, info.submenuItems)
        elseif info.value and (info.value.caps or info.value.weights) then
          AddPresetButton(desc, info)
        end
      end
    end

    AddMenuItems(rootDescription, menuList)
  end

  --[===[@debug@
  addonTable.callbacks:RegisterCallback("ToggleDebug", function() self:InitDynamicPresets() end)
  --@end-debug@]===]
end
