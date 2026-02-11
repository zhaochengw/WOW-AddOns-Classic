-- Merfin Item Source Resolver (Core - MoP, Wrath-style)
--
-- Public API:
--   Merfin.GetItemDropString(itemID) -> string
--
-- Data expectations (Wrath-compatible):
--   Merfin.ItemSourceDB        : [itemID] = { { instance = "...", boss = "..." }, ... }
--   Merfin.FactionSourceDB     : [itemID] = { factionID = <number>, reputation = <4..8> }  (Wrath)
--                               or { factionID = <number>, reputationID = <4..8> }        (MoP)
--   Merfin.ItemToSet           : [itemID] = setID                           (optional)
--   Merfin.SetTierBySetID      : [setID] = tierKey ("T14", "T15", ...)      (optional)
--   Merfin.TierTokenItems      : [tierKey][slotKey] = { tokenItemIDs... }   (optional)
--   Merfin.TierTokenByItemID   : [itemID] = tokenItemID OR { tokenIDs... }  (optional)
--   Merfin.TierSourceOverrideByTier[tierKey][slotKey] = { {instance=.., boss=..}, ... } (optional)
--
-- Optional vendor / profession (only shown if your MoP build has them):
--   Merfin.VendorPrices        : [itemID] = "priceKey:amount:priceKey:amount..."
--   Merfin.VendorPriceKeyInfo  : [priceKey] = { name="", abbr="", color="RRGGBB" }
--   Merfin.ProfessionCraft     : [itemID] = { profID1, profID2, ... }
--   Merfin.ProfessionInfo      : [profID] = { abbr="", color="RRGGBB" }
--
-- Optional display mapping (recommended for MoP keys like "TempleOfTheJadeSerpent"):
--   Merfin.InstanceNameByKey   : [instanceKey] = "Temple of the Jade Serpent"
--   Merfin.BossNameByKey       : [bossKey]     = "Wise Mari"

local MerfinPlus = select(2, ...)

_G.Merfin = _G.Merfin or {}
local Merfin = _G.Merfin

--------------------------------------------------
-- Formatting helpers
--------------------------------------------------

--[[local function ColorizeTag(tag)
  if tag == "MC" then
    return "|cffff7a00MC|r"
  end

  if tag == "WB" then
    return "|cff00b7ffWB|r"
  end

  if tag == "VND" then
    return "|cff66cc33Vendor|r"
  end

  if tag == "CRF" then
    return "|cffffd100Craft|r"
  end

  return tag
end]]

--------------------------------------------------
-- Raid tag display (MoP)
--------------------------------------------------

local RAID_TAGS = {
  ["Throne of Thunder"] = {
    tag = "ToT",
    color = "4a6edb",
  },
  ["Mogu'shan Vaults"] = {
    tag = "MSV",
    color = "9b59b6",
  },
  ["Heart of Fear"] = {
    tag = "HoF",
    color = "c0392b",
  },
  ["Terrace of Endless Spring"] = {
    tag = "ToES",
    color = "27ae60",
  },
}

local function ColorizeSetTag()
  return "|cFFFFD100(Set)|r"
end

local function ApplyRaidTag(instanceName)
  local info = RAID_TAGS[instanceName]
  if not info then
    return instanceName
  end

  local tag = info.tag or instanceName
  if info.color then
    tag = string.format("|cff%s%s|r", info.color, tag)
  end

  return tag
end

local function NormalizeInstanceName(name)
  if not name or name == "" then
    return ""
  end
  --[[
  name = name:gsub("^P%d+%s*", "")
  name = name:gsub("^Phase%s*%d+%s*", "")

  if name == "Molten Core" or name:match("^MoltenCore%d*$") then
    return "MC"
  end

  if name == "World bosses of Vanilla" or name:match("^WorldBosses%d*$") then
    return "WB"
  end
  ]]
  return name
end

local function NormalizeBossName(name)
  if not name or name == "" then
    return ""
  end

  --[[
  local map = {
    ["Baron Geddon"] = "Baron",
    ["Golemagg the Incinerator"] = "Golemagg",
    ["Sulfuron Harbinger"] = "Sulfuron",
    ["Majordomo Executus"] = "Majordomo",
    ["Lord Kazzak"] = "Kazzak",
  }

  if map[name] then
    return map[name]
  end

  name = name:gsub("^Lord%s+", "")
  name = name:gsub("^The%s+", "")
  name = name:gsub("%s+the%s+.*$", "")
  ]]
  return name
