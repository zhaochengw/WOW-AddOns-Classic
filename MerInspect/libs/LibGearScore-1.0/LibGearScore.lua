-----------------------------------------------------------------------------------------------------------------------
-- Usage
-- 1.  Get a reference to the library
--     local LibGearScore = LibStub:GetLibrary("LibGearScore.1000",true)
-- 2.  Call the LibGearScore:GetScore(unit_or_guid) method passing a unitid or unitguid to get a player's
--     gearscore data. Player has to have been inspected sometime during the play
--     session. History of gearscores is not retained past the session by this library.
--     If you need data retention it would have to be implemented downstream by your addon.
--  2a.local guid, gearScore = LibGearScore:GetScore("player")
--     'gearScore' table members:
--     {
--       TimeStamp = TimeStamp, -- YYYYMMDDhhmmss (eg. 20221025134532) for easy string sortable comparisons
--       PlayerName = PlayerName,
--       PlayerRealm = PlayerRealm, -- Normalized Realm Name
--       GearScore = GearScore, -- Number
--       AvgItemLevel = AvgItemLevel, -- Number
--       RawTime = RawTime, -- nilable: unixtime (can feed to date(fmt,RawTime) to get back human readable datetime)
--       Color = color, -- nilable: ColorMixin
--       Description = description -- nilable: String
--     }
--     PlayerName / PlayerRealm == _G.UKNOWNOBJECT or GearScore = 0 indicates failure to calculate
-- 3.  LibGearScore:GetItemScore(item) method passing itemid, itemstring or itemlink to get the ItemScore
--     of a single item.
--  3a.local itemID, itemScore = LibGearScore:GetItemScore(item)
--     'itemScore' table members:
--     {
--       ItemScore=ItemScore, -- Number
--       ItemLevel=ItemLevel, -- Number
--       Red=Red, -- 0-1
--       Green=Green, -- 0-1
--       Blue=Blue, -- 0-1
--       Description=Description, -- String
--     }
--     Description == _G.UNKNOWNOBJECT indicates invalid item, Description == _G.PENDING_INVITE indicates uncached item
-- 4.  Callbacks: "LibGearScore_Update", "LibGearScore_ItemScore", "LibGearScore_ItemPending"
--  4a.LibGearScore.RegisterCallback(addon, "LibGearScore_Update")
--     function addon:LibGearScore_Update(guid, gearScore) -- see (2a) for `gearScore` members
--       -- do something with gearScore for player guid
--     end
--     LibGearScore.RegisterCallback(addon, "LibGearScore_ItemScore")
--     function addon:LibGearScore_ItemScore(itemid, itemScore) -- see (3a) for `itemScore` members
--       -- do something with itemScore for itemid
--     end
--     LibGearScore.RegisterCallback(addon, "LibGearScore_ItemPending")
--     function addon:LibGearScore_ItemPending(itemid)
--       -- can for example monitor for the LibGearScore_ItemScore callback to have final item data
--     end
--
-- Notes
--     LibGearScore-1.0 does NOT initiate Inspects, it only passively monitors inspect results.
-----------------------------------------------------------------------------------------------------------------------

local MAJOR, MINOR = "LibGearScore.1000", 3
assert(LibStub, format("%s requires LibStub.", MAJOR))
local lib, oldMinor = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end

local GUIDIsPlayer = _G.C_PlayerInfo.GUIDIsPlayer
local GetPlayerInfoByGUID = _G.GetPlayerInfoByGUID
local GetNormalizedRealmName = _G.GetNormalizedRealmName
local GetItemInfoInstant = _G.GetItemInfoInstant
local CanInspect = _G.CanInspect
local CheckInteractDistance = _G.CheckInteractDistance
local UnitIsVisible = _G.UnitIsVisible
local GetServerTime = _G.GetServerTime
local UnitGUID = _G.UnitGUID
local UnitIsPlayer = _G.UnitIsPlayer
local Item = _G.Item
local After = _G.C_Timer.After
local CreateColor = _G.CreateColor
local floor = _G.math.floor
local max = _G.math.max
local ScanTip = _G["LibGearScoreScanTooltip.1000"] or CreateFrame("GameTooltip", "LibGearScoreScanTooltip.1000", UIParent, "GameTooltipTemplate")
lib.callbacks = lib.callbacks or LibStub:GetLibrary("CallbackHandler-1.0"):New(lib)

