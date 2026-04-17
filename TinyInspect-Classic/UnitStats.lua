--[[
  TinyInspect Classic - Unit Stats (Patch)
  Adds a draggable stats window (Main + Secondary) that:
    - Auto-opens on inspecting a unit (target change)
    - Shows your own real stats (incl. %) when unit == "player"
    - Shows inspected unit's stats by summing item stats (ratings/amounts) when unit ~= "player"
  English comments, client-dependent locale (enUS/deDE inline).
  Author: Domekologe
  No new SavedVariables: uses TinyInspectClassicDB.UnitStats
]]

local ADDON_NAME = ...
local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local LibItemInfo = LibStub:GetLibrary("LibItemInfo.7000")
----------------------------------------------------------------
-- Localization (inline for patch)
----------------------------------------------------------------
local LOCALES = {
  enUS = {
    ADDON_TITLE="TinyInspect - Unit Stats",
    HEADER_MAIN="Main Stats",
    HEADER_SEC="Secondary Stats",
    STRENGTH="Strength", AGILITY="Agility", STAMINA="Stamina", INTELLECT="Intellect",
    HASTE="Haste", CRIT="Critical Strike", MASTERY="Mastery",
    HIT_MELEE="Hit (Melee)", HIT_RANGED="Hit (Ranged)", HIT_SPELL="Hit (Spell)",
    EXPERTISE="Expertise", DODGE="Dodge", PARRY="Parry",
    BTN_LOCK="Lock", BTN_UNLOCK="Unlock", HINT_DRAG="Drag by header",
    NOTE_SELF="Values shown for your character.",
    NOTE_OTHER="Values summed from inspected gear.",
    LABEL_UNIT="Unit:",
    SLASH_TOGGLE="Toggle stats window",
  },
  deDE = {
    ADDON_TITLE="TinyInspect - Einheitenwerte",
    HEADER_MAIN="Hauptwerte",
    HEADER_SEC="Sekundärwerte",
    STRENGTH="Stärke", AGILITY="Beweglichkeit", STAMINA="Ausdauer", INTELLECT="Intelligenz",
    HASTE="Tempo", CRIT="Kritische Treffer", MASTERY="Meisterschaft",
    HIT_MELEE="Trefferwertung (Nahkampf)", HIT_RANGED="Trefferwertung (Fernkampf)", HIT_SPELL="Trefferwertung (Zauber)",
    EXPERTISE="Waffenkunde", DODGE="Ausweichen", PARRY="Parieren",
    BTN_LOCK="Sperren", BTN_UNLOCK="Entsperren", HINT_DRAG="Am Kopf ziehen",
    NOTE_SELF="Werte werden für deinen Charakter angezeigt.",
    NOTE_OTHER="Werte aus der inspizierten Ausrüstung summiert.",
    LABEL_UNIT="Einheit:",
    SLASH_TOGGLE="Fenster umschalten",
  }
}
local L = setmetatable(LOCALES[GetLocale()] or LOCALES.enUS, { __index = LOCALES.enUS })

----------------------------------------------------------------
-- DB inside TinyInspectClassicDB (no new SavedVariables)
----------------------------------------------------------------
local function DB()
  _G.TinyInspectClassicDB = _G.TinyInspectClassicDB or {}
  local db = _G.TinyInspectClassicDB
  db.UnitStats = db.UnitStats or {
    locked=false, shown=false,
    point={"CENTER", UIParent, "CENTER", 0, 0},
  }
  return db.UnitStats
end

local LibWindow = _G.LibStub and _G.LibStub("LibWindow-1.1", true)

----------------------------------------------------------------
-- UI
----------------------------------------------------------------
local frame = CreateFrame("Frame", "TI_UnitStatsFrame", UIParent, "BackdropTemplate")
frame:SetSize(290, 360)
frame:SetFrameStrata("HIGH")
frame:SetClampedToScreen(true)
frame:Hide()
frame:SetBackdrop({
  bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",
  edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
  tile=true, tileSize=16, edgeSize=12,
  insets={left=3,right=3,top=3,bottom=3}
})
frame:SetMovable(true)
frame:SetUserPlaced(true)

