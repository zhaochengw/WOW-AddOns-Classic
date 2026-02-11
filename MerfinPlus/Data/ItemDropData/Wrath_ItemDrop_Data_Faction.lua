do
  local MerfinPlus = select(2, ...)

  -- Reputation names (numeric -> string)
  MerfinPlus.REPUTATION_NAMES = {
    [5] = FACTION_STANDING_LABEL5, -- Friendly
    [6] = FACTION_STANDING_LABEL6, -- Honored
    [7] = FACTION_STANDING_LABEL7, -- Revered
    [8] = FACTION_STANDING_LABEL8, -- Exalted
  }

  -- Faction item sources
  -- itemID -> factionID + rep
  MerfinPlus.FactionSourceDB = MerfinPlus.FactionSourceDB or {}

  -- =================================================
  -- Argent Crusade (1106)
  -- =================================================
  MerfinPlus.FactionSourceDB[44297] = { factionID = 1106, reputation = 8 } -- Boots of the Neverending Path
  MerfinPlus.FactionSourceDB[44295] = { factionID = 1106, reputation = 8 } -- Polished Regimental Hauberk
  MerfinPlus.FactionSourceDB[44296] = { factionID = 1106, reputation = 8 } -- Helm of Purified Thoughts
  MerfinPlus.FactionSourceDB[44283] = { factionID = 1106, reputation = 8 } -- Signet of Hopeful Light
  MerfinPlus.FactionSourceDB[44248] = { factionID = 1106, reputation = 7 } -- Battle Mender's Helm
  MerfinPlus.FactionSourceDB[44247] = { factionID = 1106, reputation = 7 } -- Fang-Deflecting Faceguard
  MerfinPlus.FactionSourceDB[44244] = { factionID = 1106, reputation = 7 } -- Argent Skeleton Crusher
  MerfinPlus.FactionSourceDB[44245] = { factionID = 1106, reputation = 7 } -- Zombie Sweeper Shotgun
  MerfinPlus.FactionSourceDB[44214] = { factionID = 1106, reputation = 7 } -- Purifying Torch
  MerfinPlus.FactionSourceDB[44216] = { factionID = 1106, reputation = 6 } -- Cloak of Holy Extermination
  MerfinPlus.FactionSourceDB[44240] = { factionID = 1106, reputation = 6 } -- Special Issue Legplates
  MerfinPlus.FactionSourceDB[44239] = { factionID = 1106, reputation = 6 } -- Standard Issue Legguards

  -- =================================================
  -- Kirin Tor (1090)
  -- =================================================
  MerfinPlus.FactionSourceDB[44180] = { factionID = 1090, reputation = 8 } -- Robes of Crackling Flame
  MerfinPlus.FactionSourceDB[44181] = { factionID = 1090, reputation = 8 } -- Ghostflicker Waistband
  MerfinPlus.FactionSourceDB[44182] = { factionID = 1090, reputation = 8 } -- Boots of Twinkling Stars
  MerfinPlus.FactionSourceDB[44183] = { factionID = 1090, reputation = 8 } -- Fireproven Gauntlets
  MerfinPlus.FactionSourceDB[44179] = { factionID = 1090, reputation = 7 } -- Mind-Expanding Leggings
  MerfinPlus.FactionSourceDB[44176] = { factionID = 1090, reputation = 7 } -- Girdle of the Warrior Magi
  MerfinPlus.FactionSourceDB[44173] = { factionID = 1090, reputation = 7 } -- Flameheart Spell Scalpel
  MerfinPlus.FactionSourceDB[44174] = { factionID = 1090, reputation = 7 } -- Stave of Shrouded Mysteries
  MerfinPlus.FactionSourceDB[44167] = { factionID = 1090, reputation = 6 } -- Shroud of Dedicated Research
  MerfinPlus.FactionSourceDB[44170] = { factionID = 1090, reputation = 6 } -- Helm of the Majestic Stag
  MerfinPlus.FactionSourceDB[44171] = { factionID = 1090, reputation = 6 } -- Spaulders of Grounded Lightning
  MerfinPlus.FactionSourceDB[44166] = { factionID = 1090, reputation = 6 } -- Lightblade Rivener

  -- =================================================
  -- Knights of the Ebon Blade (1098)
  -- =================================================
  MerfinPlus.FactionSourceDB[44302] = { factionID = 1098, reputation = 8 } -- Belt of Dark Mending
  MerfinPlus.FactionSourceDB[44303] = { factionID = 1098, reputation = 8 } -- Darkheart Chestguard
  MerfinPlus.FactionSourceDB[44305] = { factionID = 1098, reputation = 8 } -- Kilt of Dark Mercy
  MerfinPlus.FactionSourceDB[44306] = { factionID = 1098, reputation = 8 } -- Death-Inured Sabatons
  MerfinPlus.FactionSourceDB[44256] = { factionID = 1098, reputation = 7 } -- Sterile Flesh-Handling Gloves
  MerfinPlus.FactionSourceDB[44258] = { factionID = 1098, reputation = 7 } -- Wound-Binder's Wristguards
  MerfinPlus.FactionSourceDB[44257] = { factionID = 1098, reputation = 7 } -- Spaulders of the Black Arrow
  MerfinPlus.FactionSourceDB[44250] = { factionID = 1098, reputation = 7 } -- Reaper of Dark Souls
  MerfinPlus.FactionSourceDB[44249] = { factionID = 1098, reputation = 7 } -- Runeblade of Demonstrable Power
  MerfinPlus.FactionSourceDB[44242] = { factionID = 1098, reputation = 6 } -- Dark Soldier Cape
  MerfinPlus.FactionSourceDB[44243] = { factionID = 1098, reputation = 6 } -- Toxin-Tempered Sabatons
  MerfinPlus.FactionSourceDB[44241] = { factionID = 1098, reputation = 6 } -- Unholy Persuader

  -- =================================================
  -- The Wyrmrest Accord (1091)
  -- =================================================
  MerfinPlus.FactionSourceDB[44202] = { factionID = 1091, reputation = 8 } -- Sandals of Crimson Fury
  MerfinPlus.FactionSourceDB[44203] = { factionID = 1091, reputation = 8 } -- Dragonfriend Bracers
  MerfinPlus.FactionSourceDB[44204] = { factionID = 1091, reputation = 8 } -- Grips of Fierce Pronouncements
  MerfinPlus.FactionSourceDB[44205] = { factionID = 1091, reputation = 8 } -- Legplates of Bloody Reprisal
  MerfinPlus.FactionSourceDB[44200] = { factionID = 1091, reputation = 7 } -- Ancestral Sinew Wristguards
  MerfinPlus.FactionSourceDB[44198] = { factionID = 1091, reputation = 7 } -- Breastplate of the Solemn Council
  MerfinPlus.FactionSourceDB[44201] = { factionID = 1091, reputation = 7 } -- Sabatons of Draconic Vigor
  MerfinPlus.FactionSourceDB[44199] = { factionID = 1091, reputation = 7 } -- Gavel of the Brewing Storm
  MerfinPlus.FactionSourceDB[44152] = { factionID = 1091, reputation = 7 } -- Arcanum of Blissful Mending
  MerfinPlus.FactionSourceDB[44188] = { factionID = 1091, reputation = 6 } -- Cloak of Peaceful Resolutions
  MerfinPlus.FactionSourceDB[44196] = { factionID = 1091, reputation = 6 } -- Sash of the Wizened Wyrm
  MerfinPlus.FactionSourceDB[44197] = { factionID = 1091, reputation = 6 } -- Bracers of Accorded Courtesy
  MerfinPlus.FactionSourceDB[44187] = { factionID = 1091, reputation = 6 } -- Fang of Truth
  MerfinPlus.FactionSourceDB[44140] = { factionID = 1091, reputation = 6 } -- Arcanum of the Eclipsed Moon
end