local BRACKET_SIZE = 1000

if WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
  BRACKET_SIZE = 1000
elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
  BRACKET_SIZE = 400
elseif WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
  BRACKET_SIZE = 200
end

local MAX_SCORE = BRACKET_SIZE*6-1

local GS_ItemSlots = {
  _G.INVSLOT_HEAD,
  _G.INVSLOT_NECK,
  _G.INVSLOT_SHOULDER,
  _G.INVSLOT_CHEST,
  _G.INVSLOT_WAIST,
  _G.INVSLOT_LEGS,
  _G.INVSLOT_FEET,
  _G.INVSLOT_WRIST,
  _G.INVSLOT_HAND,
  _G.INVSLOT_FINGER1,
  _G.INVSLOT_FINGER2,
  _G.INVSLOT_TRINKET1,
  _G.INVSLOT_TRINKET2,
  _G.INVSLOT_BACK,
  _G.INVSLOT_MAINHAND,
--  _G.INVSLOT_OFFHAND, -- handled separately
  _G.INVSLOT_RANGED,
}

local GS_ItemTypes = {
  ["INVTYPE_RELIC"] = { ["SlotMOD"] = 0.3164, ["ItemSlot"] = 18, ["Enchantable"] = false},
  ["INVTYPE_TRINKET"] = { ["SlotMOD"] = 0.5625, ["ItemSlot"] = 33, ["Enchantable"] = false },
  ["INVTYPE_2HWEAPON"] = { ["SlotMOD"] = 2.000, ["ItemSlot"] = 16, ["Enchantable"] = true },
  ["INVTYPE_WEAPONMAINHAND"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 16, ["Enchantable"] = true },
  ["INVTYPE_WEAPONOFFHAND"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 17, ["Enchantable"] = true },
  ["INVTYPE_RANGED"] = { ["SlotMOD"] = 0.3164, ["ItemSlot"] = 18, ["Enchantable"] = true },
  ["INVTYPE_THROWN"] = { ["SlotMOD"] = 0.3164, ["ItemSlot"] = 18, ["Enchantable"] = false },
  ["INVTYPE_RANGEDRIGHT"] = { ["SlotMOD"] = 0.3164, ["ItemSlot"] = 18, ["Enchantable"] = false },
  ["INVTYPE_SHIELD"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 17, ["Enchantable"] = true },
  ["INVTYPE_WEAPON"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 36, ["Enchantable"] = true },
  ["INVTYPE_HOLDABLE"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 17, ["Enchantable"] = false },
  ["INVTYPE_HEAD"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 1, ["Enchantable"] = true },
  ["INVTYPE_NECK"] = { ["SlotMOD"] = 0.5625, ["ItemSlot"] = 2, ["Enchantable"] = false },
  ["INVTYPE_SHOULDER"] = { ["SlotMOD"] = 0.7500, ["ItemSlot"] = 3, ["Enchantable"] = true },
  ["INVTYPE_CHEST"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 5, ["Enchantable"] = true },
  ["INVTYPE_ROBE"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 5, ["Enchantable"] = true },
  ["INVTYPE_WAIST"] = { ["SlotMOD"] = 0.7500, ["ItemSlot"] = 6, ["Enchantable"] = false },
  ["INVTYPE_LEGS"] = { ["SlotMOD"] = 1.0000, ["ItemSlot"] = 7, ["Enchantable"] = true },
  ["INVTYPE_FEET"] = { ["SlotMOD"] = 0.75, ["ItemSlot"] = 8, ["Enchantable"] = true },
  ["INVTYPE_WRIST"] = { ["SlotMOD"] = 0.5625, ["ItemSlot"] = 9, ["Enchantable"] = true },
  ["INVTYPE_HAND"] = { ["SlotMOD"] = 0.7500, ["ItemSlot"] = 10, ["Enchantable"] = true },
  ["INVTYPE_FINGER"] = { ["SlotMOD"] = 0.5625, ["ItemSlot"] = 31, ["Enchantable"] = false },
  ["INVTYPE_CLOAK"] = { ["SlotMOD"] = 0.5625, ["ItemSlot"] = 15, ["Enchantable"] = true },
  ["INVTYPE_BODY"] = { ["SlotMOD"] = 0, ["ItemSlot"] = 4, ["Enchantable"] = false },
}