-- Header
local header = CreateFrame("Frame", nil, frame, "BackdropTemplate")
header:SetPoint("TOPLEFT", 6, -6)
header:SetPoint("TOPRIGHT", -6, -6)
header:SetHeight(28)
header:SetBackdrop({ bgFile="Interface\\Buttons\\WHITE8x8" })
header:SetBackdropColor(0.1,0.1,0.1,0.85)

local title = header:CreateFontString(nil, "OVERLAY", "GameFontNormal")
title:SetPoint("LEFT", header, "LEFT", 8, 0)
title:SetText(L.ADDON_TITLE .. " |cffa0a0a0("..L.HINT_DRAG..")|r")

local close = CreateFrame("Button", nil, header, "UIPanelCloseButton")
close:SetPoint("RIGHT", header, "RIGHT", 0, 0)
close:SetScript("OnClick", function() frame:Hide(); DB().shown=false end)

local lockBtn = CreateFrame("Button", nil, header, "UIPanelButtonTemplate")
lockBtn:SetSize(70, 20)
lockBtn:SetPoint("RIGHT", close, "LEFT", -4, 0)
local function UpdateLock() lockBtn:SetText(DB().locked and L.BTN_UNLOCK or L.BTN_LOCK) end
lockBtn:SetScript("OnClick", function() DB().locked = not DB().locked; UpdateLock() end)
UpdateLock()

header:EnableMouse(true)
header:RegisterForDrag("LeftButton")
header:SetScript("OnDragStart", function() if not DB().locked then frame:StartMoving() end end)
header:SetScript("OnDragStop", function()
  frame:StopMovingOrSizing()
  if LibWindow then LibWindow.SavePosition(frame)
  else local a,b,c,d,e = frame:GetPoint(); DB().point={a,b,c,d,e} end
end)

-- Content
local content = CreateFrame("Frame", nil, frame)
content:SetPoint("TOPLEFT", 8, -40)
content:SetPoint("BOTTOMRIGHT", -8, 8)

-- Unit label
local unitLabel = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
unitLabel:SetPoint("TOPLEFT", 0, 0)
unitLabel:SetText(L.LABEL_UNIT.." -")

-- Main header
local hdrMain = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
hdrMain:SetPoint("TOPLEFT", unitLabel, "BOTTOMLEFT", 0, -6)
hdrMain:SetText(L.HEADER_MAIN)

local sepMain = content:CreateTexture(nil, "ARTWORK")
sepMain:SetColorTexture(1,1,1,0.15)
sepMain:SetPoint("TOPLEFT", hdrMain, "BOTTOMLEFT", 0, -4)
sepMain:SetPoint("TOPRIGHT", content, "TOPRIGHT", 0, -4)
sepMain:SetHeight(1)

local hdrSec = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
hdrSec:SetPoint("TOPLEFT", sepMain, "BOTTOMLEFT", 0, -12)
hdrSec:SetText(L.HEADER_SEC)

local function NewLine(anchor)
  local fs = content:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  fs:SetJustifyH("LEFT")
  if anchor then fs:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -6)
  else fs:SetPoint("TOPLEFT", hdrSec, "BOTTOMLEFT", 0, -8) end
  return fs
end

local lines = {}
lines.m1 = content:CreateFontString(nil, "OVERLAY", "GameFontNormal"); lines.m1:SetPoint("TOPLEFT", sepMain, "BOTTOMLEFT", 0, -6)
lines.m2 = NewLine(lines.m1)
lines.m3 = NewLine(lines.m2)
lines.m4 = NewLine(lines.m3)
lines.s1 = NewLine(nil)
lines.s2 = NewLine(lines.s1)
lines.s3 = NewLine(lines.s2)
lines.s4 = NewLine(lines.s3)
lines.s5 = NewLine(lines.s4)
lines.s6 = NewLine(lines.s5)
lines.s7 = NewLine(lines.s6)
lines.s8 = NewLine(lines.s7)
lines.s9 = NewLine(lines.s8)

