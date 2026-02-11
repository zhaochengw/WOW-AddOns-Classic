-- MerfinPlus Item Source Resolver (Data - MoP Faction)

do
  local MerfinPlus = select(2, ...)

  -- Reputation names (numeric -> string)
  MerfinPlus.REPUTATION_NAMES = MerfinPlus.REPUTATION_NAMES
    or {
      [4] = FACTION_STANDING_LABEL4, -- Neutral
      [5] = FACTION_STANDING_LABEL5, -- Friendly
      [6] = FACTION_STANDING_LABEL6, -- Honored
      [7] = FACTION_STANDING_LABEL7, -- Revered
      [8] = FACTION_STANDING_LABEL8, -- Exalted
    }

  -- Faction item sources
  -- itemID -> factionID + reputationID
  MerfinPlus.FactionSourceDB = MerfinPlus.FactionSourceDB or {}

  -- Shado-Pan Assault (1435)
  MerfinPlus.FactionSourceDB[95101] = { factionID = 1435, reputationID = 8 }
  MerfinPlus.FactionSourceDB[95102] = { factionID = 1435, reputationID = 8 }
  MerfinPlus.FactionSourceDB[95096] = { factionID = 1435, reputationID = 8 }
  MerfinPlus.FactionSourceDB[95097] = { factionID = 1435, reputationID = 8 }
  MerfinPlus.FactionSourceDB[95100] = { factionID = 1435, reputationID = 8 }
  MerfinPlus.FactionSourceDB[95099] = { factionID = 1435, reputationID = 8 }
  MerfinPlus.FactionSourceDB[95095] = { factionID = 1435, reputationID = 8 }
  MerfinPlus.FactionSourceDB[95098] = { factionID = 1435, reputationID = 8 }
  MerfinPlus.FactionSourceDB[95103] = { factionID = 1435, reputationID = 8 }
  MerfinPlus.FactionSourceDB[95104] = { factionID = 1435, reputationID = 8 }
  MerfinPlus.FactionSourceDB[97131] = { factionID = 1435, reputationID = 8 }
  MerfinPlus.FactionSourceDB[95559] = { factionID = 1435, reputationID = 7 }
  MerfinPlus.FactionSourceDB[95081] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95082] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95106] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95105] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95135] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95136] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95090] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95091] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95123] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95122] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95078] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95077] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95134] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95133] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95108] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95107] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95088] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95089] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95125] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95124] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95079] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95080] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95132] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95131] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95109] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95112] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95087] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95086] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95127] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95126] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95076] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95075] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95074] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95129] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95128] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95130] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95111] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95110] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95113] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95084] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95083] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95085] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95120] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95119] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95121] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95118] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95116] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95115] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95117] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95114] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95138] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95137] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95141] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95139] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95140] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[98017] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[94508] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[94509] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[94507] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[94511] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[94510] = { factionID = 1435, reputationID = 5 }
  MerfinPlus.FactionSourceDB[95146] = { factionID = 1435, reputationID = 4 }
  MerfinPlus.FactionSourceDB[95143] = { factionID = 1435, reputationID = 4 }
  MerfinPlus.FactionSourceDB[95145] = { factionID = 1435, reputationID = 4 }
  MerfinPlus.FactionSourceDB[95142] = { factionID = 1435, reputationID = 4 }
  MerfinPlus.FactionSourceDB[95144] = { factionID = 1435, reputationID = 4 }
end