end

local function ColorizeDifficulty(diff)
  if not diff then
    return nil
  end
  if diff == "H" or diff == "HC" or diff == "Heroic" then
    return "|cffff4040(H)|r"
  end
  if diff == "N" or diff == "NM" or diff == "Normal" then
    return "|cff40ff40(N)|r"
  end
  if diff == "C" or diff == "CELESTIAL" or diff == "Celestrial" then
    return "|cff80cfff(C)|r"
  end
  return diff
end

local function ResolvePrettyInstance(raw)
  if not raw or raw == "" then
    return ""
  end
  local map = MerfinPlus.InstanceNameByKey
  return (map and map[raw]) or raw
end

local function ResolvePrettyBoss(raw)
  if not raw or raw == "" then
    return ""
  end
  local map = MerfinPlus.BossNameByKey
  return (map and map[raw]) or raw
end

local function ResolveInstanceName(src)
  if src.instanceEJ and EJ_GetInstanceInfo then
    local name = EJ_GetInstanceInfo(src.instanceEJ)
    if name then
      return name
    end
  end
  if src.instance then
    return ResolvePrettyInstance(src.instance)
  end
  return ""
end

local function ResolveBossName(src)
  if src.bossEJ and EJ_GetEncounterInfo then
    local name = EJ_GetEncounterInfo(src.bossEJ)
    if name then
      return name
    end
  end
  if src.boss then
    return ResolvePrettyBoss(src.boss)
  end
  return ""
end

local function ResolveSpecialKey(src, field, key)
  local value = src and src[field]
  return type(value) == "string" and value:lower():find(key, 1, true) ~= nil
end

local function ResolveShared(src)
  return ResolveSpecialKey(src, "bossKey", "shared")
end

local function ResolveTrash(src)
  return ResolveSpecialKey(src, "bossKey", "trash")
end

local function ResolveWorldBoss(src)
  return ResolveSpecialKey(src, "instanceKey", "worldboss")
end