local GS_Rarity = {
  [0] = {Red = 0.55, Green = 0.55, Blue = 0.55 },
  [1] = {Red = 1.00, Green = 1.00, Blue = 1.00 },
  [2] = {Red = 0.12, Green = 1.00, Blue = 0.00 },
  [3] = {Red = 0.00, Green = 0.50, Blue = 1.00 },
  [4] = {Red = 0.69, Green = 0.28, Blue = 0.97 },
  [5] = {Red = 0.94, Green = 0.09, Blue = 0.00 },
  [6] = {Red = 1.00, Green = 0.00, Blue = 0.00 },
  [7] = {Red = 0.90, Green = 0.80, Blue = 0.50 },
}

local GS_Formula = {
  ["A"] = {
    [4] = { ["A"] = 91.4500, ["B"] = 0.6500 },
    [3] = { ["A"] = 81.3750, ["B"] = 0.8125 },
    [2] = { ["A"] = 73.0000, ["B"] = 1.0000 }
  },
  ["B"] = {
    [4] = { ["A"] = 26.0000, ["B"] = 1.2000 },
    [3] = { ["A"] = 0.7500, ["B"] = 1.8000 },
    [2] = { ["A"] = 8.0000, ["B"] = 2.0000 },
    [1] = { ["A"] = 0.0000, ["B"] = 2.2500 }
  }
}