local note = content:CreateFontString(nil, "OVERLAY", "GameFontDisable")
note:SetPoint("BOTTOMLEFT", content, "BOTTOMLEFT", 0, 0)
note:SetText(L.NOTE_SELF)

local function RestorePosition()
  if LibWindow then
    LibWindow.RegisterConfig(frame, DB()); LibWindow.RestorePosition(frame)
    if not DB().x then frame:ClearAllPoints(); frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0) end
  else
    frame:ClearAllPoints(); local p=DB().point; frame:SetPoint(p[1],p[2],p[3],p[4],p[5])
  end
  UpdateLock()
end

----------------------------------------------------------------
-- Stats helpers
----------------------------------------------------------------
local function round2(x) return math.floor((x or 0)*100 + 0.5)/100 end
local function ratingPct(rating, pct) if pct and pct~=0 then return string.format("%d / %.2f%%", rating or 0, pct or 0) end return tostring(rating or 0) end

-- Player-only (real values incl. percent)
local CR_HIT_MELEE  = _G.CR_HIT_MELEE  or 6
local CR_HIT_RANGED = _G.CR_HIT_RANGED or 7
local CR_HIT_SPELL  = _G.CR_HIT_SPELL  or 8
local CR_MASTERY    = _G.CR_MASTERY    or 26
local CR_DODGE      = _G.CR_DODGE      or 3
local CR_PARRY      = _G.CR_PARRY      or 4
local function CRating(id) return GetCombatRating(id) or 0 end
local function CRBonus(id) return GetCombatRatingBonus(id) or 0 end

local function GetPrimaryStats_Player()
  local keys = { L.STRENGTH, L.AGILITY, L.STAMINA, L.INTELLECT }
  local out = {}
  for i=1,4 do local _,eff=UnitStat("player", i); out[i]={keys[i], eff or 0} end
  return out
end

local function GetSecondaryStats_Player()
  local hastePct = round2(GetHaste() or 0)
  local critPct  = round2(GetCritChance() or 0)
  local mastPct  = round2(GetMasteryEffect() or 0)
  local hitM, hitR, hitS = CRating(CR_HIT_MELEE), CRating(CR_HIT_RANGED), CRating(CR_HIT_SPELL)
  local hitMp, hitRp, hitSp = round2(CRBonus(CR_HIT_MELEE)), round2(CRBonus(CR_HIT_RANGED)), round2(CRBonus(CR_HIT_SPELL))
  local expR, expP = (GetCombatRating and GetCombatRating(24) or 0), round2((GetCombatRatingBonus and GetCombatRatingBonus(24)) or 0)
  local dodgeP = round2(GetDodgeChance() or 0); local parryP = round2(GetParryChance() or 0)
  local dodgeR = (GetCombatRating and GetCombatRating(CR_DODGE)) or 0
  local parryR = (GetCombatRating and GetCombatRating(CR_PARRY)) or 0
  return {
    { L.HASTE,      string.format("%.2f%%", hastePct) },
    { L.CRIT,       string.format("%.2f%%", critPct) },
    { L.MASTERY,    string.format("%.2f%%", mastPct) },
    { L.HIT_MELEE,  ratingPct(hitM, hitMp) },
    { L.HIT_RANGED, ratingPct(hitR, hitRp) },
    { L.HIT_SPELL,  ratingPct(hitS, hitSp) },
    { L.EXPERTISE,  ratingPct(expR, expP) },
    { L.DODGE,      ratingPct(dodgeR, dodgeP) },
    { L.PARRY,      ratingPct(parryR, parryP) },
  }
end

local SUM_KEYS = { "STR","AGI","STA","INT","HASTE","CRIT","MASTERY","HIT","EXPERTISE","DODGE","PARRY" }