local function FormatSourcesGrouped(sources, maxEntries)
  if not sources or #sources == 0 then
    return ""
  end

  local hasShared = false
  local sharedDiff = nil
  local hasTrash = false
  local hasWorldBoss = false

  local grouped = {}
  local order = {}
  local hasSet = false

  for i = 1, #sources do
    local s = sources[i]

    if ResolveShared(s) then
      hasShared = true
      if not sharedDiff then
        sharedDiff = s.difficulty
      end
    elseif ResolveTrash(s) then
      hasTrash = true
    elseif ResolveWorldBoss(s) then
      hasWorldBoss = true
    end
    if s.isSet then
      hasSet = true
    end
    local inst = NormalizeInstanceName(ResolveInstanceName(s))
    local boss = NormalizeBossName(ResolveBossName(s))
    local diff = s.difficulty

    if inst ~= "" and boss ~= "" then
      local bucket = grouped[inst]
      if not bucket then
        bucket = { bosses = {}, seen = {} }
        grouped[inst] = bucket
        order[#order + 1] = inst
      end

      local label = boss
      if diff then
        label = string.format("%s %s", boss, ColorizeDifficulty(diff))
      end

      if not bucket.seen[label] then
        bucket.seen[label] = true
        bucket.bosses[#bucket.bosses + 1] = label
      end
    end
  end

  if hasShared then
    local inst = NormalizeInstanceName(ResolveInstanceName(sources[1]))
    if inst ~= "" then
      local instLabel = ApplyRaidTag(inst)
      local diff = ""
      if sharedDiff then
        diff = string.format(" %s", ColorizeDifficulty(sharedDiff))
      end
      return string.format("%s: Shared Boss Loot%s", instLabel, diff)
    end
    return "Shared Boss Loot"
  elseif hasTrash then
    local inst = NormalizeInstanceName(ResolveInstanceName(sources[1]))
    if inst ~= "" then
      local instLabel = ApplyRaidTag(inst)
      return string.format("%s: Trash Loot", instLabel)
    end
    return "Trash"
  elseif hasWorldBoss then
    local boss = ResolveBossName(sources[1])
    if boss ~= "" then
      return string.format("|cff00b7ffWB|r: %s", boss)
    end
    return "|cff00b7ffWB|r Unknown World Boss"
  end

  if #order == 0 then
    return ""
  end

  local parts = {}

  for i = 1, #order do
    local inst = order[i]
    local bucket = grouped[inst]

    if bucket and #bucket.bosses > 0 then
      local instLabel = ApplyRaidTag(inst)
      if hasSet then
        instLabel = string.format("%s %s", instLabel, ColorizeSetTag())
      end

      parts[#parts + 1] = string.format("%s: %s", instLabel, table.concat(bucket.bosses, ", "))
    end
  end

  return table.concat(parts, " | ")
end

local function GetEquipSlotKeyCandidates(itemID)
  if not itemID or itemID == 0 then
    return nil
  end

  local equipLoc
  if GetItemInfoInstant then
    local _, _, _, loc = GetItemInfoInstant(itemID)
    equipLoc = loc
  end

  if not equipLoc or equipLoc == "" then
    return nil
  end

  -- Canonical slot
  local canonical = {
    INVTYPE_HEAD = "HEAD",
    INVTYPE_SHOULDER = "SHOULDER",
    INVTYPE_CHEST = "CHEST",
    INVTYPE_ROBE = "CHEST",
    INVTYPE_HAND = "HANDS",
    INVTYPE_LEGS = "LEGS",
  }

  local base = canonical[equipLoc]
  if not base then
    return nil
  end

  -- ALL known MoP variants
  local variants = {
    HEAD = {
      "HEAD",
      "Head",
      "Helm",
      "Helmet",
    },
    SHOULDER = {
      "SHOULDER",
      "Shoulder",
      "Shoulders",
    },
    CHEST = {
      "CHEST",
      "Chest",
      "Robe",
      "Tunic",
    },
    HANDS = {
      "HANDS",
      "Hands",
      "Gloves",
      "Gauntlets",
    },
    LEGS = {
      "LEGS",
      "Legs",
      "Leggings",
      "Pants",
    },
  }

  return variants[base]
end

-- FIX: T15 Throne of Thunder Set Items
local SLOT_TO_EJ_BOSS = {
  INVTYPE_HEAD = 829, -- Twin
  INVTYPE_SHOULDER = 817, -- Iron Qon
  INVTYPE_CHEST = 824, -- Dark Animus
  INVTYPE_ROBE = 824, -- Dark Animus
  INVTYPE_HAND = 816, -- Council of Elders
  INVTYPE_LEGS = 828, -- Ji-kun
}

local function ResolveTierTokenSources(itemID)
  local itemToTier = MerfinPlus.ItemToTier
  local tierTokens = MerfinPlus.TierTokenItems
  local sourceDB = MerfinPlus.ItemSourceDB

  if not itemToTier or not tierTokens or not sourceDB then
    return nil
  end

  local tierKey = itemToTier[itemID]
  if not tierKey then
    return nil
  end

  -- FIX: T15 Throne of Thunder Set Items
  if tierKey == "T15" then
    local equipLoc = select(4, GetItemInfoInstant(itemID))
    local bossEJ = equipLoc and SLOT_TO_EJ_BOSS[equipLoc]
    if bossEJ then
      return {
        {
          instanceEJ = 362, -- ToT
          bossEJ = bossEJ,
          isSet = true,
        },
      }
    end
  end

  local slotKeys = GetEquipSlotKeyCandidates(itemID)
  if not slotKeys then
    return nil
  end

  local out = {}

  local function CloneSourceAsSet(src)
    if type(src) ~= "table" then
      return { isSet = true }
    end

    local t = {}
    for k, v in pairs(src) do
      t[k] = v
    end
    t.isSet = true
    return t
  end

  local tokenByItem = MerfinPlus.TierTokenByItemID
  local tokenList = tokenByItem and tokenByItem[itemID]
  if tokenList then
    if type(tokenList) ~= "table" then
      tokenList = { tokenList }
    end

    for i = 1, #tokenList do
      local tokenID = tokenList[i]
      local src = sourceDB[tokenID]
      if src and #src > 0 then
        for j = 1, #src do
          out[#out + 1] = CloneSourceAsSet(src[j])
        end
      end
    end
  end

  if #out == 0 and tierTokens[tierKey] then
    for i = 1, #slotKeys do
      local list = tierTokens[tierKey][slotKeys[i]]
      if list and #list > 0 then
        for j = 1, #list do
          local tokenID = list[j]
          local src = sourceDB[tokenID]
          if src and #src > 0 then
            for k = 1, #src do
              out[#out + 1] = CloneSourceAsSet(src[k])
            end
          end
        end
        break
      end
    end
  end

  if #out == 0 then
    return nil
  end

  return out
end

--------------------------------------------------
-- Vendor formatter (optional)
--------------------------------------------------
--[[
local function ParseVendorPriceString(priceStr)
  if not priceStr or priceStr == "" then
    return nil
  end

  local out = {}
  for key, amount in priceStr:gmatch("([^:]+):(%d+)") do
    out[#out + 1] = { key = key, amount = tonumber(amount) or 0 }
  end

  return out
end

local function FormatVendorSource(itemID)
  local prices = MerfinPlus.VendorPrices
  if not prices then
    return ""
  end

  local priceStr = prices[itemID]
  if not priceStr then
    return ""
  end

  local parsed = ParseVendorPriceString(priceStr)
  if not parsed or #parsed == 0 then
    return ""
  end

  local keyInfo = MerfinPlus.VendorPriceKeyInfo or {}
  local parts = {}

  for i = 1, #parsed do
    local p = parsed[i]
    local info = keyInfo[p.key]
    local name = (info and info.name) or p.key
    local abbr = (info and info.abbr) or name
    local color = (info and info.color) or nil

    local piece
    if p.key == "money" then
      if GetCoinTextureString then
        piece = GetCoinTextureString(p.amount)
      else
        local gold = math.floor(p.amount / 10000)
        local silver = math.floor((p.amount % 10000) / 100)
        local copper = p.amount % 100
        piece = string.format("%dg %ds %dc", gold, silver, copper)
      end
    else
      piece = string.format("%s x%d", abbr, p.amount)
    end

    if color then
      piece = string.format("|cff%s%s|r", color, piece)
    end

    parts[#parts + 1] = piece
  end

  local tag = ColorizeTag("VND")
  return string.format("%s: %s", tag, table.concat(parts, ", "))
end]]

--------------------------------------------------
-- Profession formatter (optional)
--------------------------------------------------

--[[local function FormatProfessionSource(itemID)
  local craft = MerfinPlus.ProfessionCraft
  if not craft then
    return ""
  end

  local profIDs = craft[itemID]
  if not profIDs or #profIDs == 0 then
    return ""
  end

  local profInfo = MerfinPlus.ProfessionInfo or {}
  local parts = {}

  for i = 1, #profIDs do
    local id = profIDs[i]
    local info = profInfo[id]
    local abbr = (info and info.abbr) or tostring(id)
    local color = (info and info.color) or nil
    local piece = abbr
    if color then
      piece = string.format("|cff%s%s|r", color, piece)
    end
    parts[#parts + 1] = piece
  end

  local tag = ColorizeTag("CRF")
  return string.format("%s: %s", tag, table.concat(parts, ", "))
end]]

--------------------------------------------------
-- PUBLIC API
--------------------------------------------------

function Merfin.GetItemDropString(itemID)
  if type(itemID) ~= "number" then
    return ""
  end

  local sourceDB = MerfinPlus.ItemSourceDB or {}

  local sharedBaseID = nil
  local isForged = false

  sourceDB = sourceDB[itemID]
  if sourceDB then
    for i = 1, #sourceDB do
      local src = sourceDB[i]

      if src.sharedBase then
        sharedBaseID = src.sharedBase
      end

      if src.type == true then
        isForged = true
      end
    end
  end

  local sources = ResolveTierTokenSources(itemID)
  if not sources or #sources == 0 then
    local src = sourceDB
    if src then
      sources = {}
      for i = 1, #src do
        sources[#sources + 1] = src[i]
      end
    end
  end

  local faction = MerfinPlus.FactionSourceDB and MerfinPlus.FactionSourceDB[itemID]
  if faction then
    local factionName = GetFactionInfoByID and GetFactionInfoByID(faction.factionID) or nil
    local repKey = faction.reputation or faction.reputationID
    local repName = (MerfinPlus.REPUTATION_NAMES and MerfinPlus.REPUTATION_NAMES[repKey]) or "Unknown"
    if factionName then
      return string.format("%s (%s)", factionName, repName)
    end
  end

  local outParts = {}

  local lootText = ""
  if sources and #sources > 0 then
    lootText = FormatSourcesGrouped(sources, 50)
    if lootText ~= "" then
      outParts[#outParts + 1] = lootText
    end
  end

  if #outParts == 0 then
    return ""
  end

  local meta
  if sharedBaseID then
    meta = { sharedBaseID, isForged }
  end

  return table.concat(outParts, " | "), meta
end