local GS_Quality = {
  [BRACKET_SIZE*6] = {
    ["Red"] = { ["A"] = 0.94, ["B"] = BRACKET_SIZE*5, ["C"] = 0.00006, ["D"] = 1 },
    ["Blue"] = { ["A"] = 0.47, ["B"] = BRACKET_SIZE*5, ["C"] = 0.00047, ["D"] = -1 },
    ["Green"] = { ["A"] = 0, ["B"] = 0, ["C"] = 0, ["D"] = 0 },
    ["Description"] = _G.ITEM_QUALITY5_DESC
  },
  [BRACKET_SIZE*5] = {
    ["Red"] = { ["A"] = 0.69, ["B"] = BRACKET_SIZE*4, ["C"] = 0.00025, ["D"] = 1 },
    ["Blue"] = { ["A"] = 0.28, ["B"] = BRACKET_SIZE*4, ["C"] = 0.00019, ["D"] = 1 },
    ["Green"] = { ["A"] = 0.97, ["B"] = BRACKET_SIZE*4, ["C"] = 0.00096, ["D"] = -1 },
    ["Description"] = _G.ITEM_QUALITY4_DESC
  },
  [BRACKET_SIZE*4] = {
    ["Red"] = { ["A"] = 0.0, ["B"] = BRACKET_SIZE*3, ["C"] = 0.00069, ["D"] = 1 },
    ["Blue"] = { ["A"] = 0.5, ["B"] = BRACKET_SIZE*3, ["C"] = 0.00022, ["D"] = -1 },
    ["Green"] = { ["A"] = 1, ["B"] = BRACKET_SIZE*3, ["C"] = 0.00003, ["D"] = -1 },
    ["Description"] = _G.ITEM_QUALITY3_DESC
  },
  [BRACKET_SIZE*3] = {
    ["Red"] = { ["A"] = 0.12, ["B"] = BRACKET_SIZE*2, ["C"] = 0.00012, ["D"] = -1 },
    ["Blue"] = { ["A"] = 1, ["B"] = BRACKET_SIZE*2, ["C"] = 0.00050, ["D"] = -1 },
    ["Green"] = { ["A"] = 0, ["B"] = BRACKET_SIZE*2, ["C"] = 0.001, ["D"] = 1 },
    ["Description"] = _G.ITEM_QUALITY2_DESC
  },
  [BRACKET_SIZE*2] = {
    ["Red"] = { ["A"] = 1, ["B"] = BRACKET_SIZE, ["C"] = 0.00088, ["D"] = -1 },
    ["Blue"] = { ["A"] = 1, ["B"] = 000, ["C"] = 0.00000, ["D"] = 0 },
    ["Green"] = { ["A"] = 1, ["B"] = BRACKET_SIZE, ["C"] = 0.001, ["D"] = -1 },
    ["Description"] = _G.ITEM_QUALITY1_DESC
  },
  [BRACKET_SIZE] = {
    ["Red"] = { ["A"] = 0.55, ["B"] = 0, ["C"] = 0.00045, ["D"] = 1 },
    ["Blue"] = { ["A"] = 0.55, ["B"] = 0, ["C"] = 0.00045, ["D"] = 1 },
    ["Green"] = { ["A"] = 0.55, ["B"] = 0, ["C"] = 0.00045, ["D"] = 1 },
    ["Description"] = _G.ITEM_QUALITY0_DESC
  },
}

local function ResolveGUID(unitorguid)
  if (unitorguid) then
    if (GUIDIsPlayer(unitorguid)) then
      return unitorguid
    elseif (UnitIsPlayer(unitorguid)) then
      return UnitGUID(unitorguid)
    end
  end
  return nil
end

local function GetScoreColor(ItemScore)
  local ItemScore = tonumber(ItemScore)
  if (not ItemScore) then
    return 0, 0, 0, _G.ITEM_QUALITY0_DESC
  end

  if (ItemScore > MAX_SCORE) then
    ItemScore = MAX_SCORE
  end
  local Red = 0.1
  local Blue = 0.1
  local Green = 0.1
  for i = 0,6 do
    if ((ItemScore > i * BRACKET_SIZE) and (ItemScore <= ((i + 1) * BRACKET_SIZE))) then
      local Red = GS_Quality[( i + 1 ) * BRACKET_SIZE].Red["A"] + (((ItemScore - GS_Quality[( i + 1 ) * BRACKET_SIZE].Red["B"])*GS_Quality[( i + 1 ) * BRACKET_SIZE].Red["C"])*GS_Quality[( i + 1 ) * BRACKET_SIZE].Red["D"])
      local Blue = GS_Quality[( i + 1 ) * BRACKET_SIZE].Green["A"] + (((ItemScore - GS_Quality[( i + 1 ) * BRACKET_SIZE].Green["B"])*GS_Quality[( i + 1 ) * BRACKET_SIZE].Green["C"])*GS_Quality[( i + 1 ) * BRACKET_SIZE].Green["D"])
      local Green = GS_Quality[( i + 1 ) * BRACKET_SIZE].Blue["A"] + (((ItemScore - GS_Quality[( i + 1 ) * BRACKET_SIZE].Blue["B"])*GS_Quality[( i + 1 ) * BRACKET_SIZE].Blue["C"])*GS_Quality[( i + 1 ) * BRACKET_SIZE].Blue["D"])
      return Red, Green, Blue, GS_Quality[( i + 1 ) * BRACKET_SIZE].Description
    end
  end
  return 0.1, 0.1, 0.1, _G.ITEM_QUALITY0_DESC
end