-- Map many possible GetItemStats keys -> our buckets
local STAT_MAP = {
  -- Primary
  ITEM_MOD_STRENGTH_SHORT = "STR",       ITEM_MOD_STRENGTH = "STR",
  ITEM_MOD_AGILITY_SHORT  = "AGI",       ITEM_MOD_AGILITY  = "AGI",
  ITEM_MOD_STAMINA_SHORT  = "STA",       ITEM_MOD_STAMINA  = "STA",
  ITEM_MOD_INTELLECT_SHORT= "INT",       ITEM_MOD_INTELLECT= "INT",

  -- Haste (unified + legacy spell/melee/ranged variants)
  ITEM_MOD_HASTE_RATING_SHORT   = "HASTE", ITEM_MOD_HASTE_RATING   = "HASTE",
  ITEM_MOD_SPELL_HASTE_RATING_SHORT = "HASTE", ITEM_MOD_SPELL_HASTE_RATING = "HASTE",
  ITEM_MOD_MELEE_HASTE_RATING_SHORT = "HASTE", ITEM_MOD_MELEE_HASTE_RATING = "HASTE",
  ITEM_MOD_RANGED_HASTE_RATING_SHORT= "HASTE", ITEM_MOD_RANGED_HASTE_RATING= "HASTE",

  -- Crit (unified + legacy split)
  ITEM_MOD_CRIT_RATING_SHORT    = "CRIT",  ITEM_MOD_CRIT_RATING    = "CRIT",
  ITEM_MOD_CRIT_MELEE_RATING_SHORT = "CRIT", ITEM_MOD_CRIT_MELEE_RATING = "CRIT",
  ITEM_MOD_CRIT_RANGED_RATING_SHORT= "CRIT", ITEM_MOD_CRIT_RANGED_RATING= "CRIT",
  ITEM_MOD_CRIT_SPELL_RATING_SHORT = "CRIT", ITEM_MOD_CRIT_SPELL_RATING = "CRIT",

  -- Mastery
  ITEM_MOD_MASTERY_RATING_SHORT = "MASTERY", ITEM_MOD_MASTERY_RATING = "MASTERY",

  -- Hit (unified + legacy split)
  ITEM_MOD_HIT_RATING_SHORT     = "HIT",  ITEM_MOD_HIT_RATING     = "HIT",
  ITEM_MOD_HIT_MELEE_RATING_SHORT  = "HIT", ITEM_MOD_HIT_MELEE_RATING  = "HIT",
  ITEM_MOD_HIT_RANGED_RATING_SHORT = "HIT", ITEM_MOD_HIT_RANGED_RATING = "HIT",
  ITEM_MOD_HIT_SPELL_RATING_SHORT  = "HIT", ITEM_MOD_HIT_SPELL_RATING  = "HIT",

  -- Expertise
  ITEM_MOD_EXPERTISE_RATING_SHORT = "EXPERTISE", ITEM_MOD_EXPERTISE_RATING = "EXPERTISE",

  -- Dodge / Parry
  ITEM_MOD_DODGE_RATING_SHORT   = "DODGE", ITEM_MOD_DODGE_RATING   = "DODGE",
  ITEM_MOD_PARRY_RATING_SHORT   = "PARRY", ITEM_MOD_PARRY_RATING   = "PARRY",
}

-- Some items return "CR_XXX" style keys; normalize them too if present.
local ALT_PREFIXES = {
  ["CR_HASTE"] = "HASTE",
  ["CR_CRIT"]  = "CRIT",
  ["CR_MASTERY"]= "MASTERY",
  ["CR_HIT"]   = "HIT",
  ["CR_EXPERTISE"] = "EXPERTISE",
  ["CR_DODGE"] = "DODGE",
  ["CR_PARRY"] = "PARRY",
}

-- Slots to read when inspect is ready (exclude shirt 4, tabard 19)
local INSPECT_SLOTS = {1,2,3,5,6,7,8,9,10,11,12,13,14,15,16,17}