local function ItemScoreCalc(ItemRarity, ItemLevel, ItemEquipLoc)
  local Table
  local QualityScale = 1
  local GearScore = 0
  local Scale = 1.8618
  if (ItemRarity == 5) then
    QualityScale = 1.3
    ItemRarity = 4
  elseif (ItemRarity == 1) then
    QualityScale = 0.005
    ItemRarity = 2
  elseif (ItemRarity == 0) then
    QualityScale = 0.005
    ItemRarity = 2
  elseif (ItemRarity == 7) then
    ItemRarity = 3
    ItemLevel = 187.05
  end
  if (ItemLevel > 120) then
    Table = GS_Formula["A"]
  else
    Table = GS_Formula["B"]
  end
  if ((ItemRarity >= 2) and (ItemRarity <= 4)) then
    local Red, Green, Blue, Description = GetScoreColor((floor(((ItemLevel - Table[ItemRarity].A) / Table[ItemRarity].B) * 1 * Scale)) * 11.25)
    GearScore = floor(((ItemLevel - Table[ItemRarity].A) / Table[ItemRarity].B) * GS_ItemTypes[ItemEquipLoc].SlotMOD * Scale * QualityScale)
    if (ItemLevel == 187.05) then
      ItemLevel = 0
    end
    if (GearScore < 0) then
      GearScore = 0
      Red, Green, Blue, Description = GetScoreColor(1)
    end
    return GearScore, ItemLevel, Red, Green, Blue, Description
  end
end

lib.ItemScoreData = setmetatable({},{__index = function(cache, item)
  local itemID, _, _, ItemEquipLoc = GetItemInfoInstant(item)
  if not itemID then return {ItemScore=0, ItemLevel=0, Red=0.1, Green=0.1, Blue=0.1, Description=_G.UNKNOWNOBJECT} end
  if not GS_ItemTypes[ItemEquipLoc] then return {ItemScore=0, ItemLevel=0, Red=0.1, Green=0.1, Blue=0.1, Description=_G.UNKNOWNOBJECT} end
  local itemAsync = Item:CreateFromItemID(itemID)
  if itemAsync:IsItemDataCached() then
    local ItemLink = itemAsync:GetItemLink()
    local ItemRarity = itemAsync:GetItemQuality()
    local ItemLevel = itemAsync:GetCurrentItemLevel()
    local ItemScore, ItemLevel, Red, Green, Blue, Description = ItemScoreCalc(ItemRarity, ItemLevel, ItemEquipLoc)
    local scoreData = {ItemScore=ItemScore,ItemLevel=ItemLevel,Red=Red,Green=Green,Blue=Blue,Description=Description}
    rawset(cache, item, scoreData)
    rawset(cache, ItemLink, scoreData)
    rawset(cache, itemID, scoreData)
    lib.callbacks:Fire("LibGearScore_ItemScore", itemID, scoreData)
    return cache[item]
  else
    itemAsync:ContinueOnItemLoad(function()
      local ItemLink = itemAsync:GetItemLink()
      local ItemRarity = itemAsync:GetItemQuality()
      local ItemLevel = itemAsync:GetCurrentItemLevel()
      local ItemScore, ItemLevel, Red, Green, Blue, Description = ItemScoreCalc(ItemRarity, ItemLevel, ItemEquipLoc)
      local scoreData = {ItemScore=ItemScore,ItemLevel=ItemLevel,Red=Red,Green=Green,Blue=Blue,Description=Description}
      rawset(cache, item, scoreData)
      rawset(cache, ItemLink, scoreData)
      rawset(cache, itemID, scoreData)
      lib.callbacks:Fire("LibGearScore_ItemPending", itemID)
    end)
    return {ItemScore=0, ItemLevel=0, Red=0.1, Green=0.1, Blue=0.1, Description=_G.PENDING_INVITE}
  end
end})

local function GetUnitSlotLink(unit, slot)
  ScanTip:SetOwner(UIParent, "ANCHOR_NONE")
  ScanTip:SetInventoryItem(unit, slot)
  return GetInventoryItemLink(unit, slot) or select(2, ScanTip:GetItem())
end

local function CacheScore(guid, unit)
  local _, enClass, _, _, _, PlayerName, PlayerRealm = GetPlayerInfoByGUID(guid)
  if not PlayerName or PlayerName == _G.UNKNOWNOBJECT then return end
  if PlayerRealm == "" then PlayerRealm = GetNormalizedRealmName() end
  local GearScore = 0
  local ItemCount = 0
  local LevelTotal = 0
  local TitanGrip = 1
  local ItemScore = 0
  local ItemLevel = 0
  local AvgItemLevel = 0
  local Description
  local mainHandLink = GetUnitSlotLink(unit, _G.INVSLOT_MAINHAND)
  local offHandLink = GetUnitSlotLink(unit, _G.INVSLOT_OFFHAND)
  if mainHandLink and offHandLink then
    local itemID, _, _, ItemEquipLoc = GetItemInfoInstant(mainHandLink)
    if ItemEquipLoc == "INVTYPE_2HWEAPON" then
      TitanGrip = 0.5
    end
  end
  if offHandLink then
    local itemID, _, _, ItemEquipLoc = GetItemInfoInstant(offHandLink)
    if ItemEquipLoc == "INVTYPE_2HWEAPON" then
      TitanGrip = 0.5
    end
    local _, scoreData = lib:GetItemScore(offHandLink)
    ItemScore, ItemLevel, Description = scoreData.ItemScore, scoreData.ItemLevel, scoreData.Description
    if Description == _G.UNKNOWNOBJECT then return end
    if Description == _G.PENDING_INVITE then
      After(0.1, function()
        CacheScore(guid, unit)
        return
      end)
    end
    if enClass == "HUNTER" then
      ItemScore = ItemScore * 0.3164
    end
    GearScore = GearScore + ItemScore * TitanGrip
    ItemCount = ItemCount + 1
    LevelTotal = LevelTotal + ItemLevel
  end
  for _, slot in ipairs(GS_ItemSlots) do
    local slotLink = GetUnitSlotLink(unit, slot)
    if slotLink then
      local _, scoreData = lib:GetItemScore(slotLink)
      ItemScore, ItemLevel, Description = scoreData.ItemScore, scoreData.ItemLevel, scoreData.Description
      if Description == _G.UNKNOWNOBJECT then return end
      if Description == _G.PENDING_INVITE then
        After(0.1, function()
          CacheScore(guid, unit)
          return
        end)
      end
      if enClass == "HUNTER" then
        if slot == _G.INVSLOT_MAINHAND then
          ItemScore = ItemScore * 0.3164
        elseif slot == _G.INVSLOT_RANGED then
          ItemScore = ItemScore * 5.3224
        end
      end
      if slot == _G.INVSLOT_MAINHAND then
        ItemScore = ItemScore * TitanGrip
      end
      GearScore = GearScore + ItemScore
      ItemCount = ItemCount + 1
      LevelTotal = LevelTotal + ItemLevel
    end
  end
  if GearScore > 0 and ItemCount > 0 then
    GearScore = floor(GearScore)
    AvgItemLevel = floor(LevelTotal/ItemCount)
    local RawTime = GetServerTime()
    local TimeStamp = date("%Y%m%d%H%M%S",RawTime) -- 20221017133545 (YYYYMMDDHHMMSS)
    local r,g,b, description = GetScoreColor(GearScore)
    local color = CreateColor(r,g,b,1)
    local scoreData = {TimeStamp = TimeStamp, PlayerName = PlayerName, PlayerRealm = PlayerRealm, GearScore = GearScore, AvgItemLevel = AvgItemLevel, RawTime = RawTime, Color = color, Description = description}
    lib.PlayerScoreData[guid] = scoreData
    lib.callbacks:Fire("LibGearScore_Update", guid, scoreData)
  end