local function SumStatsFromGear(unit)
  local sums = {}
  for _,k in ipairs(SUM_KEYS) do sums[k] = 0 end

  for _,slot in ipairs(INSPECT_SLOTS) do
    local link = GetInventoryItemLink(unit, slot)
    if link then
      local statTbl = GetItemStats(link)
		--for k,v in pairs(statTbl) do
		--   print(k, v) -- uncomment to see tokens in chat
		--end
      if statTbl then
        -- 1) Strict map via STAT_MAP
        for token, val in pairs(statTbl) do
          local bucket = STAT_MAP[token]
          if not bucket and type(token) == "string" then
            -- 2) Fuzzy: handle keys like "CR_XXXX" or tokens without _SHORT we didn't list
            -- Try to match by ALT_PREFIXES prefix
            for prefix, bucketName in pairs(ALT_PREFIXES) do
              if token:find(prefix, 1, true) then
                bucket = bucketName
                break
              end
            end
            -- 3) Last resort: collapse well-known substrings
            if not bucket then
              local t = token
              if     t:find("STRENGTH", 1, true)  then bucket = "STR"
              elseif t:find("AGILITY", 1, true)   then bucket = "AGI"
              elseif t:find("STAMINA", 1, true)   then bucket = "STA"
              elseif t:find("INTELLECT",1, true)  then bucket = "INT"
              elseif t:find("HASTE", 1, true)     then bucket = "HASTE"
              elseif t:find("CRIT", 1, true)      then bucket = "CRIT"
              elseif t:find("MASTERY", 1, true)   then bucket = "MASTERY"
              elseif t:find("HIT", 1, true)       then bucket = "HIT"
              elseif t:find("EXPERTISE",1, true)  then bucket = "EXPERTISE"
              elseif t:find("DODGE", 1, true)     then bucket = "DODGE"
              elseif t:find("PARRY", 1, true)     then bucket = "PARRY"
              end
            end
          end

          if bucket and type(val) == "number" then
            sums[bucket] = (sums[bucket] or 0) + val
          end
        end
      end
    end
  end

  return sums
end

-- Build UI lines for a given unit
local currentUnit = "player"
local currentGUID = nil
local function SetUnitLabel(unit)
  if UnitExists(unit) then
    local name = UnitName(unit) or "?"
    local level = UnitLevel(unit) or "?"
    unitLabel:SetText(string.format("%s %s (Lv%d)", L.LABEL_UNIT, name, level))
  else
    unitLabel:SetText(L.LABEL_UNIT.." -")
  end
end

local function RefreshForPlayer()
  note:SetText(L.NOTE_SELF)
  local m = GetPrimaryStats_Player()
  lines.m1:SetText(string.format("%s: %d", m[1][1], m[1][2]))
  lines.m2:SetText(string.format("%s: %d", m[2][1], m[2][2]))
  lines.m3:SetText(string.format("%s: %d", m[3][1], m[3][2]))
  lines.m4:SetText(string.format("%s: %d", m[4][1], m[4][2]))
  local s = GetSecondaryStats_Player()
  for i=1,9 do local t=s[i]; lines["s"..i]:SetText(string.format("%s: %s", t[1], t[2])) end
end

local function RefreshForOther(unit)
  note:SetText(L.NOTE_OTHER)
  local sum = SumStatsFromGear(unit)
  -- main
	lines.m1:SetText(string.format("%s: %d", L.STRENGTH,  sum.STR or 0))
	lines.m2:SetText(string.format("%s: %d", L.AGILITY,   sum.AGI or 0))
	lines.m3:SetText(string.format("%s: %d", L.STAMINA,   sum.STA or 0))
	lines.m4:SetText(string.format("%s: %d", L.INTELLECT, sum.INT or 0))
  -- secondary (ratings only)
	lines.s1:SetText(string.format("%s: %d", L.HASTE,     sum.HASTE or 0))
	lines.s2:SetText(string.format("%s: %d", L.CRIT,      sum.CRIT or 0))
	lines.s3:SetText(string.format("%s: %d", L.MASTERY,   sum.MASTERY or 0))
	lines.s4:SetText(string.format("%s: %d", L.HIT_MELEE, sum.HIT or 0))
	lines.s5:SetText(string.format("%s: %d", L.HIT_RANGED,sum.HIT or 0))
	lines.s6:SetText(string.format("%s: %d", L.HIT_SPELL, sum.HIT or 0))
	lines.s7:SetText(string.format("%s: %d", L.EXPERTISE, sum.EXPERTISE or 0))
	lines.s8:SetText(string.format("%s: %d", L.DODGE,     sum.DODGE or 0))
	lines.s9:SetText(string.format("%s: %d", L.PARRY,     sum.PARRY or 0))