end

lib.PlayerScoreData = setmetatable({},{__index = function(cache, guid)
  return {PlayerName = _G.UNKNOWNOBJECT, PlayerRealm = _G.UNKNOWNOBJECT, GearScore = 0, AvgItemLevel = 0}
end})

--------------
--- Events ---
--------------
lib.eventFrame = lib.eventFrame or CreateFrame("Frame")
lib.eventFrame:UnregisterAllEvents()
lib.eventFrame:SetScript("OnEvent",nil)
lib.eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
lib.eventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
lib.eventFrame:RegisterEvent("UNIT_INVENTORY_CHANGED")
lib.eventFrame:RegisterEvent("INSPECT_READY")
lib.OnEvent = function(_,event,...)
  return lib[event] and lib[event](lib,event,...)
end
lib.eventFrame:SetScript("OnEvent",lib.OnEvent)
function lib:PLAYER_EQUIPMENT_CHANGED(event,...)
  local guid, unit = UnitGUID("player"), "player"
  CacheScore(guid,unit)
end
function lib:UNIT_INVENTORY_CHANGED(event,...)
  local unit = ...
  if unit and UnitIsPlayer(unit) then
    local guid = UnitGUID(unit)
    if lib.inspecting and lib.inspecting.guid == guid then
      CacheScore(guid, unit)
    end
  end
end
function lib:INSPECT_READY(event,...)
  local guid = ...
  if self.inspecting and self.inspecting.guid == guid then
    if self.inspecting.unit and UnitIsVisible(self.inspecting.unit) then
      if CanInspect(self.inspecting.unit,false) and CheckInteractDistance(self.inspecting.unit,1) then
        CacheScore(self.inspecting.guid, self.inspecting.unit)
      end
    end
  end
end
function lib:PLAYER_ENTERING_WORLD(event,...)
  local guid = UnitGUID("player")
  CacheScore(guid, "player")
end
function lib.NotifyInspect(unit)
  if unit and UnitIsPlayer(unit) then
    local guid = UnitGUID(unit)
    lib.inspecting = {guid=guid,unit=unit}
  end
end
function lib.ClearInspectPlayer()
  lib.inspecting = false
end
hooksecurefunc("NotifyInspect",lib.NotifyInspect)
hooksecurefunc("ClearInspectPlayer",lib.ClearInspectPlayer)

------------------
--- Public API ---
------------------
function lib:GetItemScore(item)
  local itemID = GetItemInfoInstant(item)
  if itemID then
    return itemID, lib.ItemScoreData[item]
  end
end

function lib:GetScore(unitorguid)
  local guid = ResolveGUID(unitorguid)
  if (guid) then
    return guid, lib.PlayerScoreData[guid]
  end
end

function lib:GetScoreColor(score)
  local r,g,b, desc = GetScoreColor(score)
  local colorObj = CreateColor(r,g,b)
  return colorObj, desc
end
---------------
--- Testing ---
---------------
local function TargetScore()
  if UnitExists("target")
    and UnitIsPlayer("target")
    and UnitIsFriend("target","player") then
    local guid, scoreData = lib:GetScore("target")
    if scoreData then
      if scoreData.PlayerName == _G.UNKNOWNOBJECT then
        print(format("No GearScore available for '%s'. Try inspecting first.",(UnitName("target"))))
      else
        print(format("%s's GS: ",scoreData.PlayerName)..scoreData.Color:WrapTextInColorCode(scoreData.GearScore))
      end
    else
      print(format("No GearScore data available for '%s'. Try inspecting first.",(UnitName("target"))))
    end
  else
    print(format("Can't get GearScore information for that target:%s",(UnitName("target")) or _G.TARGET_TOKEN_NOT_FOUND))
  end
end
SLASH_LibGearScore1 = "/lib_gs"
_G.SlashCmdList["LibGearScore"] = TargetScore