end

local function Refresh()
  SetUnitLabel(currentUnit)
  if currentUnit == "player" then
    RefreshForPlayer()
  else
    RefreshForOther(currentUnit)
  end
end

----------------------------------------------------------------
-- Events: auto-inspect + open
----------------------------------------------------------------
local ev = CreateFrame("Frame")
ev:RegisterEvent("ADDON_LOADED")
ev:RegisterEvent("PLAYER_LOGIN")
ev:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
ev:RegisterEvent("UNIT_STATS")
ev:RegisterEvent("COMBAT_RATING_UPDATE")
ev:RegisterEvent("MASTERY_UPDATE")
ev:RegisterEvent("PLAYER_DAMAGE_DONE_MODS")
ev:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
ev:RegisterEvent("INSPECT_ITEMFRAME_UPDATED") -- arg1 = guid of inspected unit

ev:SetScript("OnEvent", function(_, event, arg1)
  if event == "ADDON_LOADED" and (arg1 == ADDON_NAME or true) then
    if LibWindow then LibWindow.RegisterConfig(frame, DB()); LibWindow.RestorePosition(frame)
    else local p=DB().point; frame:ClearAllPoints(); frame:SetPoint(p[1],p[2],p[3],p[4],p[5]) end
    UpdateLock()
    if DB().shown then frame:Show(); currentUnit="player"; Refresh() end

  elseif event == "PLAYER_LOGIN" then
    RestorePosition()

  elseif event == "INSPECT_FRAME_SHOWN" then
    -- If we target a player we can inspect, request inspection and auto-open
    if UnitIsPlayer("target") and CanInspect("target") and not InCombatLockdown() then
      NotifyInspect("target")
      -- auto-open
      frame:Show(); DB().shown = true
    end

  elseif event == "INSPECT_ITEMFRAME_UPDATED" then
    -- Inspection data is now available for a GUID; prefer target/mouseover match
    local guid = arg1
    if guid and UnitGUID("target") == guid then
      currentUnit = "target"
    elseif guid and UnitGUID("mouseover") == guid then
      currentUnit = "mouseover"
    else
      -- Fallback: keep player
      currentUnit = "player"
    end
    currentGUID = guid
    Refresh()

  else
    -- Any change that affects local stats
    if frame:IsShown() then
      if currentUnit == "player" then Refresh() end
    end
  end
end)

----------------------------------------------------------------
-- Slash: /tistats
----------------------------------------------------------------
SLASH_TINYINSPECT_UNITSTATS1 = "/tistats"
SlashCmdList["TINYINSPECT_UNITSTATS"] = function()
  if frame:IsShown() then frame:Hide(); DB().shown=false
  else frame:Show(); DB().shown=true; Refresh() end
end

----------------------------------------------------------------
-- Optional: add a tiny button into TinyInspect UI if present
----------------------------------------------------------------
local function TryAttachButton()
  local host = _G.TinyInspectFrame or _G.TinyInspectRaidFrame or _G.TinyInspectMainFrame
  if not host or host.__tiStatsBtn then return end
  local btn = CreateFrame("Button", nil, host, "UIPanelButtonTemplate")
  btn:SetSize(60, 20); btn:SetText("Stats")
  btn:SetPoint("TOPRIGHT", host, "TOPRIGHT", -8, -8)
  btn:SetScript("OnClick", function()
    if frame:IsShown() then frame:Hide(); DB().shown=false else frame:Show(); DB().shown=true; Refresh() end
  end)
  host.__tiStatsBtn = btn
end
C_Timer.After(2, TryAttachButton)
